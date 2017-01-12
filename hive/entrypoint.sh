#!/usr/bin/env bash
set -e

export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::")
envsubst < /opt/hadoop/etc/hadoop/hive-site.xml.tpl > /opt/hadoop/etc/hadoop/hive-site.xml

exec "$@"
