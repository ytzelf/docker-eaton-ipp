FROM phusion/baseimage:0.11

MAINTAINER ytzelf
ENV IPP_VERSION=1.61.158-1

CMD ["/sbin/my_init"]

RUN apt-get update && apt-get install -y wget
RUN wget http://pqsoftware.eaton.com/install/linux/ipp/ipp-linux_${IPP_VERSION}_amd64.deb
RUN dpkg -i ipp-linux_${IPP_VERSION}_amd64.deb

RUN mkdir -p /etc/my_init.d
COPY ipp.sh /etc/my_init.d/ipp.sh
RUN chmod +x /etc/my_init.d/ipp.sh

EXPOSE 4679

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
