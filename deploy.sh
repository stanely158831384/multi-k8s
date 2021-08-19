docker build -t stanley158831384/multi-client-k8s:latest -t stanley158831384/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t stanley158831384/multi-server-k8s-pgfix:latest -t stanley158831384/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t stanley158831384/multi-worker-k8s:latest -t stanley158831384/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push stanley158831384/multi-client-k8s:latest
docker push stanley158831384/multi-server-k8s-pgfix:latest
docker push stanley158831384/multi-worker-k8s:latest

docker push stanley158831384/multi-client-k8s:$SHA
docker push stanley158831384/multi-server-k8s-pgfix:$SHA
docker push cygnestanley158831384tops/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stanley158831384/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=stanley158831384/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=stanley158831384/multi-worker-k8s:$SHA