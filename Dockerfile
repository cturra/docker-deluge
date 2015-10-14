FROM ubuntu:trusty

MAINTAINER cturra <cturra@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV DELUGE_VERSION  1.3.12-0~trusty~ppa1

RUN apt-get -qq update && \
    apt-get -y install software-properties-common && \
    add-apt-repository ppa:deluge-team/ppa && \
    add-apt-repository "deb http://archive.ubuntu.com/ubuntu/ trusty-security multiverse" && \
    apt-get -qq update && \
    apt-get -y install supervisor \
                       deluged=${DELUGE_VERSION} \
                       deluge-web=${DELUGE_VERSION} \
                       unrar && \
    rm -rf /var/lib/apt/lists/*

COPY conf/supervisor.conf /etc/supervisor/conf.d/deluge.conf

VOLUME ["/data"]

# torrent port
EXPOSE 53160
EXPOSE 53160/udp

# web ui
EXPOSE 8112

# daemon
EXPOSE 58846

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/deluge.conf"]
