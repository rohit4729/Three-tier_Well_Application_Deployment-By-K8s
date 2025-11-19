docker compose build --no-cache
docker compose up -d


if you want to view the log

docker logs -f user-service
docker logs -f auth-service


to test 

http://localhost:8080/signup.html
http://localhost:8080/login.html



kubernetes


 docker build -t vipinde/user-service:latest
  597  docker push vipinde/user-service:latest
  598  docker build -t vipinde/auth-service:latest ./auth-service
  599  docker push vipinde/auth-service:latest
  600  docker build -t vipinde/web-frontend:latest ./web-frontend
  601  docker push vipinde/web-frontend:latest
  602  cd k8s/
  603  vi namespace.yaml
  604  ls
  605  vi auth-service.yaml
  606  vi mongo.yaml
  607  ls
  608  vi user-service.yaml
  609  vi ingress.yaml
  610  vi web-frontend.yaml
  611  kubectl apply -f k8s/namespace.yaml
  612  kubectl apply -f k8s/mongo.yaml
  613  kubectl apply -f k8s/user-service.yaml
  614  kubectl apply -f k8s/auth-service.yaml
  615  kubectl apply -f k8s/web-frontend.yaml
  616  kubectl apply -f k8s/ingress.yaml
  617  cd ..
  618  kubectl apply -f k8s/namespace.yaml
  619  kubectl apply -f k8s/mongo.yaml
  620  kubectl apply -f k8s/user-service.yaml
  621  kubectl apply -f k8s/auth-service.yaml
  622  kubectl apply -f k8s/web-frontend.yaml
  623  kubectl apply -f k8s/ingress.yaml
  624  kubectl get svc
  625  docker ps
  626  kubectl -n micro-auth port-forward svc/web-frontend 8080:80
  627  history

