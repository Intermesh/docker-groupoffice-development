FROM debian:stretch-slim

RUN apt-get update
RUN apt-get install -y ruby-sass

VOLUME /groupoffice

ENTRYPOINT ["sass", "--watch", "./www/views/Extjs3/themes/Paper/src/style.scss:./www/views/Extjs3/themes/Paper/style.css", "./www/views/Extjs3/themes/Paper/src/style-mobile.scss:./www/views/Extjs3/themes/Paper/style-mobile.css"]
