FROM alpine:3.12

MAINTAINER Will <826895143@qq.com>

RUN set -ex \
    && apk add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*
