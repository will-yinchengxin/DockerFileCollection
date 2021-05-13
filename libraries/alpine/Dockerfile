FROM alpine:3.12

MAINTAINER Will <826895143@qq.com>

RUN set -ex \
    && apk add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*

# 重置镜像源
RUN sed -i 's@http://dl-cdn.alpinelinux.org/@https://mirrors.aliyun.com/@g' /etc/apk/repositories
# 安装 bash shell
RUN apk update \
    && apk upgrade \
    && apk add bash \
    && apk add bash-doc \
    && apk add bash-completion
# 安装常用网络连接工具
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
		vim

# docker容器中开启ssh登陆，注意修改里面的root用户密码
RUN apk add openssh-server && \
    apk add openssh && \
    sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
    sed -i "s/#Port.*/Port 22/g" /etc/ssh/sshd_config && \
    ssh-keygen -t dsa -P "" -f /etc/ssh/ssh_host_dsa_key && \
    ssh-keygen -t rsa -P "" -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -t ecdsa -P "" -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -t ed25519 -P "" -f /etc/ssh/ssh_host_ed25519_key && \
    echo "root:root" | chpasswd
    
# 将默认的shell改成bash的方法:
# rm /bin/ash // alpine下默认的shell为 ash:
# ln -s /bin/bash /bin/ash

# 暴漏一些端口号
EXPOSE 22
EXPOSE 80
EXPOSE 8080

# 启动SSH
# 进入  vim /etc/ssh/ssh_config 查看/修改 配置
CMD [ "/usr/sbin/sshd" ,  "-D" ]

# 构建命令 docker build -t alpine/alpine:v1 .
# 启动容器 docker run -itd -p 8010:22 -p 8080:80 --name myAlpine alpine/alpine:v1
