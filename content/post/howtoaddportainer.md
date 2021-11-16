+++
description = "Steps to configure portainer"
title = "How to add portainer for monitoring dockers"
date = 2021-10-21T15:56:18+08:00
tags = ["docker", "portainer", "nginx", "reverse proxy"]
author = "Ken Cho"
+++  

### Task
1. Make portainer on staging and live deployment accessible with HTTPS on default port [#790](https://github.com/gigascience/gigadb-website/issues/790)
2. Add portainer container service on staging and live deployment [#791](https://github.com/gigascience/gigadb-website/issues/791)
3. [PR #201](https://github.com/rija/gigadb-website/pull/201)

### Steps
A. Add portainer service available locally  
1. Update `docker-compose.yml`
```yaml
  portainer:
    image: portainer/portainer-ce:latest
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data
    ports:
      - 9009:9000
      - 8008:8000
    command: -H unix:///var/run/docker.sock --admin-password $PORTAINER_BCRYPT
  volumes:
    le_config:
    le_webrootpath:
    portainer_data:
```
2. Create `PORTAINER_PASSWORD` in gitlab variables  
3. Create `start_portainer.sh`, `if-else` block to avoid keep generating `PORTAINER_BCRYPT` in `.env`
```shell
#!/usr/bin/env bash


# bail out as soon as there is an error
set -eux

# Load environment variables
source "./.env"
source "./.secrets"

# docker-compose executable
if [[ $GIGADB_ENV != "dev" && $GIGADB_ENV != "CI" ]];then
	DOCKER_COMPOSE="docker-compose --tlsverify -H=$REMOTE_DOCKER_HOST -f ops/deployment/docker-compose.production-envs.yml"
else
	DOCKER_COMPOSE="docker-compose"
fi

if ! [ -z "${PORTAINER_BCRYPT+x}" ];then
  echo "PORTAINER_BCRYPT value has been set in .env already"
  # start portainer in detached mode and make sure volume are recreated (rather than use potential previous state that my be erroneous)
  $DOCKER_COMPOSE up --detach --renew-anon-volumes portainer
else
  echo "PORTAINER_BCRYPT value is empty"
  echo "Generate bcrypt from password"
  P_BCRYPT=$(docker run --rm httpd:2.4-alpine htpasswd -nbB admin $PORTAINER_PASSWORD | cut -d ":" -f 2 | sed -e 's/\$/\\\$/g')
  echo "PORTAINER_BCRYPT=$P_BCRYPT" >> .env
  # start portainer in detached mode and make sure volume are recreated (rather than use potential previous state that my be erroneous)
  $DOCKER_COMPOSE up --detach --renew-anon-volumes portainer
fi
```
4. Update `up.sh` to only start portainer in MacOS
```shell
# start the container admin UI (not in CI)
if [ "$(uname)" == "Darwin" ];then
  ./ops/scripts/start_portainer.sh
fi;
```
5. Spin up all containers
```
kencho/gigadb-website % ./up.sh
```
6. Test the http response using curl
```
 % curl -I localhost:9009
HTTP/1.1 200 OK
Accept-Ranges: bytes
Cache-Control: max-age=31536000
Content-Length: 6176
Content-Type: text/html; charset=utf-8
Last-Modified: Sun, 10 Oct 2021 23:45:45 GMT
X-Content-Type-Options: nosniff
X-Xss-Protection: 1; mode=block
Date: Thu, 21 Oct 2021 08:14:01 GMT
```
7. Go to `http://localhost:9009/` and have fun!
### Reference
1. Heavily adapted form [here](https://github.com/rija/gigadb-website/pull/199)

[![Build Status](https://travis-ci.com/kencho51/gigathing.svg?branch=master)](https://travis-ci.com/kencho51/gigathing)

