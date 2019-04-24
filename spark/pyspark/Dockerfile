FROM python:3.7.3-stretch

ARG BAZEL_REPO="deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8"
ARG BAZEL_RELEASE_KEY_URL=https://bazel.build/bazel-release.pub.gpg

RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    echo ${BAZEL_REPO}  \
    | tee /etc/apt/sources.list.d/bazel.list && \
    curl ${BAZEL_RELEASE_KEY_URL} \
    |apt-key add - && \
    apt-get update && \
    apt-get install -y bazel && \
    pip3 install pyspark
