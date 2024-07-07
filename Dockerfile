ARG PHP_VERSION=8.3
ARG COMPOSER_VERSION=latest

FROM composer:${COMPOSER_VERSION} as composer
FROM php:${PHP_VERSION}-cli-alpine

LABEL org.opencontainers.image.source="https://github.com/mops1k/php-cli-dev-docker"
LABEL org.opencontainers.image.description="Docker image with php, composer and xdebug installed. Based on official php image."
LABEL org.opencontainers.image.licenses="MIT"

RUN apk add --no-cache \
		$PHPIZE_DEPS \
		openssl-dev

RUN apk add --update linux-headers

COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN chmod +x /usr/bin/composer

RUN pecl install xdebug-3.3.2 \
    && docker-php-ext-enable xdebug
