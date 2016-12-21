FROM mc388/php:latest
MAINTAINER Marvin Caspar <info@marvincaspar.de>

# Install New Relic daemon
RUN apt-get update && \
    apt-get -yq install wget && \
    wget -O - https://download.newrelic.com/548C16BF.gpg | apt-key add - && \
    echo "deb http://apt.newrelic.com/debian/ newrelic non-free" > /etc/apt/sources.list.d/newrelic.list

RUN apt-get update && \
    apt-get -yq install newrelic-php5 && \
    newrelic-install install && \
    apt-get purge -y --auto-remove
