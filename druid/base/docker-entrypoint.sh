#!/bin/bash -eu

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 node_type"
  exit 1
fi

readonly node_type="$1"
shift

exec java \
  `cat conf/druid/$node_type/jvm.config | xargs` \
  -cp conf/druid/_common:conf/druid/$node_type:lib/* \
  "$@" \
  io.druid.cli.Main \
  server \
  $node_type
