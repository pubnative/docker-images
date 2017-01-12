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

if [ "${CHARTIO_TUNNEL}" = "true" ] && [ "${PRESTO_COORDINATOR_ENABLED}" = "true" ]; then
    echo "fetching chartio private key"
    mkdir /.ssh/
    wget -q -O /.ssh/chartio ${CHARTIO_URL}
    chmod 600 /.ssh/chartio

    echo "setting up ssh tunnel"
    autossh -M 0 -f -N -R 13279:127.0.0.1:32015 tunnel13279@connect.chartio.com -g -i /.ssh/chartio -o ServerAliveInterval=10 -o ServerAliveCountMax=3 -o ExitOnForwardFailure=yes -o StrictHostKeyChecking=no
fi

echo "fetching catalog of connectors:"
wget -q -O - ${CATALOG_URL} | tar xvfz - -C /opt/presto/installation/etc

export PRESTO_DISCOVERY_URI=http://${PRESTO_DISCOVERY_HOST}:${PRESTO_DISCOVERY_PORT}
/usr/local/bin/confd -onetime -backend env

cat /opt/presto/installation/etc/*

./bin/launcher --config=/opt/presto/installation/etc/config.properties run
