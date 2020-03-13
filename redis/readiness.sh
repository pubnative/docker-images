#!/bin/bash

set -euxo pipefail

CLUSTER_STATE=$(redis-cli cluster info | grep cluster_state | tr '\r' 'x')

if [ "${CLUSTER_STATE}" == "cluster_state:okx" ]; then
        exit 0
fi

exit 1
