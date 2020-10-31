minikube config set driver docker
minikube start --driver=docker --addons helm-tiller # --addons dashboard
minikube docker-env
# env to k8s docker registry
eval $(minikube -p minikube docker-env)

# info
minikube status
kubectl config view
kubectl get nodes
kubectl get services
kubectl get pods --all-namespaces

# heml and compose registry support
# kubectl create namespace compose
# kubectl -n kube-system create serviceaccount tiller
# kubectl -n kube-system create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount kube-system:tiller

# helm init --service-account tiller
helm install etcd-operator stable/etcd-operator --namespace compose

helm repo add stable https://charts.helm.sh/stable

# build and expose
docker-compose build
kubectl apply -f flaskapp-chartv1.yaml
# kubectl apply -f flaskapp-chartv1-service.yaml
kubectl expose deployment flaskapp --protocol=TCP --port=5000 --name=flaskapp

# test pod from itself
sleep 30 # docker start_period
kubectl get pods | awk '/^flaskapp/ {print $1}' | xargs -I % kubectl exec --stdin --tty % -- /bin/sh /app/tests.sh 2>/dev/null
# test from workstation to exposed port
# kubectl run -it --rm --tty --image=alpine:3.5 alpine-shell -- /bin/sh
# # / wget -q0- <flaskapp_cluster_ip>:5000/health

# sh tests.sh        # fails / private service
# minikube dashboard # optional
