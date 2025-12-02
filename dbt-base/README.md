# This is a basic image for performing a dbt task in K8S.

## Mandatory environments parameters:
    - GITHUB_PROJECT_ADDRESS - Git repository with dbt project, example - git@github.com:vervegroup/dbt.git
    - DBT_LOCAL_PATH - DBT project location relatively home directory, example - dbt
    - TRINO_USER
    - TRINO_PASSWORD

## Default environment variables (possible to reassign)
    - BRANCH_NAME - default checkpoint commit (main)

## Run docker container locally
docker run -it --rm  \
--env-file ./.env \
-v ./ssh/gitSshKey:/etc/git-secret/gitSshKey \
us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/dbt-base:latest --version