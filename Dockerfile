FROM nohaapav/alpine:1.0
MAINTAINER Pavol Noha <pavol.noha@gmail.com>

# Add nginx & curl

RUN apk add --no-cache curl nginx && \
    chown -R nginx:www-data /var/lib/nginx

# Add ep

RUN curl -sLo /usr/local/bin/ep https://github.com/kreuzwerker/envplate/releases/download/v0.0.8/ep-linux && \
    chmod +x /usr/local/bin/ep

ADD root /

EXPOSE 80 443
