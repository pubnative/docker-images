#!/bin/bash

set -euo pipefail

readonly fdb_cluster="${FDB_CLUSTER}"
readonly data_dir="${DATA_DIR:-/var/lib/foundationdb/data}"
readonly cluster_file="/etc/foundationdb/fdb.cluster"

seed="${SEED_FILE:-/etc/fdb-seed/fdb.cluster}"
if [ -s "$seed" ]; then
    echo ">> Using seed $seed:"
    cat $seed

    sed -i "/\[fdbserver\]/a seed_cluster_file = $seed" \
        /etc/foundationdb/foundationdb.conf

    rm $cluster_file
elif [ -n "${FDB_COORDINATORS_FQDN:-}" ]; then
    echo ">> Bootstrapping $cluster_file"

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
    echo ">> Using cluster file:"
    cat $cluster_file
fi

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
chown foundationdb:foundationdb "$data_dir" "$cluster_file" || :

/usr/lib/foundationdb/fdbmonitor &

trap 'kill $!' SIGHUP SIGINT SIGQUIT SIGTERM
wait
