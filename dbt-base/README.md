# This is a basic image for performing a dbt task in K8S.

## Mandatory environments parameters:
    - GITHUB_PROJECT_ADDRESS - **part of address** for git repository with dbt project after https://github.com/xxxx
    - DBT_LOCAL_PATH - DBT project location relatively home directory

## Default environment variables (possible to reassign)
    - BRANCH_NAME - default checkpoint commit (main)

## Run docker container locally
docker run -it --rm  \
--env-file ./.env \
-v ./ssh/ssh:/etc/git-secret/ssh \
pubnative/dbt-base:0.1.0 --version