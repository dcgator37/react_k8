docker build -t dcgator8/multi-client:latest -t dcgator8/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dcgator8/multi-server:latest -t dcgator8/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dcgator8/multi-worker:latest -t dcgator8/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dcgator8/multi-client:latest
docker push dcgator8/multi-client:$SHA
docker push dcgator8/multi-server:latest
docker push dcgator8/multi-server:$SHA
docker push dcgator8/multi-worker:latest
docker push dcgator8/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dcgator8/multi-server:$SHA
kubectl set image deployments/client-deployment client=dcgator8/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dcgator8/multi-worker:$SHA