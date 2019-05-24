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

EXPOSE 9102

CMD ["/usr/sbin/bacula-fd", "-f"]
