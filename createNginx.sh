#!/bin/bash
set -e
GERRIT_NAME=${GERRIT_NAME:-gerrit}
JENKINS_NAME=${JENKINS_NAME:-jenkins-master}
NGINX_IMAGE_NAME=${NGINX_IMAGE_NAME:-nginx}
NGINX_NAME=${NGINX_NAME:-nginx-proxy}

docker run --name ${NGINX_NAME} --link ${GERRIT_NAME}:gerrit --link ${JENKINS_NAME}:jenkins -p 80:80 -v ~/nginx-docker/proxy.conf:/etc/nginx/conf.d/proxy.conf:ro -d ${NGINX_IMAGE_NAME}

