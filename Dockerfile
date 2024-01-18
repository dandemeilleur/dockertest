FROM php:8.2-fpm

COPY . /var/www/html

## Définir les permissions
#RUN chmod -R 777 /var/www/html

# Installer les dépendances PHP et Composer
RUN apt-get update && apt-get install -y \
    unzip \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-install pdo_mysql \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

EXPOSE 9000

# Configuration du server web

WORKDIR /var/www/html
CMD ["php-fpm"]