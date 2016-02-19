#!/bin/bash

set -ex

# Add curator as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- curator "$@"
fi

# Step down via gosu
if [ "$1" = 'curator' ]; then
  export CURATOR_DELETE_COMMON="curator --host $ELASTICSEARCH_HOST --master-only delete"
  export CURATOR_DELETE="${CURATOR_DELETE_COMMON} indices --time-unit=days --timestring '%Y.%m.%d'"

  export CURRATOR_CMD_BY="${CURATOR_DELETE_COMMON} --disk-space $MAX_SPACE indices --older-than 7 --time-unit=days --timestring '%Y.%m.%d'"
  export CURRATOR_CMD_BY="${CURRATOR_CMD_BY} ; ${CURATOR_DELETE} --older-than $OLDER_THAN_IN_DAYS"
  export CURRATOR_CMD_BY="${CURRATOR_CMD_BY} ; ${CURATOR_DELETE} --older-than 3 --suffix http_requests"
  export CURRATOR_CMD_BY="${CURRATOR_CMD_BY} ; ${CURATOR_DELETE} --older-than 3 --suffix cpa_no_fill"
  export CURRATOR_CMD_BY="${CURRATOR_CMD_BY} ; ${CURATOR_DELETE} --older-than 3 --suffix domain_mismatch"
  export CURRATOR_CMD_BY="${CURRATOR_CMD_BY} ; ${CURATOR_DELETE} --older-than 3 --suffix broken_token"
  export CURRATOR_CMD_BY="${CURRATOR_CMD_BY} ; ${CURATOR_DELETE} --older-than 3 --prefix logstash-general"
  export SLEEP="sleep $(( 60*60*$INTERVAL_IN_HOURS ))"
  exec gosu curator bash -c "set +e; while true; do $CURRATOR_CMD_BY ; $SLEEP ; done"
fi

# As argument is not related to curator,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"
