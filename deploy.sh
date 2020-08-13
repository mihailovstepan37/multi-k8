docker build -t diesel457/multi-client:latest -t diesel457/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t diesel457/multi-server:latest -t diesel457/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t diesel457/multi-worker:latest -t diesel457/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push -t diesel457/multi-client:latest
docker push -t diesel457/multi-server:latest
docker push -t diesel457/multi-worker:latest

docker push -t diesel457/multi-client:$SHA
docker push -t diesel457/multi-server:$SHA
docker push -t diesel457/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=diesel457/multi-server:$SHA
kubectl set image deployments/client-deployment client=diesel457/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=diesel457/multi-worker:$SHA
