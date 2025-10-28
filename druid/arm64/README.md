# ARM64 Druid 

Image used for ARM64 Druid deployments.
It builds one image and tags it as:

- `us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/druid:${DRUID_VERSION}-${TARGETARCH}-${COMMIT}`

## Build

`make build`

## Deploy

`make publish`

## Docker image locally

```
docker build --build-arg TARGETARCH=arm64 --build-arg DRUID_VERSION=33.0.0 -t druid_test .
docker run -it --entrypoint /bin/bash druid_test 
```