FROM python:3.7.3-stretch

ARG BAZEL_REPO="deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8"
ARG BAZEL_RELEASE_KEY_URL="https://bazel.build/bazel-release.pub.gpg"

ARG DOCKER_REPO="deb [arch=amd64] https://download.docker.com/linux/debian stretch stable"
ARG DOCKER_RELEASE_KEY_URL="https://download.docker.com/linux/debian/gpg"

# Install Bazel.
RUN ["/bin/bash", "-c", "set -o pipefail \
    && apt-get update \
    && apt-get install -y openjdk-8-jdk \
    && echo ${BAZEL_REPO}  \
    | tee /etc/apt/sources.list.d/bazel.list \
    && curl ${BAZEL_RELEASE_KEY_URL} \
    | apt-key add - \
    && apt-get update \
    && apt-get install -y bazel"]

# Install PySpark.
RUN pip3 install --upgrade pip \
    && pip3 install pyspark==2.4.1

# Install Docker.
RUN ["/bin/bash", "-c", "set -o pipefail \
    && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    gnupg2 \
    software-properties-common \
    && curl -fsSL ${DOCKER_RELEASE_KEY_URL} \
    | apt-key add - \
    && echo ${DOCKER_REPO} \
    | tee /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io"]
