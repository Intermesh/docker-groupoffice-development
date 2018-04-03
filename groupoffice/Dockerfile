FROM php:7.2-apache

ENV MYSQL_USER groupoffice
ENV MYSQL_PASSWORD groupoffice
ENV MYSQL_DATABASE groupoffice
ENV MYSQL_HOST db


EXPOSE 80
EXPOSE 443

RUN apt-get update && \
    apt-get install -y libxml2-dev && \
    docker-php-ext-install soap pdo pdo_mysql calendar

#configure apache
ADD ./etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf

#default group-office config
ADD ./etc/groupoffice/config.ini /etc/groupoffice/config.ini

RUN sed -i 's/{dbHost}/'$MYSQL_HOST'/' /etc/groupoffice/config.ini
RUN sed -i 's/{dbName}/'$MYSQL_DATABASE'/' /etc/groupoffice/config.ini
RUN sed -i 's/{dbUser}/'$MYSQL_PASSWORD'/' /etc/groupoffice/config.ini
RUN sed -i 's/{dbPass}/'$MYSQL_USER'/' /etc/groupoffice/config.ini


#Group-Office data:
VOLUME /src/groupoffice

#Group-Office sources
VOLUME /usr/local/share/groupoffice

#Install ioncube
ADD https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz /tmp/

RUN tar xvzfC /tmp/ioncube_loaders_lin_x86-64.tar.gz /tmp/ \
    && rm /tmp/ioncube_loaders_lin_x86-64.tar.gz \
    && mkdir -p /usr/local/ioncube \
    && cp /tmp/ioncube/ioncube_loader_* /usr/local/ioncube \
    && rm -rf /tmp/ioncube

RUN echo "zend_extension = /usr/local/ioncube/ioncube_loader_lin_7.2.so" >> /usr/local/etc/php/conf.d/ioncube.ini

RUN service apache2 restart

#configure cron
#ADD cron-groupoffice /etc/cron.d/groupoffice