FROM php:8.2-fpm

COPY . /var/www/html

# Installer les dépendances PHP et Composer
RUN apt-get -qq update && apt-get -qqy upgrade
RUN apt-get -yqq install
RUN apt-get -yqq install unzip apt-utils
RUN apt-get -yqq --fix-missing install

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-install pdo pdo_mysql \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

EXPOSE 9000

# Configuration du server web

WORKDIR /var/www/html
CMD ["php-fpm"]