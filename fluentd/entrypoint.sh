#!/usr/bin/env sh
set -e

export INPUT_SYSLOG_PORT=${SYSLOG_PORT:-5140}
export INPUT_FORWARD_PORT=${INPUT_FORWARD_PORT:-24224}
export INPUT_FORWARD_JSON_PORT=${INPUT_FORWARD_JSON_PORT:-24225}
export ES_INDEX_PREFIX=${ES_INDEX_PREFIX:-logstash}

export INPUTS=${INPUTS:-syslog}
export OUTPUTS=${OUTPUTS:-elasticsearch}

export DOLLAR='$'

echo "" > /fluentd/etc/fluent.conf

for i in $INPUTS
do
  envsubst < /fluentd/etc/inputs/$i.conf.tpl >> /fluentd/etc/fluent.conf
  echo >> /fluentd/etc/fluent.conf
done

for i in $FILTERS
do
  envsubst < /fluentd/etc/filters/$i.conf.tpl >> /fluentd/etc/fluent.conf
  echo >> /fluentd/etc/fluent.conf
done

for i in $OUTPUTS
do
  envsubst < /fluentd/etc/outputs/$i.conf.tpl >> /fluentd/etc/fluent.conf
  echo >> /fluentd/etc/fluent.conf
done

exec fluentd -c /fluentd/etc/fluent.conf -p /fluentd/plugins $FLUENTD_OPT
