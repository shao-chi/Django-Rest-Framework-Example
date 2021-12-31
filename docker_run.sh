#!/bin/bash
docker build . --tag drf_api/api_example:latest && \
docker run \
    -p 8001:8000 \
    -it drf_api/api_example:latest \
    ./manage.py runserver 0.0.0.0:8000
