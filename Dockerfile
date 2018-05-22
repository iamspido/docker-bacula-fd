FROM ubuntu:16.04

MAINTAINER Timo Hohmann <t.hohmann@raphael-gmbh.de>

RUN apt update \
	&& apt install -y \
	bacula-fd \
	supervisor \
	nano

COPY assets/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 9102

CMD ["bash", "/start.sh"]
