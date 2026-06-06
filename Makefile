apply-namespaces:
	kubectl apply -f kubernetes/namespaces/

apply-nginx:
	kubectl apply -f kubernetes/applications/nginx/

deploy-ingress:
	./scripts/install-ingress-nginx.sh

install-cert-manager:
	./scripts/install-cert-manager.sh

get-all:
	kubectl get all -A