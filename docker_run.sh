#!/bin/bash
tag='jojoli97/drf-api-example:latest'

docker build . --tag ${tag} && \
docker run -p 8001:8000 -it ${tag}
