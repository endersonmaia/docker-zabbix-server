FROM phusion/baseimage

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]

# Installing packages

## Zabbix Server and Agent
RUN curl -O http://repo.zabbix.com/zabbix/2.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_2.4-1+trusty_all.deb
RUN dpkg -i zabbix-release_2.4-1+trusty_all.deb
RUN apt-get update
RUN apt-get install -y zabbix-server-mysql zabbix-agent

## SNMP mibs
RUN curl -O http://launchpadlibrarian.net/49822407/snmp-mibs-downloader_1.1_all.deb
RUN apt-get install -y wget smistrip patch snmp
RUN dpkg -i snmp-mibs-downloader_1.1_all.deb
RUN /usr/bin/download-mibs

## TDS + ODBC
RUN apt-get install -y unixodbc tdsodbc freetds-bin freetds-common

# Configuration

## Daemons
RUN mkdir /var/run/zabbix
RUN chown zabbix:zabbix /var/run/zabbix
ADD rc.local /etc/rc.local
RUN chmod +x /etc/rc.local
ADD zabbix_server.conf /etc/zabbix/zabbix_server.conf

## TDS + ODBC Config
ADD odbc.ini /etc/odbc.ini
ADD odbcinst.ini /etc/odbcinst.ini
ADD freetds.conf /etc/freetds/freetds.conf

## Slack notification
RUN wget https://raw.githubusercontent.com/enderson/zabbix-slack-alertscript/master/slack.sh -O /usr/lib/zabbix/alertscripts/slack.sh
RUN chmod +x /usr/lib/zabbix/alertscripts/slack.sh
RUN sed -i "s/subdomain='myorgname'/subdomain='gruposaotiago'/" /usr/lib/zabbix/alertscripts/slack.sh

RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 10051