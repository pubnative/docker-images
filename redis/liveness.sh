#!/bin/bash

set -euxo pipefail

NODE_STATE="$(redis-cli ping)x"

if [ "$${NODE_STATE}" == "PONGx" ]; then
        exit 0
fi

exit 1
