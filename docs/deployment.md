## Install Cert Manager

helm repo add jetstack https://charts.jetstack.io

helm upgrade --install cert-manager \
  jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --values helm/cert-manager/values.yaml