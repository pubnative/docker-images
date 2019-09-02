#!/bin/bash

set -euo pipefail

readonly fdb_cluster="${FDB_CLUSTER}"
readonly data_dir="${DATA_DIR:-/var/lib/foundationdb/data}"
readonly log_dir="${LOG_DIR:-/var/log/foundationdb}"
readonly cluster_file="/etc/foundationdb/fdb.cluster"
readonly seed="${SEED_FILE:-/etc/fdb-seed/fdb.cluster}"

if [ -s "$seed" ]; then
    echo ">> Using seed from $seed"
    cat $seed > $cluster_file
elif [ -n "${FDB_COORDINATORS_FQDN:-}" ]; then
    echo ">> Bootstrapping $cluster_file from FQDN"

    # Wait 30 seconds till kubernetes endpoints and DNS are
    # properly propagated
    for (( i = 0; i < 10; i++ )); do
        ips=""
        for fqdn in $FDB_COORDINATORS_FQDN; do
            echo ">>> Resolving $fqdn"
            for ip in $(dig +short $fqdn); do
                ips+="$ip:4500,"
            done
        done
        ips="${ips%,}"
        [ -n "$ips" ] && break
        echo ">>> No IPs, wait 3 secs and try one more time ($i)"
        sleep 3
    done

    if [ -z "$ips" ]; then
        echo ">> No IPs found"
        exit 1
    fi

    echo "${fdb_cluster}@${ips}" > $cluster_file
fi

echo ">> Using cluster file:"
cat $cluster_file || :

cat > /etc/foundationdb/foundationdb.conf <<EOD
[fdbmonitor]
user = foundationdb
group = foundationdb

[general]
restart_delay = 60
cluster_file = $cluster_file

[fdbserver]
command = /usr/sbin/fdbserver
public_address = auto:\$ID
listen_address = public
datadir = $data_dir/\$ID
logdir = $log_dir

memory = ${FDB_MEMORY:-8GiB}
storage_memory = ${FDB_STORAGE_MEMORY:-1GiB}

locality_zoneid = ${FDB_ZONE_ID:-$(hostname)}
locality_dcid = ${FDB_DATACENTER_ID:-none}

[backup_agent]
command = /usr/lib/foundationdb/backup_agent/backup_agent
logdir = /var/log/foundationdb

[backup_agent.1]

EOD

for i in $(seq ${FDB_PROCESS_COUNT:-1}); do
    cat >> /etc/foundationdb/foundationdb.conf <<EOD
[fdbserver.$((4499 + i))]

EOD
done

set -x
chown foundationdb:foundationdb "$data_dir" "$log_dir" "$cluster_file" || :

/usr/lib/foundationdb/fdbmonitor & pid=$!

trap "kill $pid" SIGHUP SIGINT SIGQUIT SIGTERM
wait $pid
