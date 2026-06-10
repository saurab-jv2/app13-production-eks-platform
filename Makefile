.PHONY: \
	apply-namespaces \
	install-metrics-server \
	deploy-nginx \
	deploy-ingress \
	install-cert-manager \
	apply-clusterissuer-letsencrypt \
	get-all \
	deploy

apply-namespaces:
	kubectl apply -f kubernetes/namespaces/

install-metrics-server:
	kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

deploy-nginx:
	kubectl apply -f kubernetes/applications/nginx/

deploy-ingress:
	./scripts/install-ingress-nginx.sh

install-cert-manager:
	./scripts/install-cert-manager.sh

apply-clusterissuer-letsencrypt:
	kubectl apply -f kubernetes/tls/clusterissuer-letsencrypt.yaml

deploy: apply-namespaces install-metrics-server deploy-nginx deploy-ingress install-cert-manager apply-clusterissuer-letsencrypt

get-all:
	kubectl get all -A