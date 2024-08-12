#!/bin/bash

# Updates the REST API plugin.
#
# Usage
#   $ airflow/plugins/update_api_plugin.sh
#
#   By default, it will update the plugin for version 1.0.7-communicate.
   
source airflow/plugins/deploy.sh

set -euxo pipefail

function download_archive {
  local url="https://github.com/pubnative/airflow-rest-api-plugin/archive/${VERSION}.zip"
  local archive_name="v${VERSION}.zip"
  local destination
  destination=$(mktemp -d)

  curl \
    "$url" \
    -L \
    -o "$destination/$archive_name"
  unzip "$destination/$archive_name" -d ./
}

function import {
  cp "$DEFLATED_NAME/plugins/rest_api_plugin.py" "./airflow/plugins"
  cp -r "$DEFLATED_NAME/plugins/templates" "./airflow/plugins"
}

function copy_on_remote {
  deploy_file "rest_api_plugin.py"
  deploy_file "templates"
}
function cleanup {
  rm -r ./"$DEFLATED_NAME"
  rm -r ./airflow/plugins/{rest_api_plugin.py,templates}
}

function update {
  download_archive \
  && import \
  && copy_on_remote \
  && cleanup
}

VERSION=${1:-"1.0.7-communicate"}
DEFLATED_NAME="airflow-rest-api-plugin-${VERSION}"
update
