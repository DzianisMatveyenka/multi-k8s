docker build -t dzianismatveyenka/multi-client:latest -t dzianismatveyenka/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dzianismatveyenka/multi-server:latest -t dzianismatveyenka/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dzianismatveyenka/multi-worker:latest -t dzianismatveyenka/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dzianismatveyenka/multi-client:latest
docker push dzianismatveyenka/multi-server:latest
docker push dzianismatveyenka/multi-worker:latest
docker push dzianismatveyenka/multi-client:$SHA
docker push dzianismatveyenka/multi-server:$SHA
docker push dzianismatveyenka/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dzianismatveyenka/multi-server:latest
kubectl set image deployments/client-deployment client=dzianismatveyenka/multi-client:latest
kubectl set image deployments/worker-deployment worker=dzianismatveyenka/multi-worker:latest