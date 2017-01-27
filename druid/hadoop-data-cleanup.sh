#!/bin/sh

echo "$HADOOP_LOCAL_DIR_TTL"
if [ "$HADOOP_LOCAL_DIR_TTL" != "" ]; then
  echo 'cleaning up'
  find /tmp/hadoop-root/mapred/local/localRunner/root/jobcache -mmin +$HADOOP_LOCAL_DIR_TTL -delete
fi
