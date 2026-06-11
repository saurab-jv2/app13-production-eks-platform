## Install Cert Manager

helm repo add jetstack https://charts.jetstack.io

helm upgrade --install cert-manager \
  jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --values helm/cert-manager/values.yaml


## Install ingress-nginx

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm upgrade --install ingress-nginx \
  ingress-nginx/ingress-nginx \
  --namespace ingress \
  --create-namespace \
  -f helm/ingress-nginx/values.yaml