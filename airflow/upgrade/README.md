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
