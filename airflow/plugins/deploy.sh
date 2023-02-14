#!/usr/bin/env bash

set -e

ALL=(
    "only_freshest_operator.py"
    "pn_plugins.py"
)
scheduler_name=$(
    kubectl \
    -n data \
    get pod \
    -l "app=airflow" \
    -o jsonpath='{.items[0].metadata.name}'
)

function deploy_file {
    FILE="$1"
    if [ "$FILE" != "" ];then
        source_path="airflow/plugins/$FILE"
        destination="data/$scheduler_name:/root/airflow/plugins/$FILE"
        kubectl cp "$source_path" "$destination" -c scheduler
    fi
}

function deploy_files {
    FILES=("$@")
    for FILE in "${FILES[@]}"
    do
        deploy_file "$FILE"
    done
}

function deploy {
    ARGS=("$@")

    if [ $# == 0 ]; then
        TO_DEPLOY=("${ALL[@]}")
    else
        TO_DEPLOY=("${ARGS[@]}")
    fi

    deploy_files "${TO_DEPLOY[@]}"
}

deploy "$@"
