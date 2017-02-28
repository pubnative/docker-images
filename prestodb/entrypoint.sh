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

export PRESTO_DISCOVERY_URI=http://${PRESTO_DISCOVERY_HOST}:${PRESTO_DISCOVERY_PORT}
/usr/local/bin/confd -onetime -backend env

cat /opt/presto/installation/etc/catalog/*

./bin/launcher --config=/opt/presto/installation/etc/config.properties run
