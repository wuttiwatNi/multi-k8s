docker build -t flukemonkey/multi-client:latest -t flukemonkey/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t flukemonkey/multi-server:latest -t flukemonkey/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t flukemonkey/multi-worker:latest -t flukemonkey/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push flukemonkey/multi-client:latest
docker push flukemonkey/multi-server:latest
docker push flukemonkey/multi-worker:latest

docker push flukemonkey/multi-client:$SHA
docker push flukemonkey/multi-server:$SHA
docker push flukemonkey/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=flukemonkey/multi-server:$SHA
kubectl set image deployments/client-deployment client=flukemonkey/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=flukemonkey/multi-worker:$SHA