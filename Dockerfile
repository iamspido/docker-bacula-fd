FROM ubuntu:16.04

RUN apt update \
	&& apt install -y \
	bacula-fd \
	nano \
	bzip2 \
	mysql-client
	
RUN mkdir /var/run/bacula
RUN mkdir /var/run/mysqld

COPY mysqldump.sh /root/mysqldump.sh
COPY ext-mysqldump.sh /root/ext-mysqldump.sh
COPY assets/bacula-fd.conf /etc/bacula/bacula-fd.conf
COPY start.sh start.sh
RUN chmod +x /start.sh

EXPOSE 9102

CMD ["/start.sh"]
