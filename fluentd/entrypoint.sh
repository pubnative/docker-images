#!/usr/bin/env sh
set -e

export SYSLOG_PORT=${SYSLOG_PORT:-5140}
export ES_INDEX_PREFIX=${ES_INDEX_PREFIX:-logstash}

envsubst < /fluentd/etc/fluent.conf.tpl > /fluentd/etc/fluent.conf

exec fluentd -c /fluentd/etc/fluent.conf -p /fluentd/plugins $FLUENTD_OPT
