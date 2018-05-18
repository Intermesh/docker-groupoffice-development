FROM debian:stretch-slim

RUN apt-get update
RUN apt-get install -y ruby-sass

VOLUME /groupoffice

ENTRYPOINT ["sass", "--watch", "./www/views/Extjs3/themes/Paper/src:./www/views/Extjs3/themes/Paper"]
