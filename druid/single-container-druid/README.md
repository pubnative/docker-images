# Single-container Druid Docker Image

This custom Docker image for Apache Druid is tailored to our specific needs, addressing limitations we encountered with
the official Druid Docker image. It's particularly useful in environments where the standard Druid Docker setup, which
is often optimized for docker-compose or multi-node configurations, doesn't align with our requirements, e.g. E2E
testing.

## Why do we need this image?

- **Custom Configuration**: This image includes additional packages and configurations not present in the official Druid
  image, making it more suited for our specific use cases.

- **CircleCI Compatibility**: The official Druid image and docker-compose setup worked well locally but presented
  challenges in our CircleCI environment. This image is designed to be more CI/CD friendly.

- **Simplified Setup**: It offers a simplified and streamlined setup for single-node environments, removing the
  complexity of multi-node configurations.

## Build

Use the following command to build the custom Druid Docker image. Replace `<druid_version>` with the desired version of
Druid, and `<child_folder_with_Dockerfile>` with the path to the folder containing your custom Dockerfile.

```shell
$ make build DRUID_VERSION=<druid_version> DOCKER_REPO_DOCKERFILE_FOLDER=<child_folder_with_Dockerfile>

```

## run

```shell
docker run  -p 8081:8081 -p 8082:8082 -p 8083:8083 -p 8888:8888 --name my-druid-container pubnative/single-container-druid:v28.0.0

