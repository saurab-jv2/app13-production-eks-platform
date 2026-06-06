#!/bin/bash

set -e

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress \
  --create-namespace \
  -f helm/ingress-nginx/values.yaml

kubectl get pods -n ingress
kubectl get svc -n ingress