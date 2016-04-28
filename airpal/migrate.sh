#!/usr/bin/env bash

set -x

MYSQL_URL=${MYSQL_URL:-"jdbc:mysql://$MYSQL_PORT_3306_TCP_ADDR:$MYSQL_PORT_3306_TCP_PORT/$MYSQL_DB"}

java -Ddw.dataSourceFactory.url=$MYSQL_URL \
     -Ddw.dataSourceFactory.user=$MYSQL_USER \
     -Ddw.dataSourceFactory.password=$MYSQL_PASSWORD \
     -server \
     -Duser.timezone=UTC \
     -cp build/libs/airpal-*-all.jar \
     com.airbnb.airpal.AirpalApplication \
     db migrate \
     reference.yml