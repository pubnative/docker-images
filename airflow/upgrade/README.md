# Airflow

Image used for our Airflow deployment.
It builds one image and tags it as:

- `pubnative/airflow:latest`,
- `pubnative/airflow:${GIT_COMMIT}`

Where `${GIT_COMMIT}` is the first seven characters of the git commit.

## Build

`make -C airflow build`

## Deploy

`make -C airflow push`

## Both

`make -C airflow`

## Docker image locally

``` bash
    docker build -t airflow_test .

    docker run airflow_test -h
```

## Environment Variables



  EMAIL=${GCP_AIRFLOW_ACCOUNT_EMAIL:?"Need to be set and non-empty"}
  FILE=${GCP_AIRFLOW_SA_FILE_PATH:?"Need to be set and non-empty"}
  LOCATION=${GCP_K8S_LOCATION:?"Need to be set and non-empty"}
  ZONE=${GCP_K8S_ZONE:?"Need to be set and non-empty"}
  PROJECT=${GCP_K8S_PROJECT:?"Need to be set and non-empty"}