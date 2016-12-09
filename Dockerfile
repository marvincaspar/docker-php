FROM php:7.1-fpm
MAINTAINER Marvin Caspar: <info@marvincaspar.de>

ENV PHP_EXTRA_CONFIGURE_ARGS --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data --enable-intl --enable-opcache

RUN apt-get update && \
    apt-get install -y \
        libpng12-dev \
        libjpeg-dev \
        libmcrypt-dev \
        libxml2-dev \
        freetype* \
        git \
        locales \
        && \
    rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure \
    gd --with-png-dir=/usr --with-jpeg-dir=/usr && \
    \
    docker-php-ext-install \
    gd \
    mbstring \
    mcrypt \
    mysqli \
    opcache \
    pdo \
    pdo_mysql \
    soap \
    zip \
    intl \
    gettext


# Install redis

ENV PHPREDIS_VERSION 3.0.0
RUN mkdir -p /usr/src/php/ext/redis \
    && curl -L https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
    && echo 'redis' >> /usr/src/php-available-exts \
    && docker-php-ext-install redis

# Install different locales

## Install en_US locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_US.UTF-8"'>>/etc/default/locale

## Install de_DE locale
RUN sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="de_DE.UTF-8"'>>/etc/default/locale

RUN dpkg-reconfigure --frontend=noninteractive locales
