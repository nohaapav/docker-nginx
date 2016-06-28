FROM nohaapav/alpine:1.0
MAINTAINER Pavol Noha <pavol.noha@gmail.com>

# Add nginx
RUN apk add --no-cache nginx && \
    chown -R nginx:www-data /var/lib/nginx

ADD root /

EXPOSE 80 443


