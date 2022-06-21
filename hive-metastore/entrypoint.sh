#!/bin/bash
set -e

$HIVE_METASTORE_HOME/bin/schematool -dbType mysql -initSchema
$HIVE_METASTORE_HOME/bin/start-metastore