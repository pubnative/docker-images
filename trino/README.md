# Trino

Image used for our Trino deployment.
It builds one image and tags it as:

- `pubnative/trino:latest`,
- `pubnative/trino:${TRINO_VERSION}-${COMMIT}`

## Build

`make build`

## Deploy

`make publish`

## Docker image locally

```
docker build --build-arg TRINO_VERSION=436 --build-arg AGENT_VERSION=0.20.0 -t trino_test .
docker run -it trino_test /bin/bash
```
