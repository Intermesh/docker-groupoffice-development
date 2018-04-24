FROM php:7.2-apache

ENV MYSQL_USER groupoffice
ENV MYSQL_PASSWORD groupoffice
ENV MYSQL_DATABASE groupoffice
ENV MYSQL_HOST db


EXPOSE 80
EXPOSE 443

RUN apt-get update && \
    apt-get install -y libxml2-dev libpng-dev zip tnef && \
    docker-php-ext-install soap pdo pdo_mysql calendar gd sysvshm sysvsem sysvmsg

#sysvshm sysvsem sysvmsg are for z-push

COPY ./etc/php.ini /usr/local/etc/php/

#configure apache
ADD ./etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf

#default group-office config
ADD ./etc/groupoffice/config.ini /etc/groupoffice/config.ini

RUN sed -i 's/{dbHost}/'$MYSQL_HOST'/' /etc/groupoffice/config.ini
RUN sed -i 's/{dbName}/'$MYSQL_DATABASE'/' /etc/groupoffice/config.ini
RUN sed -i 's/{dbUser}/'$MYSQL_PASSWORD'/' /etc/groupoffice/config.ini
RUN sed -i 's/{dbPass}/'$MYSQL_USER'/' /etc/groupoffice/config.ini

#Group-Office data:
VOLUME /var/lib/groupoffice

#Group-Office sources
#VOLUME /usr/local/share/groupoffice

#Download package from sourceforge
ADD https://iweb.dl.sourceforge.net/project/group-office/6.3/groupoffice-com-6.3.3-php-7.1-BETA.tar.gz /tmp/
#COPY /groupoffice-com-6.3.3-php-7.1-BETA.tar.gz /tmp/
RUN tar zxvfC /tmp/groupoffice-com-6.3.3-php-7.1-BETA.tar.gz /tmp/ \
    && rm /tmp/groupoffice-com-6.3.3-php-7.1-BETA.tar.gz \
    && mv /tmp/groupoffice-com-6.3.3-php-7.1 /usr/local/share/groupoffice

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