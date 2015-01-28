#!/bin/bash
set -e
source /build/buildconfig
set -x

## SNMP mibs
curl -O http://launchpadlibrarian.net/49822407/snmp-mibs-downloader_1.1_all.deb
$minimal_apt_get_install wget smistrip patch snmp
dpkg -i snmp-mibs-downloader_1.1_all.deb
/usr/bin/download-mibs