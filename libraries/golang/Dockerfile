FROM golang:1.15

MAINTAINER Will <826895143@qq.com>

USER root
COPY .netrc /root/.netrc
COPY docker /usr/bin/docker

RUN set -ex \
    && go env -w GONOPROXY=gitlab.duomai.cn \
    && go env -w GONOSUMDB=gitlab.duomai.cn \
    && go env -w GO111MODULE=on \
    && go env -w GOPROXY=https://goproxy.io,direct
