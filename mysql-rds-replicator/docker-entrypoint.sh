#!/bin/bash

set -xeuo pipefail

: ${RDS_PASSWORD?Need a value}
: ${RDS_REPLICA_HOST?Need a value}
: ${RDS_USER?Need a value}
: ${MYSQL_HOST?Need a value}
: ${MYSQL_USER?Need a value}
: ${MYSQL_PORT?Need a value}
: ${RDS_DATABASE?Need a value}
: ${RDS_MASTER_HOST?Need a value}
: ${REPLICATION_USER?Need a value}
: ${REPLICATION_PASSWORD?Need a value}

# Download the RDS CA pem in `/cert` dir which will be used to enable SSL/TLS
# for interaction with RDS
function download_rds_ca() {
  mkdir /cert && cd /cert
  echo "Downloading RDS CA bundle..."
  curl -fsSLO https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem
}

function wait_for_rds_slave_ready() {
  # make sure that the RDS Read Replica has replicated everything from RDS Master
  while true; do
    # get the information on what the RDS Read Replica looks like
    slave_status=$(mysql --host="${RDS_REPLICA_HOST}" --user="${RDS_USER}" \
      --password="${RDS_PASSWORD}" --ssl-ca=/cert/rds-combined-ca-bundle.pem \
      --execute="SHOW SLAVE STATUS\G")

    # make sure that the `Seconds_Behind_Master` is 0 which means everything is replicated
    # if it is NULL means replication was stopped in previously failed iteration of this job
    seconds_behind_master=$(grep "Seconds_Behind_Master" <<<"${slave_status}" | cut -f2 -d: | xargs)
    if [ "${seconds_behind_master}" == "0" ] || [ "${seconds_behind_master}" == NULL ]; then
      break
    fi
    echo "RDS Read Replica still replicating..."
    sleep $((seconds_behind_master / 10 + 1))
  done
  echo "RDS Read Replica done replicating"
}

function stop_replication_on_rds_slave() {
  readonly mysql_query=$(echo mysql \
    --host="${RDS_REPLICA_HOST}" \
    --user=${RDS_USER} \
    --password=${RDS_PASSWORD} \
    --ssl-ca=/cert/rds-combined-ca-bundle.pem \
    --execute)
  $mysql_query "CALL mysql.rds_stop_replication;"

  slave_status=$($mysql_query "SHOW SLAVE STATUS\G")

  RDS_MASTER_HOST_LOG_FILE=$(grep "Relay_Master_Log_File" <<<"${slave_status}" | cut -f2 -d: | xargs)
  RDS_MASTER_HOST_LOG_POS=$(grep "Exec_Master_Log_Pos" <<<"${slave_status}" | cut -f2 -d: | xargs)
}

function create_replica_user_on_master() {
  cat <<EOF
    CREATE USER IF NOT EXISTS '${REPLICATION_USER}'@'%' IDENTIFIED BY '${REPLICATION_PASSWORD}';
    GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO '${REPLICATION_USER}'@'%';
    SHOW GRANTS FOR '${REPLICATION_USER}'@'%';
EOF

  mysql \
    --host="${RDS_MASTER_HOST}" \
    --user="${RDS_USER}" \
    --password="${RDS_PASSWORD}" \
    --ssl-ca=/cert/rds-combined-ca-bundle.pem <<EOF
    CREATE USER IF NOT EXISTS '${REPLICATION_USER}'@'%' IDENTIFIED BY '${REPLICATION_PASSWORD}';
    GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO '${REPLICATION_USER}'@'%';
    SHOW GRANTS FOR '${REPLICATION_USER}'@'%';
EOF
}

function start_replication_on_rds_slave() {
  mysql \
    --host="${RDS_REPLICA_HOST}" \
    --user="${RDS_USER}" \
    --password="${RDS_PASSWORD}" \
    --ssl-ca=/cert/rds-combined-ca-bundle.pem \
    --execute="CALL mysql.rds_start_replication;"
}

function dump_mysql_db() {
  mysqldump \
    --host="${RDS_REPLICA_HOST}" \
    --user="${RDS_USER}" \
    --password="${RDS_PASSWORD}" \
    --databases mysql \
    --port=3306 --single-transaction --routines --skip-triggers \
    --ssl-ca=/cert/rds-combined-ca-bundle.pem \
    --set-gtid-purged=OFF |
    mysql \
      --host="${MYSQL_HOST}" \
      --user=root \
      --password="${MYSQL_PASSWORD}" \
      --port="${MYSQL_PORT}"
}

function set_permissions() {
  mysql --host="${MYSQL_HOST}" --user=root --password="${MYSQL_PASSWORD}" \
    --port="${MYSQL_PORT}" --execute="FLUSH PRIVILEGES;"

  mysql --host="${MYSQL_HOST}" --user=root --password="${RDS_PASSWORD}" --port="${MYSQL_PORT}" <<EOF
      UPDATE mysql.user SET Grant_priv='Y', Super_priv='Y' WHERE User='root';
      FLUSH PRIVILEGES;
EOF
}

function dump_main_db() {
  mysqldump \
    --host="${RDS_REPLICA_HOST}" \
    --user="${RDS_USER}" \
    --password="${RDS_PASSWORD}" \
    --databases "${RDS_DATABASE}" \
    --port=3306 \
    --single-transaction \
    --routines \
    --skip-triggers \
    --ssl-ca=/cert/rds-combined-ca-bundle.pem \
    --set-gtid-purged=OFF |
    mysql \
      --host="${MYSQL_HOST}" \
      --user=root \
      --password="${RDS_PASSWORD}" \
      --port="${MYSQL_PORT}"
}

function start_active_replication() {
  cat <<EOF
    CHANGE MASTER TO MASTER_HOST="${RDS_MASTER_HOST}",MASTER_USER="${REPLICATION_USER}",MASTER_PASSWORD="${REPLICATION_PASSWORD}",MASTER_LOG_FILE="${RDS_MASTER_HOST_LOG_FILE}",MASTER_LOG_POS=${RDS_MASTER_HOST_LOG_POS};
    START SLAVE;
    SHOW SLAVE STATUS\G
EOF

  mysql \
    --host="${MYSQL_HOST}" \
    --user=root \
    --password="${RDS_PASSWORD}" \
    --port="${MYSQL_PORT}" <<EOF
    CHANGE MASTER TO MASTER_HOST="${RDS_MASTER_HOST}",MASTER_USER="${REPLICATION_USER}",MASTER_PASSWORD="${REPLICATION_PASSWORD}",MASTER_LOG_FILE="${RDS_MASTER_HOST_LOG_FILE}",MASTER_LOG_POS=${RDS_MASTER_HOST_LOG_POS};
    START SLAVE;
    SHOW SLAVE STATUS\G
EOF
}

download_rds_ca
create_replica_user_on_master
wait_for_rds_slave_ready
stop_replication_on_rds_slave
dump_mysql_db
set_permissions
dump_main_db
start_active_replication
start_replication_on_rds_slave
