# MLFlow Docker image 

Image used for our MLflow deployment.
It builds one image and tags it as:

- `us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/mlflow:latest`,
- `us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/mlflow:${MLFLOW_VERSION}-${COMMIT}`

## Build

`make build`

## Deploy

`make publish`

## Docker image locally

``` 
docker build --build-arg MLFLOW_VERSION=v2.0.1 -t mlflow_test .
docker run -it mlflow_test /bin/bash
```
