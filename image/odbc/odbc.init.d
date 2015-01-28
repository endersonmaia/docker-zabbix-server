#!/bin/bash

TDS_ID=${TDS_ID:-mssql}
TDS_DB=${TDS_DB:-master}

sed 's/{{TDS_ID}}/'"${TDS_ID}"'/' -i /etc/odbc.ini
sed 's/{{TDS_DB}}/'"${TDS_DB}"'/' -i /etc/odbc.ini