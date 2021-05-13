FROM alpine:3.12

MAINTAINER Will <826895143@qq.com>

RUN set -ex \
    && apk add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*

# 安装 bash shell
RUN apk update \
    && apk upgrade \
    && apk add bash \
    && apk add bash-doc \
    && apk add bash-completion
# 安装常用网络连接工具
RUN sed -i 's@http://dl-cdn.alpinelinux.org/@https://mirrors.aliyun.com/@g' /etc/apk/repositories
RUN apk add --no-cache --virtual .persistent-deps \
                curl \
		        tcpdump \
                iproute2 \
                bind-tools \
                ethtool \
                busybox-extras \
                libressl \
                openssh-client \
		        busybox \
		        vim \
		        openssh

# 暴漏端口号
EXPOSE 22
EXPOSE 80
EXPOSE 8080

CMD  [ "tail", "-f" ]