# Dockerized Zabbix Server daemon

This is a Zabbix Server Dockerfile base on the [baseimage-docker from phusion](http://phusion.github.io/baseimage-docker/).

Features :

* zabbix-server only;
* [Slack](https://slack.com/) notification script;
* Links to official [MySQL Dockerfile](https://registry.hub.docker.com/_/mysql/)
* Has ODBC and FreeTDS for database monitoring;

-----------------------------------------

**Related resources**:
  [baseimage-docker](http://phusion.github.io/baseimage-docker/) |
  [Docker registry](https://index.docker.io/u/phusion/baseimage/)

**Table of contents**

 * [Introduction](#intro)
   * [Version](#version)
   * [Contributing?](#contrib)
 * [Quickstart](#quickstart)

-----------------------------------------

<a name="intro"></a>
## Introduction

This is a Zabbix Server Dockerfile base on the [baseimage-docker from phusion](http://phusion.github.io/baseimage-docker/).

Features :

* zabbix-server only;
* [Slack](https://slack.com/) notification script;
* Links to official [MySQL Dockerfile](https://registry.hub.docker.com/_/mysql/)
* Has ODBC and FreeTDS for database monitoring;

<a name="intro"></a>
### Version

The current version of the zabbix-server daemon is 2.4. I'll try to keep upgrades inside new docker tags.

<a name="contrib"></a>
### Contributing

If you find this image useful here's how you can help:

- Send a Pull Request with your awesome new features and bug fixes
- Help new users with [Issues](https://github.com/enderson/docker-zabbix-server/issues) they may encounter

<a name="quickstart"></a>
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

