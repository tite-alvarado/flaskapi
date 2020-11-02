minikube config set driver docker
minikube start --driver=docker --addons helm-tiller # --addons dashboard
minikube docker-env
# env to k8s docker registry
eval $(minikube -p minikube docker-env)

# info
minikube status
kubectl config view
kubectl get nodes
kubectl get pods --all-namespaces

# helm repo add stable https://charts.helm.sh/stable

# build and expose
docker-compose build
# kubectl apply -f flaskapp/templates/deployment.yaml
# kubectl expose deployment/flaskapp --name=flaskapp

# install to k8s with helm
helm lint flaskapp && \
helm package flaskapp && \
helm install --dry-run --debug flaskapp flaskapp-0.1.0.tgz && \
helm install flaskapp flaskapp-0.1.0.tgz

sleep 30 # docker start_period
echo ' >> sleep while starting ...'

helm list
kubectl get deployments
kubectl get services
kubectl describe service flaskapp

echo ' >> testing  ...'
# test pod from itself
kubectl get pods | awk '/^flaskapp/ {print $1}' | xargs -I % kubectl exec --stdin --tty % -- /bin/sh /app/tests.sh 2>/dev/null

echo '

  # for manual testing...
  # test from pod in cluster
  ## kubectl run -it --rm --tty --image=alpine:3.5 alpine-shell -- /bin/sh
  ## / wget -q0- <flaskapp_cluster_ip>:5000/health

  # test from workstation with port-forwarding
  ## kubectl port-forward deployment/flaskapp 5000 5000 &
  ## sh tests.sh
'
# minikube dashboard # optional
