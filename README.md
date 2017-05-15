# docker-nginx
Lightweight Alpine s6 based Nginx with SSL termination & envplate support used primary for swarm cluster.

## Prerequisites 

* docker 1.13 + (swarm mode)
* nginx service must be in same overlay network as proxied service (DNS service discovery)
* certificate must match domain name

## Setup

1. Generate certificate
2. Create secret key ``docker secret create test.domain.com.key test.domain.com.key``
3. Create secret crt ``docker secret create test.domain.com.crt test.domain.com.crt``
4. Run
```{r, engine='bash', count_lines}
docker service create \
  --network gnet \
  --name nginx \
  --secret test.domain.com.key \
  --secret test.domain.com.crt \
  --env SERVICE_URL=service:8080 \
  --env SERVICE_DOMAIN=test.domain.com \
  --publish 80:80 \
  --publish 443:443 \
  nohaapav/nginx:latest
```
