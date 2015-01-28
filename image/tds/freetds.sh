#!/bin/bash

## TDS + ODBC
$minimal_apt_get_install tdsodbc freetds-bin freetds-common

cat /build/tds/freetds-odbcinst.ini >> /etc/odbc/odbcinst.ini
mkdir -p /etc/freetds
cp /build/tds/freetds.conf /etc/freetds/freetds.conf
cp /build/tds/tds.init.d /etc/my_init.d/05-tds.sh
