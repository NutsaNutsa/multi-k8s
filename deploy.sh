docker build -t 100121144d/multi-client:latest -t 100121144d/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t 100121144d/multi-server:latest -t 100121144d/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t 100121144d/multi-worker:latest -t 100121144d/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push 100121144d/multi-client:latest
docker push 100121144d/multi-server:latest
docker push 100121144d/multi-worker:latest

docker push 100121144d/multi-client:$SHA
docker push 100121144d/multi-server:$SHA
docker push 100121144d/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=100121144/multi-server:$SHA
kubectl set image deployments/client-deployment client=100121144/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=100121144/multi-worker:$SHA