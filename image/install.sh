#!/bin/bash
set -e
source /build/buildconfig
set -x

# Preparing
mkdir -p /etc/my_init.d

# Installing
/build/zabbix/zabbix.sh
/build/mibs/mibs.sh