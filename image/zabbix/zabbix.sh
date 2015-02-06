#!/bin/bash
set -e
source /build/buildconfig
set -x

ZABBIX_BUILD_PATH=/build/zabbix

## Zabbix Server and Agent
curl -O http://repo.zabbix.com/zabbix/2.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_2.4-1+trusty_all.deb
dpkg -i zabbix-release_2.4-1+trusty_all.deb
apt-get update

$minimal_apt_get_install zabbix-server-pgsql zabbix-agent

## Daemons
mkdir /var/run/zabbix
chown -R zabbix:zabbix /var/run/zabbix
chown -R zabbix:zabbix /etc/zabbix
cp $ZABBIX_BUILD_PATH/zabbix_server.conf /etc/zabbix/zabbix_server.conf
cp $ZABBIX_BUILD_PATH/zabbix-server.init.d /etc/my_init.d/10-zabbix-server.sh
cp $ZABBIX_BUILD_PATH/zabbix-agentd.init.d /etc/my_init.d/20-zabbix-agent.sh