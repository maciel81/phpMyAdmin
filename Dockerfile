FROM php:7.2-apache-stretch 

## Install and enable requirement for phpMyAdmin
RUN apt-get update && apt-get install -y --no-install-recommends \
        libbz2-dev \
        libzip-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libwebp-dev \
        libxpm-dev \
        && rm -rf /var/lib/apt/lists/* \
        && docker-php-ext-configure gd --with-freetype-dir=/usr --with-jpeg-dir=/usr --with-webp-dir=/usr --with-png-dir=/usr --with-xpm-dir=/usr \
        && docker-php-ext-install bz2 gd mysqli opcache zip

## Download phpMyAdmin URL
COPY etc /etc/
ENV PMA_VERSION 4.8.1
ADD https://files.phpmyadmin.net/phpMyAdmin/${PMA_VERSION}/phpMyAdmin-${PMA_VERSION}-all-languages.tar.gz /tmp/pma.tar.gz

## Decompress phpMyAdmin
RUN cd /tmp; \
  tar xzf pma.tar.gz; \
  rm -f pma.tar.gz; \
  mv phpMyAdmin-${PMA_VERSION}-all-languages/* /var/www/html; \
  rm -rf /var/www/html/setup/ /var/www/html/examples/ /var/www/html/composer.json /var/www/html/composer.lock /var/www/html/RELEASE-DATE-$VERSION; \
  sed -i "s@define('CONFIG_DIR'.*@define('CONFIG_DIR', '/etc/phpmyadmin/');@" /var/www/html/libraries/vendor_config.php

## Cppy theme from host
COPY var /var/

