#!/bin/bash

set -e

# Add airpal as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- airpal "$@"
fi

# Drop root privileges if we are running airpal
# allow the container to be started with `--user`
if [ "$1" = 'airpal' -a "$(id -u)" = '0' ]; then
	# Change the ownership of /usr/share/airpal/data to airpal
  #	chown -R airpal:airpal /usr/share/airpal/data
	
	set -- gosu airpal "$@"
	#exec gosu airpal "$BASH_SOURCE" "$@"
fi

# As argument is not related to airpal,
# then assume that user wants to run his own process,
# for example a `bash` shell to explore this image
exec "$@"