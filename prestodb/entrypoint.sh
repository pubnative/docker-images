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

[ "x${CATALOG_URL}" = "x" ] && {
   fatal "CATALOG_URL must be defined"
}

echo "fetching catalog of connectors:"
wget -q -O - ${CATALOG_URL} | tar xvfz - -C /opt/presto/installation/etc

export PRESTO_DISCOVERY_URI=http://${PRESTO_DISCOVERY_HOST}:${PRESTO_DISCOVERY_PORT}
/usr/local/bin/confd -onetime -backend env

./bin/launcher --config=/opt/presto/installation/etc/config.properties run
