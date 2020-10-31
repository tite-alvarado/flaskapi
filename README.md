# Flask API

## Small API to crypt/decrypt

### RUN IT:

#### Flask Native
`flask run`
`sh tests.sh`

#### With docker
`docker-compose build && docker-compose up -d`
`docker logs -f flaskapp`

##### TEAR DOWN:
`docker-compose down`

#### With Kubernetes

Based on `minikube` and `helm`

* Install for your distro, eg on OSX with brew `brew install minikube`
* Install helm, eg `brew install helm`
* `sh minik8s.sh` to setup a cluster and deploy locally built image

##### TEAR DOWN:
`kubectl delete -f flaskapp-chartv1.yaml`

### TEST IT:

* From pod itself
`docker exec -ti <flaskapp> sh /app/tests.sh`
```
kubectl get pods | awk '/^flaskapp/ {print $1}' | xargs -I % kubectl exec --stdin --tty % -- /bin/sh /app/tests.sh 2>/dev/null
```
* From pod in cluster
```
kubectl run -it --rm --tty --image=alpine:3.5 alpine-shell -- /bin/sh
# / wget -q0- <flaskapp_cluster_ip>:5000/health
```

### SEE LOGS:
`docker logs -f flaskapp`
`kubectl logs pod <flaskapp_pod>`
