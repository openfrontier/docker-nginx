#!/bin/bash
NGINX_NAME=${NGINX_NAME:-proxy}
if [ -n "$(docker ps -a | grep ${NGINX_NAME})" ]; then
  docker stop ${NGINX_NAME}
  docker rm -v ${NGINX_NAME}
fi
