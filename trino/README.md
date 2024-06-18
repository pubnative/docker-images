# Trino

Image used for our Trino deployment.
It builds one image and tags it as:

- `us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/trino:latest`,
- `us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/trino:${TRINO_VERSION}-${COMMIT}`

## Build

`make build`

## Deploy

`make publish`

## Docker image locally

```
docker build --build-arg TRINO_VERSION=448 --build-arg AGENT_VERSION=0.20.0 -t trino_test .
docker run -it trino_test /bin/bash
```
