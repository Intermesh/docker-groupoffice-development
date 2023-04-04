FROM google/dart

ARG DART_SASS_VERSION=1.60.0
ARG DART_SASS_TAR=dart-sass-${DART_SASS_VERSION}-linux-x64.tar.gz
ARG DART_SASS_URL=https://github.com/sass/dart-sass/releases/download/${DART_SASS_VERSION}/${DART_SASS_TAR}

ADD ${DART_SASS_URL} /opt/
RUN cd /opt/ && tar -xzf ${DART_SASS_TAR} && rm ${DART_SASS_TAR}
WORKDIR /opt/dart-sass

VOLUME /src

#ENTRYPOINT ["sass", "--watch", "./master/www/views/Extjs3/themes/Paper/src/style.scss:./master/www/views/Extjs3/themes/Paper/style.css", "./master/www/views/Extjs3/themes/Paper/src/style-mobile.scss:./master/www/views/Extjs3/themes/Paper/style-mobile.css", "./63/www/views/Extjs3/themes/Paper/src/style.scss:./63/www/views/Extjs3/themes/Paper/style.css", "./63/www/views/Extjs3/themes/Paper/src/style-mobile.scss:./63/www/views/Extjs3/themes/Paper/style-mobile.css"]

COPY entrypoint.sh /usr/local/bin

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]