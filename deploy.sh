docker build -t dcgator8/todo-client_k8:latest -t dcgator8/todo-client_k8:$SHA -f ./client/Dockerfile ./client
docker build -t dcgator8/todo-server_k8:latest -t dcgator8/todo-server_k8:$SHA -f ./server/Dockerfile ./server
docker build -t dcgator8/todo-worker_k8:latest -t dcgator8/todo-worker_k8:$SHA -f ./worker/Dockerfile ./worker
docker push dcgator8/todo-client_k8:latest
docker push dcgator8/todo-client_k8:$SHA
docker push dcgator8/todo-server_k8:latest
docker push dcgator8/todo-server_k8:$SHA
docker push dcgator8/todo-worker_k8:latest
docker push dcgator8/todo-worker_k8:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dcgator8/todo-server_k8:$SHA
kubectl set image deployments/client-deployment client=dcgator8/todo-client_k8:$SHA
kubectl set image deployments/worker-deployment worker=dcgator8/todo-worker_k8:$SHA