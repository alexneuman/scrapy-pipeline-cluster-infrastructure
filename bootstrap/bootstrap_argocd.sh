#!/bin/bash

helm install argocd argo/argo-cd --namespace argocd --create-namespace | true
kubectl apply -f ../k8s/argocd/ --recursive
echo "Bootstrap Password: $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)"