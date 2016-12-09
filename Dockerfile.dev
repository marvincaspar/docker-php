FROM mc388/php
MAINTAINER Marvin Caspar <info@marvincaspar.de>

# Install xdebug
RUN cd /tmp/ && git clone https://github.com/xdebug/xdebug.git \
    && cd xdebug && phpize && ./configure && make && make install \
    && rm -r /tmp/xdebug \
    && apt-get purge -y --auto-remove
