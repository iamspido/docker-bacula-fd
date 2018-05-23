FROM ubuntu:16.04

MAINTAINER Timo Hohmann <t.hohmann@raphael-gmbh.de>

RUN apt update \
	&& apt install -y \
	bacula-fd \
	nano

EXPOSE 9102

CMD ["service bacula-fd start"]
