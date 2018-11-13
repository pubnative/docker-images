#!/bin/bash

set -e

DEBUG=${DEBUG:-"false"}

if [ "${DEBUG}" = "true" ]; then
  set -o xtrace
fi

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 node_type"
  exit 1
fi

readonly node_type="$1"
shift

mkdir -p "${DRUID_DATA_DIR}"
chown druid:druid "${DRUID_DATA_DIR}"

su - druid

exec java \
  -cp conf/druid/_common:conf/druid/$node_type:lib/* \
  $DRUID_JAVA_OPTS \
  "$@" \
  io.druid.cli.Main \
  server \
  $node_type
