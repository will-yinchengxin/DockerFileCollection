FROM harbor.duomai.com/library/php:latest

MAINTAINER Will <826895143@qq.com>

ENV PHP_XDEBUG_VERSION 2.9.5
# 设置php配置文件位置
# ENV PHP_CONF_PATH ''

RUN set -ex \
    && apk update \
    && apk add --virtual .build-deps \
        autoconf \
        bison \
        coreutils \
        curl \
        curl-dev \
        dpkg \
        dpkg-dev \
        file \
        gcc \
        g++ \
        libc-dev \
        linux-headers \
        make \
        re2c \
    \
    && cd "/usr/src" \
    && curl -SL "https://pecl.php.net/get/xdebug-${PHP_XDEBUG_VERSION}.tgz" -o "php-xdebug.tar.gz" \
    && tar xvf "php-xdebug.tar.gz" -C /usr/src \
    && cd "/usr/src/xdebug-${PHP_XDEBUG_VERSION}" \
    \
    && phpize \
    && ./configure --with-php-config=`which php-config` \
    && make \
    && make install \
    && make clean \
    \
    && echo 'zend_extension="xdebug.so"' >> "${PHP_CONF_PATH}/php.ini" \
    \
    && apk del .build-deps \
    && rm -rf /usr/src/* \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*
