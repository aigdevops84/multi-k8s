docker build -t aizenbergivan/multi-client:latest -t aizenbergivan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aizenbergivan/multi-server:latest -t aizenbergivan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aizenbergivan/multi-worker:latest -t aizenbergivan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aizenbergivan/multi-client:latest
docker push aizenbergivan/multi-server:latest
docker push aizenbergivan/multi-worker:latest

docker push aizenbergivan/multi-client:$SHA
docker push aizenbergivan/multi-server:$SHA
docker push aizenbergivan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aizenbergivan/multi-server:$SHA
kubectl set image deployments/client-deployment client=aizenbergivan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aizenbergivan/multi-worker:$SHA