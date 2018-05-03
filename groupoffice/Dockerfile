FROM intermesh/groupoffice

#Group-Office sources
VOLUME /usr/local/share/groupoffice

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

COPY ./etc/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN sed -i 's/debug = false/debug = true/' /etc/groupoffice/config.ini

