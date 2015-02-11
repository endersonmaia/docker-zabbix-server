#!/bin/sh

DB_HOST=${DB_HOST:-}
DB_PORT=${DB_PORT:-5432}
DB_NAME=${DB_NAME:-}
DB_USER=${DB_USER:-}
DB_PASS=${DB_NAME:-${DB_USER:-}}

if [ -n "${POSTGRES_PORT_5432_TCP_ADDR}" ]; then
  DB_TYPE=postgres
  DB_HOST=${DB_HOST:-${POSTGRES_PORT_5432_TCP_ADDR}}
  DB_PORT=${DB_PORT:-${POSTGRES_PORT_5432_TCP_PORT}}

  DB_NAME=${DB_NAME:-${POSTGRES_ENV_POSTGRES_USER}}
  DB_USER=${DB_USER:-${POSTGRES_ENV_POSTGRES_USER}}
  DB_PASS=${DB_PASS:-${POSTGRES_ENV_POSTGRES_PASSWORD}}
fi

export PGPASSWORD=$DB_PASS

/sbin/setuser zabbix sed 's/{{DB_HOST}}/'"${DB_HOST}"'/' -i /etc/zabbix/zabbix_server.conf
/sbin/setuser zabbix sed 's/{{DB_PORT}}/'"${DB_PORT}"'/' -i /etc/zabbix/zabbix_server.conf
/sbin/setuser zabbix sed 's/{{DB_NAME}}/'"${DB_NAME}"'/' -i /etc/zabbix/zabbix_server.conf
/sbin/setuser zabbix sed 's/{{DB_USER}}/'"${DB_USER}"'/' -i /etc/zabbix/zabbix_server.conf
/sbin/setuser zabbix sed 's/{{DB_PASS}}/'"${DB_PASS}"'/' -i /etc/zabbix/zabbix_server.conf

count_tables=$(/usr/bin/psql -q -h$DB_HOST -U$DB_USER $DB_NAME -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'public';" | grep -v row | grep "[0-9]")

if [ "${count_tables}" -eq "0" ]; then
  /usr/bin/psql -q -h$DB_HOST -U$DB_USER $DB_NAME -f /usr/share/zabbix-server-pgsql/schema.sql
  /usr/bin/psql -q -h$DB_HOST -U$DB_USER $DB_NAME -f /usr/share/zabbix-server-pgsql/images.sql
  /usr/bin/psql -q -h$DB_HOST -U$DB_USER $DB_NAME -f /usr/share/zabbix-server-pgsql/data.sql
fi

exec /sbin/setuser zabbix /usr/sbin/zabbix_server 2>&1