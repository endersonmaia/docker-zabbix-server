#!/bin/bash

TDS_ID=${TDS_ID:-mssql}
TDS_HOST=${TDS_HOST:-mssql}
TDS_PORT=${TDS_PORT:-1433}
TDS_VERSION=${TDS_VERSION:-8.0}

sed 's/{{TDS_ID}}/'"${TDS_ID}"'/' -i /etc/freetds/freetds.conf
sed 's/{{TDS_HOST}}/'"${TDS_HOST}"'/' -i /etc/freetds/freetds.conf
sed 's/{{TDS_PORT}}/'"${TDS_PORT}"'/' -i /etc/freetds/freetds.conf
sed 's/{{TDS_VERSION}}/'"${TDS_VERSION}"'/' -i /etc/freetds/freetds.conf