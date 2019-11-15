FROM phusion/baseimage:0.11

MAINTAINER ytzelf
ENV IPP_VERSION=1.66.161-1
# ENV IPP_VERSION=1.61.158-1
ENV CONFD_VERSION=0.16.0

CMD ["/sbin/my_init"]

# INSTALL EATON IPP
RUN apt-get update && apt-get install -y wget ssmtp mailutils iptables syslog-ng-core
RUN wget http://pqsoftware.eaton.com/install/linux/ipp/ipp-linux_${IPP_VERSION}_amd64.deb
RUN dpkg -i ipp-linux_${IPP_VERSION}_amd64.deb

# INSTALL CONFD
ADD https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd
ADD confd /etc/confd
ADD confd.sh /etc/my_init.d/
RUN chmod +x /etc/my_init.d/confd.sh

# CREATE SERVICES
RUN mkdir -p /etc/my_init.d
COPY ipp.sh /etc/my_init.d/ipp.sh
RUN chmod +x /etc/my_init.d/ipp.sh

# PORTS & VOLUMES
EXPOSE 4679
VOLUME ["/usr/local/Eaton/IntelligentPowerProtector/db"]
VOLUME ["/usr/local/Eaton/IntelligentPowerProtector/configs"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
