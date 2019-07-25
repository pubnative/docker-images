# pubnative/data-science-ci:${COMMIT}

FROM python:3.7.4-slim-stretch@sha256:b5136440d5b2d61e96747f9859f4fccbd4fe7519bc64e73e7e0341e0e7a5405f

ENV DOCKER_REPO="deb [arch=amd64] https://download.docker.com/linux/debian stretch stable"
ENV DOCKER_RELEASE_KEY_URL="https://download.docker.com/linux/debian/gpg"

RUN apt-get update \
 && apt-get install -y \
    apt-transport-https \
    curl \
    gpg

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
