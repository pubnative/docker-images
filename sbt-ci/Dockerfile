# Image pubnative/sbt-ci:0.15

FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

ARG SBT_VERSION=1.5.5
ARG DOCKERIZE_VERSION=v0.6.1

RUN apt-get update && \
    apt-get install -y \
    curl \
    gnupg \
    wget \
    openjdk-8-jdk \
    openssl \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    mysql-client \
    && rm -rf /var/lib/apt/lists/*

# Docker's key
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install Docker
RUN apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io && \
    rm -rf /var/lib/apt/lists/*

# Install SBT
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" > /etc/apt/sources.list.d/sbt.list && \
    echo "deb https://repo.scala-sbt.org/scalasbt/debian /" >> /etc/apt/sources.list.d/sbt.list && \
    curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x99E82A75642AC823" | apt-key add && \
    apt-get update && \
    apt-get install -y sbt=$SBT_VERSION && \
    rm -rf /var/lib/apt/lists/*

# Install Dockerize
RUN curl -L -o dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

