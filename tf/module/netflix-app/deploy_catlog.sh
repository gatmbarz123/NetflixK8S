#!/bin/bash 
apt update 
apt install -y docker.io
systemctl start docker
systemctl enable docker
docker pull keretdodor/netflix-catalog
docker run -d --name netflix_catlog -p 8080:8080 keretdodor/netflix-catalog
