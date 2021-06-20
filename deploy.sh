docker build -t mayoko33/multi-client:latest -t mayoko33/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mayoko33/multi-server:latest -t mayoko33/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mayoko33/multi-worker:latest -t mayoko33/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mayoko33/multi-client:latest
docker push mayoko33/multi-server:latest
docker push mayoko33/multi-worker:latest

docker push mayoko33/multi-client:$SHA
docker push mayoko33/multi-server:$SHA
docker push mayoko33/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mayoko33/multi-server:$SHA
kubectl set image deployments/client-deployment client=mayoko33/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mayoko33/multi-worker:$SHA