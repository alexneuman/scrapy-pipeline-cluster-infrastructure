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

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sleep 35
kubectl apply -f k8s/argocd/${ENV}/ --recursive

# Patch argocd-server to enable HTTP-only if dev
if [[ "$ENV" == "dev" ]]; then
  kubectl -n argocd patch deployment argocd-server --type='json' -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--insecure"}]'
fi

echo "Bootstrap Password: $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)"
echo "port-forward cmd: kubectl port-forward svc/ingress-nginx-controller -n ingress-nginx 8085:80"
