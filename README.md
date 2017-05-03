# docker-nginx
Simple Alpine s6 based Nginx with SSL termination & envplate support used primary for swarm cluster.

## Prerequisites 

* docker 1.13 + (swarm mode)
* nginx must be in same overlay network as proxied service (DNS service discovery)
* certificate must match domain name

## Setup

You have 3 options how to deal with setup.

### Custom image

1. Fetch repository
2. Copy ``test.domain.com.key`` and ``test.domain.com.crt`` files into ``/root/etc/nginx/certs``
3. Build image ``docker build -t custom/nginx:latest .``
4. Run
```{r, engine='bash', count_lines}
docker service create \
  --network gnet \
  --name nginx \
  --env SERVICE_URL=service:8080 \
  --env SERVICE_DOMAIN=test.domain.com \
  --publish 88:80 \
  --publish 443:443 \
  custom/nginx:latest
```

### From original image

1. Create Dockefile & certs folder containing certificate
```{r, engine='bash', count_lines}
FROM nohaapav/nginx:latest
MAINTAINER John Doe <john.doe@email.com>

# Add cert

COPY certs/cloud.csas.cz.key /etc/nginx/certs/cloud.csas.cz.key
COPY certs/cloud.csas.cz.crt /etc/nginx/certs/cloud.csas.cz.crt
```
2. Build image ``docker build -t custom/nginx:latest .``
3. Run
```{r, engine='bash', count_lines}
docker service create \
  --network gnet \
  --name nginx \
  --env SERVICE_URL=service:8080 \
  --env SERVICE_DOMAIN=test.domain.com \
  --publish 88:80 \
  --publish 443:443 \
  custom/nginx:latest
```

### Original image with volume
1. Run
```{r, engine='bash', count_lines}
docker service create \
  --network gnet \
  --name nginx \
  --mount=type=bind,src=${PWD},dst=/etc/nginx/certs \
  --env SERVICE_URL=service:8080 \
  --env SERVICE_DOMAIN=test.domain.com \
  --publish 88:80 \
  --publish 443:443 \
  nohaapav/nginx:latest
```
