docker build -t sumeetisp/multi-client:latest -t sumeetisp/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sumeetisp/multi-server:latest -t sumeetisp/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sumeetisp/multi-worker:latest -t sumeetisp/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sumeetisp/multi-client:latest
docker push sumeetisp/multi-server:latest
docker push sumeetisp/multi-worker:latest

docker push sumeetisp/multi-client:$SHA
docker push sumeetisp/multi-server:$SHA
docker push sumeetisp/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sumeetisp/multi-server:$SHA
kubectl set image deployments/client-deployment client=sumeetisp/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sumeetisp/multi-worker:$SHA
