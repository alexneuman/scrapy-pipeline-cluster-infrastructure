#!/bin/bash

ENV="dev"
while [[ $# -gt 0 ]]; do
  case $1 in
    --env)
      ENV="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Create namespaces
kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace argo --dry-run=client -o yaml | kubectl apply -f -

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Read the token from ../secrets/google_api_token.json
SECRET_FILE="$SCRIPT_DIR/../secrets/google_api_token.json"

if [[ ! -f "$SECRET_FILE" ]]; then
  echo "Error: $SECRET_FILE not found"
  exit 1
fi

TOKEN=$(jq -r '.token // empty' "$SECRET_FILE")

if [[ -z "$TOKEN" ]]; then
  echo "Error: token field is empty in $SECRET_FILE"
  exit 1
fi

# Create or update the configmap in the argo namespace
kubectl -n argo create configmap token-configmap --from-literal=token="$TOKEN" --dry-run=client -o yaml | kubectl apply -f -
echo "Created configmap 'token-configmap' in the argo namespace."

# Install ArgoCD
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sleep 35

# Apply environment-specific manifests
kubectl apply -f k8s/argocd/${ENV}/ --recursive

# Patch argocd-server to enable HTTP-only if dev
if [[ "$ENV" == "dev" ]]; then
  kubectl -n argocd patch deployment argocd-server \
    --type='json' \
    -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--insecure"}]'
fi

# Print bootstrap info
echo "Bootstrap Password: $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)"
echo "port-forward cmd: kubectl port-forward svc/ingress-nginx-controller -n ingress-nginx 8085:80"
