FROM php:7.2-apache
RUN apt-get update && \
    apt-get install -y libxml2-dev && \
    docker-php-ext-install soap pdo pdo_mysql calendar

#configure apache
ADD ./apache-groupoffice.conf /etc/apache2/sites-available/000-default.conf



#Install ioncube
#ADD https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz /tmp/
#
#RUN tar xvzfC /tmp/ioncube_loaders_lin_x86-64.tar.gz /tmp/ \
#    && rm /tmp/ioncube_loaders_lin_x86-64.tar.gz \
#    && mkdir -p /usr/local/ioncube \
#    && cp /tmp/ioncube/ioncube_loader_* /usr/local/ioncube \
#    && rm -rf /tmp/ioncube
#
#RUN echo "zend_extension = /usr/local/ioncube/ioncube_loader_lin_7.2.so" >> /usr/local/etc/php/conf.d/ioncube.ini

RUN service apache2 restart
# end ioncube


#configure cron
ADD cron-groupoffice /etc/cron.d/groupoffice