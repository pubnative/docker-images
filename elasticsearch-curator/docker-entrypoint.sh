#!/bin/bash

set -ex

envtpl /etc/curator.yml.tpl
envtpl /etc/actions.yml.tpl

echo "config:"
cat /etc/curator.yml
echo "actions:"
cat /etc/actions.yml

# Add curator as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- curator "$@"
fi

# Step down via gosu
if [ "$1" = 'curator' ]; then
  export SLEEP="sleep $(( 60*60*$INTERVAL_IN_HOURS ))"
  exec gosu curator bash -c "set +e; while true; do date; curator --config /etc/curator.yml /etc/actions.yml ; $SLEEP ; done"
fi

# As argument is not related to curator,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"
