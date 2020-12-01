# Simple_Web_App

for ingress 

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm install my-release ingress-nginx/ingress-nginx

docker build -t bobakos85/simplewebapp:latest .