# Flask API

## Small codec API

### RUN IT:

#### Flask Native
```
flask run
sh tests.sh
```

#### With docker, compose, swarm native
```
docker-compose build && docker-compose up -d
```

```
docker swarm init ; docker stack deploy --compose-file docker-compose.yml flaskapp
```

```
docker logs -f flaskapp
```

##### TEAR DOWN:
```
docker-compose down
```

```
docker stack rm flaskapp ; docker swarm leave --force
```

#### With Kubernetes

Based on `minikube` and `helm`

* Install minikube for your distro, eg on OSX with brew `brew install minikube`
* Install helm, eg `brew install helm`
* `sh minik8s.sh` to setup a cluster and deploy locally built image

##### TEAR DOWN:
```
helm uninstall flaskapp
minikube delete
```

### TEST IT:

From pod itself
```
docker exec -ti <flaskapp> sh /app/tests.sh
```
```
kubectl get pods | awk '/^flaskapp/ {print $1}' | \
xargs -I % kubectl exec --stdin --tty % -- /bin/sh /app/tests.sh 2>/dev/null
```
From pod in cluster
```
kubectl run -it --rm --tty --image=alpine:3.5 alpine-shell -- /bin/sh
# / wget -q0- <flaskapp_cluster_ip>:5000/health
```
From workstation with port-forwarding
```
kubectl port-forward deployment/flaskapp 5000 5000 &
sh tests.sh
```

### SEE LOGS:
```
docker logs -f <flaskapp>
```

```
kubectl logs pod <flaskapp_pod>
```
