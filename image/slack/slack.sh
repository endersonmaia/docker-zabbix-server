#!/bin/bash
set -e
source /build/buildconfig
set -x

## Slack notification
wget https://raw.githubusercontent.com/enderson/zabbix-slack-alertscript/master/slack.sh -O /usr/lib/zabbix/alertscripts/slack.sh
chmod +x /usr/lib/zabbix/alertscripts/slack.sh
sed -i "s/subdomain='myorgname'/subdomain='{{SLACK_ORG}}'/" /usr/lib/zabbix/alertscripts/slack.sh