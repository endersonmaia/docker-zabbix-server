#!/bin/bash

SLACK_ORG=${SLACK_ORG:-myorgname}

sed 's/{{SLACK_ORG}}/'"${SLACK_ORG}"'/' -i /usr/lib/zabbix/alertscripts/slack.sh
