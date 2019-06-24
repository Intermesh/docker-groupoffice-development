FROM intermesh/groupoffice
#FROM groupoffice-test
# To test changes in intermesh/groupoffice
# Build it with:
#
# docker build -t groupoffice-test .
#
# and use here: FROM groupoffice-test

RUN rm -rf /usr/local/share/groupoffice
RUN ln -s /usr/local/share/src/www /usr/local/share/groupoffice

#Group-Office sources
VOLUME /usr/local/share/src

#beta is required for php 7.3
RUN pecl install xdebug-beta && docker-php-ext-enable xdebug

# Install small text editor to make config.php changes
RUN apt-get install nano

COPY ./etc/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN touch /var/log/xdebug.log && chmod 666 /var/log/xdebug.log

#Enable debug mode for development
RUN sed -i "s/config\['debug'\] = false;/config\['debug'\] = true;/" /etc/groupoffice/config.php.tpl

RUN sed -i "s/output_buffering = 4096/output_buffering = off/" /usr/local/etc/php/php.ini
