#!/bin/bash
set -e
source /build/buildconfig
set -x

ODBC_BUILD_PATH=/build/odbc

$minimal_apt_get_install unixodbc

/bin/cp $ODBC_BUILD_PATH/odbc.ini /etc/odbc.ini
/bin/cp $ODBC_BUILD_PATH/odbc.init.d /etc/my_init.d/06-odbc.sh