#!/bin/sh

TTL=${HADOOP_LOCAL_DIR_TTL:-2880}
echo "[$(date)] Cleaning up with ttl: ${TTL}"
find /tmp/hadoop-root/mapred/local/localRunner/root/jobcache -mmin +$TTL -delete
find /tmp/druid/base* -mmin +$TTL -delete
