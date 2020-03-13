#!/bin/bash

set -euxo pipefail

NODE_STATE="$(redis-cli ping)"

if [ "${NODE_STATE}" == "PONG" ]; then
        exit 0
fi

exit 1
