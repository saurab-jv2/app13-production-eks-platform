apply-namespaces:
	kubectl apply -f kubernetes/namespaces/

apply-nginx:
	kubectl apply -f kubernetes/applications/nginx/

deploy-ingress:
	./scripts/install-ingress-nginx.sh

install-cert-manager:
	./scripts/install-cert-manager.sh

apply-clusterissuer-letsencrypt:
	kubectl apply -f kubernetes/tls/clusterissuer-letsencrypt.yaml

# Self Signed Certificate 
#apply-clusterissuer-selfsigned:
#	kubectl apply -f kubernetes/tls/clusterissuer-selfsigned.yaml

get-all:
	kubectl get all -A