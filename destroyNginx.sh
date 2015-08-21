#!/bin/bash
NGINX_NAME=${NGINX_NAME:-proxy}
docker stop ${NGINX_NAME}
docker rm -v ${NGINX_NAME}
