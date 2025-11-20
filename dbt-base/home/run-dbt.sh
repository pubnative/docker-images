#!/usr/bin/env bash
set -euo pipefail

source ~/.venv/bin/activate

# Function to check if required environment variable is set
check_required_var() {
    local var_name="$1"
    if [[ -z "${!var_name:-}" ]]; then
        echo "Error: Required environment variable '$var_name' is not set" >&2
        return 1
    fi
}

# Check all mandatory environment variables
#echo "Checking required environment variables..."
check_required_var "GITHUB_PROJECT_ADDRESS"
check_required_var "DBT_LOCAL_PATH"

# Set default value for optional variable
BRANCH_NAME="${BRANCH_NAME:-main}"

echo "All required environment variables are set"
echo "GitHub repository: ${GITHUB_PROJECT_ADDRESS}"
echo "DBT project location: ${DBT_LOCAL_PATH}"
echo "Using branch: ${BRANCH_NAME}"

GIT_SSH_COMMAND="ssh -i /etc/git-secret/ssh -o StrictHostKeyChecking=no -o IdentitiesOnly=yes " \
git clone --branch ${BRANCH_NAME} --depth 1 ${GITHUB_PROJECT_ADDRESS}

cd ${DBT_LOCAL_PATH}
dbt deps
dbt "$@"

