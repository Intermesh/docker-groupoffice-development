FROM de8d505f8b29

RUN rm -rf /usr/local/share/groupoffice
RUN ln -s /usr/local/share/src/www /usr/local/share/groupoffice

#Group-Office sources
VOLUME /usr/local/share/src

# Install small text editor to make config.php changes, install wget for composer, gcc for building xdebug
RUN apt-get update --allow-releaseinfo-change && apt-get install -y nano wget gcc npm

RUN a2enmod expires
COPY ./etc/apache2/mods-enabled/expires.conf /etc/apache2/mods-enabled/expires.conf
COPY ./etc/apache2/mods-enabled/deflate.conf /etc/apache2/mods-enabled/deflate.conf

#Enable debug mode for development
RUN sed -i "s/config\['debug'\] = false;/config\['debug'\] = true;/" /etc/groupoffice/config.php

RUN sed -i "s/output_buffering = 4096/output_buffering = off/" /usr/local/etc/php/php.ini

COPY ./usr/local/sbin/install-composer.sh /usr/local/sbin/install-composer.sh
RUN chmod 700 /usr/local/sbin/install-composer.sh
RUN /usr/local/sbin/install-composer.sh
RUN mv composer.phar /usr/local/bin/composer

# For supporting host.docker.internal on Linux. See https://github.com/docker/for-linux/issues/264 (uses pkg iproute2 host)
COPY docker-godev-entrypoint-250.sh /usr/local/bin


#xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug
COPY ./etc/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN touch /var/log/xdebug.log && chmod 666 /var/log/xdebug.log

#cleanup
RUN apt purge -y --autoremove wget gcc && rm -rf /var/lib/apt/lists/*

#SASS global
RUN npm -g install sass

#ENV APACHE_UID=1000

CMD ["apache2-foreground"]
ENTRYPOINT ["docker-godev-entrypoint-250.sh"]

