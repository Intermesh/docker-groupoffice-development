FROM debian:stretch-slim

RUN apt-get update
RUN apt-get install -y ruby-sass

VOLUME /src

ENTRYPOINT ["sass", "--watch", "./master/www/views/Extjs3/themes/Paper/src/style.scss:./master/www/views/Extjs3/themes/Paper/style.css", "./master/www/views/Extjs3/themes/Paper/src/style-mobile.scss:./master/www/views/Extjs3/themes/Paper/style-mobile.css", "./63/www/views/Extjs3/themes/Paper/src/style.scss:./63/www/views/Extjs3/themes/Paper/style.css", "./63/www/views/Extjs3/themes/Paper/src/style-mobile.scss:./63/www/views/Extjs3/themes/Paper/style-mobile.css","./64/www/views/Extjs3/themes/Paper/src/style.scss:./64/www/views/Extjs3/themes/Paper/style.css", "./64/www/views/Extjs3/themes/Paper/src/style-mobile.scss:./64/www/views/Extjs3/themes/Paper/style-mobile.css"]
