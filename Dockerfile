FROM php:8.1-fpm as php

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    vim \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    pkg-config \
    iputils-ping \
    apt-utils \
    zip \
    unzip

RUN docker-php-ext-install pdo_mysql pdo mbstring

ENV COMPOSER_ALLOW_SUPERUSER=1

WORKDIR /var/www/html

COPY --from=composer:2.4 /usr/bin/composer /usr/bin/composer

COPY composer.* ./

RUN composer install --prefer-dist --no-dev --no-scripts --no-progress --no-interaction

COPY . .

RUN composer dump-autoload --optimize

RUN chmod -R 775 storage

RUN chmod -R 775 bootstrap/cache

FROM node:16-alpine as node

WORKDIR /var/www/html

COPY package*.json ./

RUN npm install

COPY . .



