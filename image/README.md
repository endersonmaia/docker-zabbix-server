# Dockerized Zabbix Server daemon

This is a Zabbix Server Dockerfile base on the [baseimage-docker from phusion](http://phusion.github.io/baseimage-docker/).

Features :

* zabbix-server only;
* [Slack](https://slack.com/) notification script;
* Links to official [MySQL](https://registry.hub.docker.com/_/mysql/) and [PostgreSQL](https://registry.hub.docker.com/_/postgres/) docker images;
* Has ODBC and FreeTDS pre-installed for database monitoring;

-----------------------------------------

**Related resources**:
  [baseimage-docker](http://phusion.github.io/baseimage-docker/) |
  [Docker registry](https://index.docker.io/u/phusion/baseimage/)

## Quickstart

Considering you already have a MySQL server configured and running, just pass the correct variables, and zabbix-server will start running.

Change the variable values to your situation.

    $ docker run --name=zabbix-server -it --rm -p 10051:10051 \
    -e DB_TYPE=MYSQL
    -e DB_HOST=169.254.0.1 \
    -e DB_NAME=zabbix-database \
    -e DB_USER=zabbix \
    -e DB_PASS=password \
    enderson/zabbix-server:2.4

The default version tag, is used for MySQL databases, to start a zabbix-server connecting to a PostgreSQL database, you should use VERSION-pgsql tag.

For example: 

    $ docker run enderson/zabbix-server:2.4-pgsql

The `DB_TYPE` environment variable could be `MYSQL` or `POSTGRESQL`.