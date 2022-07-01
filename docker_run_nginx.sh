#!/bin/bash
set -e

tag_api='jojoli97/drf-api-example:latest'
tag_nginx='jojoli97/drf-api-nginx:latest'
# tag_nginx='nginx'

docker build -f Dockerfile . --tag ${tag_api}
docker build -f Dockerfile.nginx . --tag ${tag_nginx}

docker network create -d bridge net1

docker run --network=net1 --name api -t ${tag_api} &
docker run --network=net1 --name nginx -p 8080:80 -t ${tag_nginx}
