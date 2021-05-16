FROM alpine:latest

MAINTAINER cavemandaveman <cavemandaveman@pm.me>

RUN apk add --no-cache \
    iproute2 \
    openconnect \
    dante-server \
    tinyproxy

COPY sockd.conf /etc/sockd.conf
COPY tinyproxy.conf /etc/tinyproxy/tinyproxy.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 1080 8888

ENTRYPOINT ["/entrypoint.sh"]
