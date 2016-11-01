# openfrontier/nginx
A nginx reverse proxy docker container for [Gerrit](https://registry.hub.docker.com/u/openfrontier/gerrit/) and [Jenkins](https://registry.hub.docker.com/u/openfrontier/jenkins/) docker containers.

## Prerequese
A [Gerrit](https://registry.hub.docker.com/u/openfrontier/gerrit/) container and a [Jenkins](https://registry.hub.docker.com/u/openfrontier/jenkins/) container are needed. Also,a Docker network is needed.
There's an [docker-compose project](https://github.com/openfrontier/ci-compose) which privdes sample scripts about how to use this image to create a Gerrit-Jenkins integration environment.

## Container Quickstart
    docker run \
    --name proxy \
    --net <your docker network> \
    -p 80:80 \
    -e SERVER_NAME=your.site.uri \
    -e CLIENT_MAX_BODY_SIZE= 200m \
    -d openfrontier/nginx
