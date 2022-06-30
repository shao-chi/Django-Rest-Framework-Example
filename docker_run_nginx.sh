#!/bin/bash
tag='jojoli97/drf-api-nginx:latest'

docker build -f Dockerfile.nginx . --tag ${tag} && \
docker run -p 8001:80 -it ${tag}
