FROM java:8
MAINTAINER PubNative Team <tech@pubnative.net>

ENV DOCKER_VER="17.03.0-ce"
ENV DOCKERIZE_VERSION="v0.3.0"

RUN curl -L -o /tmp/docker-$DOCKER_VER.tgz https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VER.tgz \
  && tar -xz -C /tmp -f /tmp/docker-$DOCKER_VER.tgz \
  && mv /tmp/docker/* /usr/bin \
  && wget -q https://dl.bintray.com/sbt/debian/sbt-0.13.12.deb \
  && dpkg -i sbt-0.13.12.deb \
  && apt-get update && apt-get install -y lsb-release \
  && wget -O mysql-apt-config.deb https://dev.mysql.com/get/mysql-apt-config_0.8.3-1_all.deb \
  && dpkg -i mysql-apt-config.deb \
  && apt-get install -y mysql-client awscli \
  && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz
