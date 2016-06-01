#!/bin/bash
set -e
GERRIT_NAME=${GERRIT_NAME:-gerrit}
JENKINS_NAME=${JENKINS_NAME:-jenkins}
REDMINE_NAME=${REDMINE_NAME:-redmine}
NEXUS_NAME=${NEXUS_NAME:-nexus}

NGINX_IMAGE_NAME=${NGINX_IMAGE_NAME:-nginx}
NGINX_NAME=${NGINX_NAME:-proxy}
NGINX_MAX_UPLOAD_SIZE=${NGINX_MAX_UPLOAD_SIZE:-200m}

CI_NETWORK=${CI_NETWORK:-ci-network}

PROXY_CONF=proxy.conf

# Setup proxy URI
if [ ${#NEXUS_WEBURL} -eq 0 ]; then
    sed "s/{{HOST_URL}}/${HOST_NAME}/g" ~/nginx-docker/${PROXY_CONF}.nexus.template > ~/nginx-docker/${PROXY_CONF}
else
    sed "s/{{HOST_URL}}/${HOST_NAME}/g" ~/nginx-docker/${PROXY_CONF}.template > ~/nginx-docker/${PROXY_CONF}
fi
sed -i "s/{GERRIT_URI}/${GERRIT_NAME}/g" ~/nginx-docker/${PROXY_CONF}
sed -i "s/{JENKINS_URI}/${JENKINS_NAME}/g" ~/nginx-docker/${PROXY_CONF}
sed -i "s/{REDMINE_URI}/${REDMINE_NAME}/g" ~/nginx-docker/${PROXY_CONF}
sed -i "s/{NEXUS_URI}/${NEXUS_NAME}/g" ~/nginx-docker/${PROXY_CONF}
sed -i "s/{{NGINX_MAX_UPLOAD_SIZE}}/${NGINX_MAX_UPLOAD_SIZE}/g" ~/nginx-docker/${PROXY_CONF}

# Start proxy
if [ ${#NEXUS_WEBURL} -eq 0 ]; then #proxy nexus
    docker run \
    --name ${NGINX_NAME} \
    --net=${CI_NETWORK} \
    -p 80:80 \
    -v ~/nginx-docker/${PROXY_CONF}:/etc/nginx/conf.d/default.conf:ro \
    -v ~/nginx-docker/nginx-index.html:/usr/share/nginx/html/index.html:ro \
    -d ${NGINX_IMAGE_NAME}
else #without nexus
    docker run \
    --name ${NGINX_NAME} \
    --link ${GERRIT_NAME}:${GERRIT_NAME} \
    --link ${JENKINS_NAME}:${JENKINS_NAME} \
    --link ${REDMINE_NAME}:${REDMINE_NAME} \
    -p 80:80 \
    -v ~/nginx-docker/${PROXY_CONF}:/etc/nginx/conf.d/default.conf:ro \
    -v ~/nginx-docker/nginx-index.html:/usr/share/nginx/html/index.html:ro \
    -d ${NGINX_IMAGE_NAME}
fi
