#!/bin/sh -x
fatal() {
    echo "$@"
    exit 1
}

# config for 'log.properties'
export PRESTO_LOG_LEVEL=${PRESTO_LOG_LEVEL:-ERROR}

# config for 'jvm.config'
export JAVA_MAXHEAP_SIZE="${JAVA_MAXHEAP_SIZE:-16G}"

# config for 'node.properties'
export PRESTO_ENVIRONMENT=${PRESTO_ENVIRONMENT:-production}
export PRESTO_DATADIR=${PRESTO_DATADIR:-/opt/presto/data}
[ "x${PRESTO_UUID}" = "x" ] && {
  PRESTO_UUID=`/usr/bin/dbus-uuidgen`
  [ $? -ne 0 ] &&  fatal "uuidgen failed"
  export PRESTO_UUID
}

# config for 'config.properties'
export PRESTO_INCLUDE_COORDINATOR="${PRESTO_INCLUDE_COORDINATOR:-false}"
export PRESTO_COORDINATOR_ENABLED="${PRESTO_COORDINATOR_ENABLED:-false}"
export PRESTO_DISCOVERY_ENABLED="${PRESTO_DISCOVERY_ENABLED:-false}"
export PRESTO_HTTP_PORT="${PORT:-8080}"
export PRESTO_DISCOVERY_URI=http://${HOST:-localhost}:${PRESTO_HTTP_PORT}
export PRESTO_QUERY_MAXMEMORY="${PRESTO_QUERY_MAXMEMORY:-20GB}"
export PRESTO_QUERY_MAXMEMORY_PERNODE="${PRESTO_QUERY_MAXMEMORY_PERNODE:-1GB}"

# build configuration files
/usr/local/bin/confd -onetime -backend env

./bin/launcher --config=/opt/presto/installation/etc/config.properties run
