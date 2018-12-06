FROM intermesh/groupoffice

#Group-Office sources
VOLUME /usr/local/share/groupoffice

RUN pecl install xdebug && docker-php-ext-enable xdebug

COPY ./etc/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#COPY ./etc/apache2/sites-enabled/001-branches.conf /etc/apache2/sites-enabled/001-branches.conf

#Enable debug mode for development
RUN sed -i "s/config\['debug'\] = false;/config\['debug'\] = true;/" /etc/groupoffice/config.php.tpl

RUN sed -i "s/output_buffering = 4096/output_buffering = off/" /usr/local/etc/php/php.ini
