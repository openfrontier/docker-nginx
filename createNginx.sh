#!/bin/bash
set -e
GERRIT_NAME=${GERRIT_NAME:-gerrit}
JENKINS_NAME=${JENKINS_NAME:-jenkins-master}
NGINX_IMAGE_NAME=${NGINX_IMAGE_NAME:-nginx}
NGINX_NAME=${NGINX_NAME:-nginx-proxy}
PROXY_CONF=proxy.conf

# Setup proxy URI
sed "s/{GERRIT_URI}/${GERRIT_NAME}/g" ~/nginx-docker/${PROXY_CONF}.template > ~/nginx-docker/${PROXY_CONF}
sed -i "s/{JENKINS_URI}/${JENKINS_NAME}/g" ~/nginx-docker/${PROXY_CONF}

# Start proxy
docker run --name ${NGINX_NAME} --link ${GERRIT_NAME}:${GERRIT_NAME} --link ${JENKINS_NAME}:${JENKINS_NAME} -p 80:80 -v ~/nginx-docker/${PROXY_CONF}:/etc/nginx/conf.d/proxy.conf:ro -d ${NGINX_IMAGE_NAME}

