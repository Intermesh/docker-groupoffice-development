FROM php:7-fpm

ENV MYSQL_USER groupoffice
ENV MYSQL_PASSWORD groupoffice
ENV MYSQL_DATABASE groupoffice
ENV MYSQL_HOST db

#ENV APACHE_SERVER_NAME localhost
#ENV APACHE_SERVER_ADMIN admin@localhost

EXPOSE 80
EXPOSE 443

RUN apt-get update && \
    apt-get install -y libxml2-dev libpng-dev libfreetype6-dev libjpeg62-turbo-dev zip tnef ssl-cert libldap2-dev \
		catdoc unzip tar imagemagick tesseract-ocr tesseract-ocr-eng poppler-utils exiv2 libzip-dev && \
		docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
		docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-install soap pdo pdo_mysql calendar gd sysvshm sysvsem sysvmsg ldap opcache intl pcntl zip

#sysvshm sysvsem sysvmsg pcntl are for z-push

RUN pecl install apcu
RUN docker-php-ext-enable apcu

RUN mkdir -p /etc/groupoffice/multi_instance && chown -R www-data:www-data /etc/groupoffice
#default group-office config
ADD ./etc/groupoffice/config.php.tpl /etc/groupoffice/config.php.tpl

#For persistant multi instances
VOLUME /etc/groupoffice/multi_instance


RUN mkdir -p /var/lib/groupoffice/multi_instance && chown -R www-data:www-data /var/lib/groupoffice
#Group-Office data:
VOLUME /var/lib/groupoffice


COPY docker-go-entrypoint.sh /usr/local/bin/

CMD ["php-fpm"]
ENTRYPOINT ["docker-go-entrypoint.sh"]


# dev

#RUN ln -s /usr/local/share/src/www /usr/local/share/groupoffice
#beta is required for php 7.3
RUN pecl install xdebug-beta && docker-php-ext-enable xdebug

#Group-Office sources
VOLUME /usr/local/share/groupoffice

COPY ./etc/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN touch /var/log/xdebug.log && chmod 666 /var/log/xdebug.log

#Enable debug mode for development
RUN sed -i "s/config\['debug'\] = false;/config\['debug'\] = true;/" /etc/groupoffice/config.php.tpl

#RUN sed -i "s/output_buffering = 4096/output_buffering = off/" /usr/local/etc/php/php.ini
