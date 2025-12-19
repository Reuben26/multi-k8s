docker build -t ruyao2k/multi-client:latest -t ruyao2k/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ruyao2k/multi-server:latest -t ruyao2k/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ruyao2k/multi-worker:latest -t ruyao2k/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ruyao2k/multi-client:latest
docker push ruyao2k/multi-server:latest
docker push ruyao2k/multi-worker:latest

docker push ruyao2k/multi-client:$SHA
docker push ruyao2k/multi-server:$SHA
docker push ruyao2k/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ruyao2k/multi-server:$SHA
kubectl set image deployments/client-deployment client=ruyao2k/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ruyao2k/multi-worker:$SHA
