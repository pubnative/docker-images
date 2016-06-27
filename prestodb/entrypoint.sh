#!/bin/sh -x
fatal() {
    echo "$@"
    exit 1
}

[ "x${PRESTO_UUID}" = "x" ] && {
  PRESTO_UUID=`/usr/bin/dbus-uuidgen`
  [ $? -ne 0 ] &&  fatal "uuidgen failed"
  export PRESTO_UUID
}

# build configuration files
PRESTO_DISCOVERY_URI=http://${PRESTO_HOST}:${PRESTO_HTTP_PORT}
HIVE_URI=thrift://${HIVE_HOST}:${HIVE_PORT}
MYSQL_URL=jdbc:mysql://${MYSQL_HOST}:${MYSQL_PORT}
PRESTO_DISCOVERY_URI=$PRESTO_DISCOVERY_URI HIVE_URI=$HIVE_URI MYSQL_URL=$MYSQL_URL /usr/local/bin/confd -onetime -backend env

./bin/launcher --config=/opt/presto/installation/etc/config.properties run
