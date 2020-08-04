# FROM alpine:3.6
FROM python:3.7.6-alpine

LABEL maintainer="buutuud@gmail.com"

ENV SS_SERVER_ADDR=0.0.0.0 \
    SS_SERVER_PORT=10804 \
    SS_PASSWORD=ssp@ss \
    SS_METHOD=aes-256-cfb \
    SS_TIMEOUT=300

RUN apk add --update --no-cache --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ --allow-untrusted libressl2.6-libcrypto libsodium \
    && apk add --no-cache --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted shadowsocks-libev

EXPOSE ${SS_SERVER_PORT}/tcp ${SS_SERVER_PORT}/udp

ENTRYPOINT /usr/bin/ss-server -s ${SS_SERVER_ADDR} -p ${SS_SERVER_PORT} -k ${SS_PASSWORD} -m ${SS_METHOD} -t ${SS_TIMEOUT}