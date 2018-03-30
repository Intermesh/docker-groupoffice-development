FROM composer
RUN apk add --no-cache --virtual .persistent-deps libxml2-dev
RUN docker-php-ext-install soap
