docker build -t api-app-image .
docker rm -f api-app
docker run -d --name api-app -p 5000:5000 api-app-image 
