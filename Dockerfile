FROM php:7.0-fpm

ENV PHP_EXTRA_CONFIGURE_ARGS --enable-fpm

RUN apt-get update

RUN \
  apt-get install -y \
  libcurl4-gnutls-dev \
  libssl-dev \
  libmcrypt-dev \
  libgd-dev \
  git \
  curl \
  wget

RUN docker-php-ext-install mbstring pdo pdo_mysql
RUN /usr/local/bin/docker-php-ext-install \
    pdo \
    pdo_mysql \
    mysqli \
    mbstring \
    mcrypt \
    hash \
    json

RUN docker-php-ext-configure gd --with-freetype-dir=/usr --with-jpeg-dir=/usr --with-png-dir=/usr \
    && docker-php-ext-install gd
    
# Make sure the volume mount point is empty
RUN rm -rf /var/www/html/*

# Create log folders
RUN mkdir /var/log/php-fpm && \
    touch /var/log/php-fpm/access.log && \
    touch /var/log/php-fpm/error.log

# Install xdebug
RUN cd /tmp/ && git clone https://github.com/xdebug/xdebug.git \
    && cd xdebug && phpize && ./configure --enable-xdebug && make \
    && mkdir /usr/lib/php7/ && cp modules/xdebug.so /usr/lib/php7/xdebug.so \
    && touch /usr/local/etc/php/ext-xdebug.ini \
    && rm -r /tmp/xdebug \
    && apt-get purge -y --auto-remove
