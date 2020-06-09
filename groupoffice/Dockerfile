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
RUN pecl install xdebug && docker-php-ext-enable xdebug

# Install small text editor to make config.php changes
RUN apt-get install nano

COPY ./etc/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN touch /var/log/xdebug.log && chmod 666 /var/log/xdebug.log

#Enable debug mode for development
RUN sed -i "s/config\['debug'\] = false;/config\['debug'\] = true;/" /etc/groupoffice/config.php.tpl

RUN sed -i "s/output_buffering = 4096/output_buffering = off/" /usr/local/etc/php/php.ini


# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
  php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
  php composer-setup.php && \
  php -r "unlink('composer-setup.php');" && \
  mv composer.phar /usr/local/bin/composer && \
  chmod +x /usr/local/bin/composer


# For supporting host.docker.internal on Linux. See https://github.com/docker/for-linux/issues/264
RUN apt-get install -y iproute2 host
COPY docker-godev-entrypoint.sh /usr/local/bin

CMD ["apache2-foreground"]
ENTRYPOINT ["docker-godev-entrypoint.sh"]

#webgrind
# ADD https://github.com/jokkedk/webgrind/archive/v1.6.1.tar.gz /tmp


# RUN tar xvzfC /tmp/v1.6.1.tar.gz /tmp/ \
#     && mv /tmp/webgrind-1.6.1 /usr/local/share/webgrind

# COPY ./etc/apache2/conf-enabled/webgrind.conf /etc/apache2/conf-enabled/webgrind.conf
