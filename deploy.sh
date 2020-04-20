docker build -t jeffvh/k8s-multi-client:latest -t jeffvh/k8s-multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jeffvh/k8s-multi-server:latest -t jeffvh/k8s-multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jeffvh/k8s-multi-worker:latest -t jeffvh/k8s-multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jeffvh/k8s-multi-client:latest
docker push jeffvh/k8s-multi-server:latest
docker push jeffvh/k8s-multi-worker:latest

docker push jeffvh/k8s-multi-client:$SHA
docker push jeffvh/k8s-multi-server:$SHA
docker push jeffvh/k8s-multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jeffvh/k8s-multi-server:$SHA
kubectl set image deployments/client-deployment client=jeffvh/k8s-multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jeffvh/k8s-multi-worker:$SHA