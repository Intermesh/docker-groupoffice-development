FROM nginx

ENV MYSQL_USER groupoffice
ENV MYSQL_PASSWORD groupoffice
ENV MYSQL_DATABASE groupoffice
ENV MYSQL_HOST db

#ENV APACHE_SERVER_NAME localhost
#ENV APACHE_SERVER_ADMIN admin@localhost

EXPOSE 80
EXPOSE 443

RUN apt-get update && \
    apt-get install -y php-fpm php-zip tnef ssl-cert php-gd php-ldap php-soap php-mysql \
    php-calendar php-cli php-curl php-xsl php-xml php-mbstring php-intl php-apcu php-xdebug \
    unzip tar zip tnef nano

RUN mkdir -p /etc/groupoffice/multi_instance && chown -R www-data:www-data /etc/groupoffice
#default group-office config
ADD ./etc/groupoffice/config.php.tpl /etc/groupoffice/config.php.tpl

#For persistant multi instances
VOLUME /etc/groupoffice/multi_instance


RUN mkdir -p /var/lib/groupoffice/multi_instance && chown -R www-data:www-data /var/lib/groupoffice
#Group-Office data:
VOLUME /var/lib/groupoffice

RUN ln -s /usr/local/share/src/www /usr/local/share/groupoffice

#Group-Office sources
VOLUME /usr/local/share/src

#COPY ./etc/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN touch /var/log/xdebug.log && chmod 666 /var/log/xdebug.log

#Enable debug mode for development
RUN sed -i "s/config\['debug'\] = false;/config\['debug'\] = true;/" /etc/groupoffice/config.php.tpl

#RUN sed -i "s/output_buffering = 4096/output_buffering = off/" /usr/local/etc/php/php.ini
