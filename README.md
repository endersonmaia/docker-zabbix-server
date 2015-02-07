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
 * [Using MySQL](#using_mysql)

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
## Using MySQL

Follow this instrunctions to setup a complete solution with MySQL, Zabbix Server and Zabbix Web using only Docker containers.

Create your MySQL database container with a [Data Volume Container](http://docs.docker.com/userguide/dockervolumes/#creating-and-mounting-a-data-volume-container).

    $ docker create -v /dbdata --name zabbix-mysql-data mysql
    $ docker run -d \
      -e MYSQL_ROOT_PASSWORD=zabbix \
      -e MYSQL_USER=zabbix \
      -e MYSQL_DATABASE=zabbix \
      -e MYSQL_PASSWORD=zabbix \
      --volumes-from zabbix-mysql-data \
      --name zabbix-mysql mysql
    $ docker ps
    CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS              PORTS               NAMES
    5282337a4056        mysql:5             "/entrypoint.sh mysq   2 minutes ago       Up 2 minutes        3306/tcp            zabbix-mysql

Now that your MySQL database server is up and runnig, start your Zabbix Server container.

    $ docker run -d \
      -p 10051:10051
      --link zabbix-mysql:mysql \
      --name zabbix-server enderson/zabbix-server

In the previous command, we started a container named `zabbix-server` linked to the `zabbix-mysql` container using `mysql` as internal name, and exposed the port `10051` so you can configure any zabbix-agent do point to your Docker host, and will access the zabbix-server.

Now you can start a [Zabbix Web container](http://github.com/enderson/docker-zabbix-web).

    $ docker run -d \
      -p 80:80
      --link zabbix-mysql:mysql \
      --link zabbix-server:zbx \
      -e ZBX_SERVER_NAME=docker-zabbix-server \
      --name zabbix-web enderson/zabbix-web

In the previous command, you linked the `zabbix-web` container woth the `zabbix-server` and `zabbix-msqyl` containers, and defined the `ZBX_SERVER_NAME`.

After running all the commands, you should see something like this :

    $ docker ps
    CONTAINER ID        IMAGE                           COMMAND                CREATED             STATUS              PORTS                      NAMES
    3654c423f660        enderson/zabbix-web:latest      "/sbin/my_init"        11 minutes ago      Up 11 minutes       0.0.0.0:80->80/tcp         zabbix-web
    26aca480ae16        enderson/zabbix-server:latest   "/sbin/my_init"        14 minutes ago      Up 14 minutes       0.0.0.0:10051->10051/tcp   zabbix-server
    3d111777c5fa        mysql:5                         "/entrypoint.sh mysq   14 minutes ago      Up 14 minutes       3306/tcp                   zabbix-mysql

And you should be able to access the Zabbix Web interface via http://DOCKER_HOST_PUBLIC_IP.