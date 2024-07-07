ARG PHP_VERSION=8.3
ARG COMPOSER_VERSION=latest

FROM composer:${COMPOSER_VERSION} as composer
FROM php:${PHP_VERSION}-cli-alpine

RUN apk add --no-cache \
		$PHPIZE_DEPS \
		openssl-dev

COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN chmod +x /usr/bin/composer

RUN pecl install xdebug-3.3.2 \
    && docker-php-ext-enable xdebug
