FROM composer
RUN apk add --no-cache --virtual .persistent-deps libxml2-dev libpng-dev
RUN docker-php-ext-install soap pdo pdo_mysql calendar gd
