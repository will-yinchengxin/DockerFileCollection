FROM alpine:3.10

MAINTAINER Will <826895143@qq.com>

ENV PHP_VERSION 7.3.15
ENV SWOOLE_VERSION 4.4.16
ENV PHP_PHALCON_VERSION 3.4.5
ENV PHP_REDIS_VERSION 5.2.0
ENV PHP_MONGODB_VERSION 1.7.4
ENV PHP_GRPC_VERSION 1.27.0
ENV PHP_KAFKA_VERSION 4.0.3
ENV PHP_IMAGICK_VERSION 3.4.4

ENV PHP_HOME "/usr/local/php"
ENV PHP_CONF_PATH "${PHP_HOME}/etc"
ENV PHP_EXTRA_CONF_PATH "${PHP_CONF_PATH}/conf.d"


RUN set -ex \
    && apk update \
    && apk add --virtual .build-deps \
        autoconf \
        bash \
        bison \
        coreutils \
        curl \
        curl-dev \
        dpkg \
        dpkg-dev \
        file \
        gcc \
        gettext-dev \
        git \
        g++ \
        imagemagick-dev \
        libc-dev \
        libedit-dev \
        libxml2-dev \
        librdkafka-dev \
        linux-headers \
        libpng-dev \
        libsodium-dev \
        libzip-dev \
        make \
        oniguruma-dev \
        openssl-dev \
        pcre-dev \
        postgresql-dev \
        pkgconf \
        re2c \
        sqlite-dev \
        tar \
        xz \
        zlib-dev \
    \
    && mkdir -p "/usr/src" \
    && curl -SL "http://php.net/get/php-${PHP_VERSION}.tar.gz/from/this/mirror" -o php.tar.gz \
    \
    && tar xvf php.tar.gz -C /usr/src \
    && rm -rf php.tar.gz* \
    \
    && mkdir -p "${PHP_HOME}" \
    && mkdir -p "${PHP_EXTRA_CONF_PATH}" \
    \
    && export CFLAGS="-fstack-protector-strong -fpic -fpie -O2" \
    && export CPPFLAGS="-fstack-protector-strong -fpic -fpie -O2" \
    && export LDFLAGS="-Wl,-O1 -Wl,--hash-style=both -pie" \
    \
    && apk add --virtual .runtime-deps \
        ca-certificates \
        git \
        openssl \
    \
    && cd "/usr/src/php-${PHP_VERSION}" \
    && ./configure \
        --build="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
        --prefix="${PHP_HOME}" \
        --with-config-file-path="${PHP_CONF_PATH}" \
        --with-config-file-scan-dir="${PHP_EXTRA_CONF_PATH}" \
        \
        --bindir="${PHP_HOME}/bin" \
        --sbindir="${PHP_HOME}/sbin" \
        --includedir="${PHP_HOME}/include" \
        --libdir="${PHP_HOME}/lib" \
        \
        --enable-fpm \
        --disable-cgi \
        \
        --with-curl \
        --with-gettext \
        --with-gd \
        --with-iconv \
        --with-mysqli \
        --with-openssl \
        --with-pdo-mysql=mysqlnd \
        --with-pdo-pgsql \
        --with-pgsql \
        --with-sodium \
        --with-zlib \
        \
        --enable-bcmath \
        --enable-exif \
        --enable-ftp \
        --enable-mbregex \
        --enable-mbstring \
        --enable-mysqlnd \
        --enable-opcache \
        --enable-pcntl \
        --enable-sockets \
        \
        --enable-fileinfo \
    \
    && make -j "$(nproc)" \
    && make install \
    && make clean \
    \
    && echo 'zend_extension="opcache.so"' >> "${PHP_CONF_PATH}/php.ini" \
    && export PATH="${PHP_HOME}/bin:${PHP_HOME}/sbin:${PATH}" \
    \
    \
    \
    && cd "/usr/src" \
    && git clone --depth=1 "https://github.com/jbboehr/php-psr.git" \
    \
    && cd "/usr/src/php-psr" \
    && phpize \
    && ./configure \
    && make \
    && make test \
    && make install \
    && make clean \
    \
    && echo 'extension="psr.so"' >> "${PHP_CONF_PATH}/php.ini" \
    \
    \
    \
    && cd "/usr/src" \
    && curl -SL "https://pecl.php.net/get/redis-${PHP_REDIS_VERSION}.tgz" -o "php-redis.tar.gz" \
    && tar xvf "php-redis.tar.gz" -C /usr/src \
    && cd "/usr/src/redis-${PHP_REDIS_VERSION}" \
    \
    && phpize \
    && ./configure --with-php-config=`which php-config` \
    && make \
    && make install \
    && make clean \
    \
    && echo 'extension="redis.so"' >> "${PHP_CONF_PATH}/php.ini" \
    \
    \
    \
    && cd "/usr/src" \
    && curl -SL "https://pecl.php.net/get/mongodb-${PHP_MONGODB_VERSION}.tgz" -o "php-mongodb.tar.gz" \
    && tar xvf "php-mongodb.tar.gz" -C /usr/src \
    && cd "/usr/src/mongodb-${PHP_MONGODB_VERSION}" \
    \
    && phpize \
    && ./configure --with-php-config=`which php-config` \
    && make \
    && make install \
    && make clean \
    \
    && echo 'extension="mongodb.so"' >> "${PHP_CONF_PATH}/php.ini" \
    \
    \
    \
    && cd "/usr/src" \
    && curl -SL "https://pecl.php.net/get/grpc-${PHP_GRPC_VERSION}.tgz" -o "php-grpc.tar.gz" \
    && tar xvf "php-grpc.tar.gz" -C /usr/src \
    && cd "/usr/src/grpc-${PHP_GRPC_VERSION}" \
    \
    && phpize \
    && ./configure --with-php-config=`which php-config` \
    && make \
    && make install \
    && make clean \
    \
    && echo 'extension="grpc.so"' >> "${PHP_CONF_PATH}/php.ini" \
    \
    \
    \
    && cd "/usr/src" \
    && curl -SL "http://pecl.php.net/get/swoole-${SWOOLE_VERSION}.tgz" -o swoole.tgz \
    && tar xf swoole.tgz -C /usr/src \
    && cd "/usr/src/swoole-${SWOOLE_VERSION}" \
    \
    && phpize \
    && ./configure --with-php-config=`which php-config` \
        --enable-openssl  \
        --enable-http2  \
        --enable-sockets \
        --enable-mysqlnd \
    && make \
    && make install \
    && make clean \
    \
    && echo 'extension="swoole.so"' >> "${PHP_CONF_PATH}/php.ini" \
    \
    \
    \
    && cd "/usr/src" \
    && curl -SL "http://codeload.github.com/phalcon/cphalcon/tar.gz/v${PHP_PHALCON_VERSION}" -o phalcon.tar.gz \
    && tar xvf phalcon.tar.gz -C /usr/src \
    && cd "/usr/src/cphalcon-${PHP_PHALCON_VERSION}/build" \
    \
    && ./install \
    \
    && echo 'extension="phalcon.so"' >> "${PHP_CONF_PATH}/php.ini" \
    \
    \
    \
    && cd "/usr/src" \
    && curl -SL "http://pecl.php.net/get/rdkafka-${PHP_KAFKA_VERSION}.tgz" -o rdkafka.tar.gz \
    && tar xvf rdkafka.tar.gz -C /usr/src \
    && cd "/usr/src/rdkafka-${PHP_KAFKA_VERSION}" \
    \
    && phpize \
    && ./configure --with-php-config=`which php-config` \
    && make \
    && make install \
    && make clean \
    \
    && echo 'extension="rdkafka.so"' >> "${PHP_CONF_PATH}/php.ini" \
    \
    \
    \
    && cd "/usr/src" \
    && curl -SL "http://pecl.php.net/get/imagick-${PHP_IMAGICK_VERSION}.tgz" -o imagick.tar.gz \
    && tar xvf imagick.tar.gz -C /usr/src \
    && cd "/usr/src/imagick-${PHP_IMAGICK_VERSION}" \
    \
    && phpize \
    && ./configure --with-php-config=`which php-config` \
    && make \
    && make install \
    && make clean \
    \
    && echo 'extension="imagick.so"' >> "${PHP_CONF_PATH}/php.ini" \
    \
    \
    \
    && cd "${PHP_HOME}" \
    && { find . -type f -exec strip --strip-all {} + || true; } \
    && PHP_RUNTIME_DEPS="$( \
        scanelf --needed --nobanner --format '%n#p' --recursive ${PHP_HOME} \
            | tr ',' '\n' \
            | sort -u \
            | awk 'system("[ -e /usr/local/lib" $1 " ]") == 0 { next } { print "so:" $1 }' \
    )" \
    && apk add --virtual .php-runtime-deps ${PHP_RUNTIME_DEPS} \
    && apk del .build-deps \
    \
    && rm -rf /usr/src/* \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*

RUN set -ex \
    && cd ${PHP_CONF_PATH} \
    && if [ -d php-fpm.d ]; then \
           cp php-fpm.conf.default php-fpm.conf; \
           cp php-fpm.d/www.conf.default php-fpm.d/www.conf; \
       else \
           mkdir php-fpm.d; \
           cp php-fpm.conf.default php-fpm.d/www.conf; \
           { \
               echo '[global]'; \
           	   echo 'include=etc/php-fpm.d/*.conf'; \
           } | tee php-fpm.conf; \
       fi; \
    \
       { \
           echo '[global]'; \
           echo 'error_log = /proc/self/fd/2'; \
           echo; \
           echo '[www]'; \
           echo '; if we send this to /proc/self/fd/1, it never appears'; \
           echo 'access.log = /proc/self/fd/2'; \
           echo; \
           echo 'clear_env = no'; \
           echo; \
           echo '; Ensure worker stdout and stderr are sent to the main error log.'; \
           echo 'catch_workers_output = yes'; \
       } | tee php-fpm.d/docker.conf \
    && { \
           echo '[global]'; \
           echo 'daemonize = no'; \
           echo; \
           echo '[www]'; \
           echo 'listen = [::]:9000'; \
       } | tee php-fpm.d/zzz.conf

ENV PATH "${PHP_HOME}/bin:${PHP_HOME}/sbin:${PATH}"

RUN set -ex \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/bin --filename=composer \
    && php -r "unlink('composer-setup.php');" \
    \
    && rm -rf /usr/src/* \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*


WORKDIR /var/www
CMD ["php-fpm"]
