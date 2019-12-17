docker build -t kghussein/multi-client:latest -t kghussein/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kghussein/multi-server:latest -t kghussein/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kghussein/multi-worker:latest -t kghussein/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push -t kghussein/multi-client:latest
docker push -t kghussein/multi-server:latest
docker push -t kghussein/multi-worker:latest
docker push -t kghussein/multi-client:$SHA
docker push -t kghussein/multi-server:$SHA
docker push -t kghussein/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kghussein/multi-server:$SHA
kubectl set image deployments/client-deployment client=kghussein/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kghussein/multi-worker:$SHA