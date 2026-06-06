#!/bin/bash
set -e

echo "Adding Jetstack Helm repo..."
helm repo add jetstack https://charts.jetstack.io
helm repo update

echo "Installing cert-manager..."
helm upgrade --install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --set crds.enabled=true

echo "Waiting for cert-manager pods..."
kubectl wait --for=condition=Ready pods -n cert-manager --all --timeout=120s

echo "cert-manager installed successfully"
kubectl get pods -n cert-manager