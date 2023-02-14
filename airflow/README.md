# Airflow

Image used for our Airflow-2 deployment.
It builds one image and tags it as:

- `pubnative/airflow-2:latest`,
- `pubnative/airflow-2:${AIRFLOW_VERSION}`

## Build

`make build`

## Deploy

`make publish`

## Update requirements.txt

`make update-req`

## Docker image locally

``` 
docker build --build-arg AIRFLOW_VERSION=2.5.1 --build-arg PYTHON_VERSION=3.7 -t airflow_test .
docker run airflow_test -h
```

## Environment Variables

If you want to run this image with gcloud authentication you should define the following environment variables 

|         ENV Var           | Description                                      | Required | 
|---------------------------|--------------------------------------------------|----------|
| GCP_AIRFLOW_ACCOUNT_EMAIL | Service account email                            | y        |
| GCP_AIRFLOW_SA_FILE_PATH  | Service account json file's path                 | y        |
| GCP_K8S_LOCATION          | GCP kubernetes location (ex: "us-east4gcpcore1") | y        |
| GCP_K8S_ZONE              | GCP kubernetes zone (ex: "us-east4")             | y        |
| GCP_K8S_PROJECT           | GCP Project that contains the cluster            | y        |

## Development Environment for DAGs

The `poetry.lock` file creates the consistent environment for development of DAGs in [data-tasks](https://github.com/pubnative/data-tasks/tree/master/airflow-2)
repository. Please do not forget to update the lock file when the image is updated.