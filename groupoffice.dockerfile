FROM php:7.2-apache
RUN apt-get update && \
    apt-get install -y libxml2-dev && \
    docker-php-ext-install soap pdo pdo_mysql calendar

