# Dockerized Zabbix Server daemon

This is a Zabbix Server Dockerfile base on the [baseimage-docker from phusion](http://phusion.github.io/baseimage-docker/).

*Supported tags* :

* 2.4, 2.4-mysql, latest -  By default, links to [MySQL Dockerfile](https://registry.hub.docker.com/_/mysql/)
* 2.4-pgsql - To link to [Postgres Dockerfile](https://registry.hub.docker.com/_/postgres/)

*Features* :

* zabbix-server only;
* [Slack](https://slack.com/) notification script;
* Links to official [MySQL Dockerfile](https://registry.hub.docker.com/_/mysql/)
* Links to official [Postgres Dockerfile](https://registry.hub.docker.com/_/postgres/)
* Has ODBC and FreeTDS for database monitoring;

-----------------------------------------

## Quickstart

Considering you already have a MySQL server configured and running, just pass the correct variables, and zabbix-server will start running.

Change the variable values to your situation.

```bash
docker run --name=zabbix-server -it --rm -p 10051:10051 \
-e DB_HOST=169.254.0.1 \
-e DB_NAME=zabbix-database \
-e DB_USER=zabbix \
-e DB_PASS=password \
enderson/zabbix-server:2.4
```

For more information, visit the GitHub project page at : https://github.com/endersonmaia/docker-zabbix-server