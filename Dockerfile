FROM ponycool/alpine-3.10:1.0
LABEL maintainer="SHADOWSOCKSR-V3.1.2 DOCKER MAINTAINER <pony@ponycool.com>"

ENV SSR_VER=3.1.2
ENV SERVER_ADDR=0.0.0.0
ENV SERVER_PORT=528
ENV PASSWORD=pwd
ENV METHOD=aes-256-cfb
ENV PROTOCOL=origin
ENV OBFS=plain
ENV TIMEOUT=300
ENV DNS_ADDR=1.1.1.1
ENV DNS_ADDR_2=8.8.8.8


RUN buildDeps=" \
    wget \
    " \
    runtimeDeps=" \
    python \
    bash \
    " \
    && apk update && apk upgrade \
    && apk add --no-cache $buildDeps \
    && apk add $runtimeDeps \
    && cd /usr/local \
    && wget -qO- --no-check-certificate https://github.com/shadowsocksr-backup/shadowsocksr/archive/${SSR_VER}.tar.gz | tar -xzf - -C /usr/local \
    && mv shadowsocksr-${SSR_VER} ssr \
    && cd /usr/local/ssr/shadowsocks \
    && rm -rf /var/cache/apk/* 

EXPOSE 22
EXPOSE 528

WORKDIR /usr/local/ssr/shadowsocks

CMD python server.py -p ${SERVER_PORT} -k ${PASSWORD} -m ${METHOD} -O ${PROTOCOL} -o ${OBFS}
