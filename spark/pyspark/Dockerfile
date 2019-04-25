FROM python:3.7.3-stretch

ENV BAZEL_REPO="deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8"
ENV BAZEL_RELEASE_KEY_URL="https://bazel.build/bazel-release.pub.gpg"

ENV DOCKER_REPO="deb [arch=amd64] https://download.docker.com/linux/debian stretch stable"
ENV DOCKER_RELEASE_KEY_URL="https://download.docker.com/linux/debian/gpg"

RUN apt-get update && apt-get install -y apt-transport-https

# Install Docker.
RUN ["/bin/bash", "-c", "set -o pipefail \
    && curl -fsSL ${DOCKER_RELEASE_KEY_URL} \
    | apt-key add - \
    && echo ${DOCKER_REPO} \
    | tee /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io"]

# Install Bazel.
RUN ["/bin/bash", "-c", "set -o pipefail \
    && echo ${BAZEL_REPO}  \
    | tee /etc/apt/sources.list.d/bazel.list \
    && curl ${BAZEL_RELEASE_KEY_URL} \
    | apt-key add - \
    && apt-get update \
    && apt-get install -y openjdk-8-jdk bazel"]

# Install PySpark.
RUN pip3 install --upgrade pip \
    && pip3 install pyspark==2.4.2

# Bazel needs python2 to be the default Python interpreter (binded on `python`).
RUN update-alternatives --install /usr/local/bin/python python /usr/bin/python2.7 1
