# Druid 

Image used for our Druid deployment.
It builds one image and tags it as:

- `us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/druid:latest`,
- `us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/druid:${DRUID_VERSION}-${COMMIT}`

## Build

`make build`

## Deploy

`make publish`

## Docker image locally

```
docker build --build-arg DRUID_VERSION=31.0.0 -t druid_test .
docker run -it --entrypoint /bin/bash druid_test 
```