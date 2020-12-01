FROM php:7.2-fpm

RUN mkdir /app

COPY SimpleWeb /app

# Libraries required for Postgress connection to work
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libicu-dev \
    zlib1g-dev \
    libpq-dev \
    libzip-dev \
    libpcre3-dev \
    && docker-php-ext-install \
    pdo \
    pdo_pgsql \
    pgsql