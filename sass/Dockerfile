FROM dart

ADD ./install-sass.sh /usr/local/bin/install-sass.sh
ARG TARGETPLATFORM
RUN /usr/local/bin/install-sass.sh $TARGETPLATFORM


WORKDIR /opt/dart-sass

VOLUME /src

#ENTRYPOINT ["sass", "--watch", "./master/www/views/Extjs3/themes/Paper/src/style.scss:./master/www/views/Extjs3/themes/Paper/style.css", "./master/www/views/Extjs3/themes/Paper/src/style-mobile.scss:./master/www/views/Extjs3/themes/Paper/style-mobile.css", "./63/www/views/Extjs3/themes/Paper/src/style.scss:./63/www/views/Extjs3/themes/Paper/style.css", "./63/www/views/Extjs3/themes/Paper/src/style-mobile.scss:./63/www/views/Extjs3/themes/Paper/style-mobile.css"]

COPY entrypoint.sh /usr/local/bin

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]