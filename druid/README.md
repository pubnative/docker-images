# Trino

Image used for our Druid deployment.
It builds one image and tags it as:

- `pubnative/druid:latest`,
- `pubnative/druid:${DRUID_VERSION}-${COMMIT}`

## Build

`make build`

## Deploy

`make publish`

## Docker image locally

```
docker build --build-arg DRUID_VERSION=27.0.0 -t druid_test .
docker run -it druid_test 
```
