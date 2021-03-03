# Airflow

Image used for our Airflow deployment.
It builds one image and tags it as:

- `pubnative/airflow:latest`,
- `pubnative/airflow:plugins-${GIT_COMMIT}`

Where `${GIT_COMMIT}` is the first seven characters of the git commit.

## Build

`make -C airflow build`

## Deploy

`make -C airflow push`

## Both

`make -C airflow`

## Update requirements.txt

`make -C airflow update_req`

## Docker image locally

``` bash
    docker build -t airflow_test .

    docker run airflow_test -h
```

## Environment Variables

If you want to run this image with gcloud authentication you should define the following environment variables 


|         ENV Var           |                    Description                   | Require | 
|---------------------------|--------------------------------------------------|---------|
| GCP_AIRFLOW_ACCOUNT_EMAIL | Service account email                            |    y    |
| GCP_AIRFLOW_SA_FILE_PATH  | Service account json file's path                 |    y    |
| GCP_K8S_LOCATION          | GCP kubernetes location (ex: "us-east4gcpcore0") |    y    |
| GCP_K8S_ZONE              | GCP kubernetes zone (ex: "us-east4")              |    y    |
| GCP_K8S_PROJECT           | GCP Project that contains the cluster            |    y    |