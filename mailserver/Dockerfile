FROM debian:stretch-slim

ENV MYSQL_USER groupoffice
ENV MYSQL_PASSWORD groupoffice
ENV MYSQL_DATABASE groupoffice
ENV MYSQL_HOST db
ENV POSTMASTER_EMAIL postmaster@example.com

RUN apt-get update
RUN apt-get install -y postfix postfix-mysql dovecot-imapd dovecot-mysql supervisor bash rsyslog

RUN useradd -r -u 150 -g mail -d /home/vmail -m -s /sbin/nologin -c "Virtual Mailbox" vmail


ADD ./dovecot.conf /etc/dovecot/conf.d/99-groupoffice.conf
RUN sed -i 's/{postmaster}/'$POSTMASTER_EMAIL'/' /etc/dovecot/conf.d/99-groupoffice.conf

ADD ./dovecot-sql.conf.ext /etc/dovecot/dovecot-sql.conf.ext
RUN sed -i 's/{db_host}/'$MYSQL_HOST'/' /etc/dovecot/dovecot-sql.conf.ext
RUN sed -i 's/{db_name}/'$MYSQL_DATABASE'/' /etc/dovecot/dovecot-sql.conf.ext
RUN sed -i 's/{db_user}/'$MYSQL_PASSWORD'/' /etc/dovecot/dovecot-sql.conf.ext
RUN sed -i 's/{db_pass}/'$MYSQL_USER'/' /etc/dovecot/dovecot-sql.conf.ext

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf 

EXPOSE 25
EXPOSE 143
EXPOSE 587
EXPOSE 993

ENTRYPOINT ["/usr/bin/supervisord"]
#CMD /bin/bash