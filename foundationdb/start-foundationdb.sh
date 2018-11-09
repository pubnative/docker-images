#!/bin/bash

set -euo pipefail

readonly fdb_cluster="${FDB_CLUSTER}"
readonly data_dir="${DATA_DIR:-/var/lib/foundationdb/data}"
readonly cluster_file="/etc/foundationdb/fdb.cluster"

if [ -n "${FDB_COORDINATORS_FQDN:-}" ]; then
    echo ">> Configuring $cluster_file"

    for (( i = 0; i < 30; i++ )); do
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

echo ">> $cluster_file:"
cat "$cluster_file"

if [ -n "${FDB_DATACENTER_ID:-}" ]; then
    echo ">> setting datacenter_id"
    sed -Ei "s/(# )?datacenter_id =.*/datacenter_id = $FDB_DATACENTER_ID/" \
        /etc/foundationdb/foundationdb.conf
fi
if [ -n "${FDB_MACHINE_ID:-}" ]; then
    echo ">> setting machine_id"
    sed -Ei "s/(# )?machine_id =.*/machine_id = $FDB_MACHINE_ID/" \
        /etc/foundationdb/foundationdb.conf
fi

set -x
chown foundationdb:foundationdb "$data_dir" "$cluster_file"

/usr/lib/foundationdb/fdbmonitor &

trap 'kill $!' SIGHUP SIGINT SIGQUIT SIGTERM
wait
