# Single-container Druid Docker Image

This custom Docker image for Apache Druid is tailored to our specific needs, addressing limitations we encountered with
the official Druid Docker image. It's particularly useful in environments where the standard Druid Docker setup, which
is often optimized for docker-compose or multi-node configurations, doesn't align with our requirements, e.g. E2E
testing.

## Why do we need this image?

- **Custom Configuration**: This image includes additional packages and configurations not present in the official Druid
  image, making it more suited for our specific use cases, e.g. perl not present for running start-micro-quickstart.

- **CircleCI Compatibility**: The official Druid image and docker-compose setup worked well locally but presented
  challenges in our CircleCI environment. This image is designed to be more CI/CD friendly.

- **Simplified Setup**: It offers a simplified and streamlined setup for single-node environments, removing the
  complexity of multi-node configurations.

## Build

`make -C ../ build DOCKER_REPO=us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/single-container-druid DOCKER_REPO_DOCKERFILE_FOLDER=./single-container-druid DRUID_VERSION=28.0.0`

## Deploy

`make -C ../ publish DOCKER_REPO=us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/single-container-druid DOCKER_REPO_DOCKERFILE_FOLDER=./single-container-druid DRUID_VERSION=28.0.0`

## Docker image locally

```
docker build --build-arg DRUID_VERSION=28.0.0 -t druid_test .
docker run -it --entrypoint /bin/bash druid_test 
```