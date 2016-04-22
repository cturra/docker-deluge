FROM ubuntu:16.04

MAINTAINER cturra <cturra@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV DELUGE_VERSION  1.3.12-1ubuntu1

RUN apt-get -q update \
 && apt-get -y install software-properties-common \
 && add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ trusty-security multiverse" \
 && apt-get -q update \
 && apt-get -y install supervisor \
                       deluged=${DELUGE_VERSION} \
                       deluge-web=${DELUGE_VERSION} \
                       unrar \
 && rm -rf /var/lib/apt/lists/*

# supervisor config
COPY conf/supervisor.conf /etc/supervisor/conf.d/deluge.conf

VOLUME ["/data"]

# torrent port (tcp and udp)
EXPOSE 53160/tcp 53160/udp 8112/tcp 58846/tcp

# kick off supervisor+deluge
ENTRYPOINT [ "/usr/bin/supervisord" ]
