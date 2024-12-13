ARG PHP_VERSION=8.4
ARG COMPOSER_VERSION=latest

FROM composer:${COMPOSER_VERSION} AS composer
FROM php:${PHP_VERSION}-cli-alpine

LABEL org.opencontainers.image.source="https://github.com/mops1k/php-cli-dev-docker"
LABEL org.opencontainers.image.description="Docker image with php, composer and xdebug installed. Based on official php image."
LABEL org.opencontainers.image.licenses="MIT"

RUN apk add --no-cache \
		$PHPIZE_DEPS \
		openssl-dev \
        git \
        curl

RUN apk add --update linux-headers

RUN rm -rf /var/cache/apk/*

COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN chmod +x /usr/bin/composer

RUN pecl install xdebug-3.4.0 \
    && docker-php-ext-enable xdebug
