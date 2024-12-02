#!/bin/bash 
apt update 
apt install -y docker.io
systemctl start docker
systemctl enable docker
docker pull diskoproject/netflix:v1.0.12
docker run -d --name netflix_app -e MOVIE_CATALOG_SERVICE=http://${ip_private}:8080 -p 3000:3000 diskoproject/netflix:v1.0.12
