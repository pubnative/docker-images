# Image pubnative/sbt-ci:0.14
FROM centos:7

ENV DOCKER_VER="17.03.2.ce-1"
ENV SBT_VER="1.3.3"
ENV DOCKERIZE_VERSION="v0.5.0"

RUN curl -L -o docker-selinux-${DOCKER_VER}.rpm https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-selinux-${DOCKER_VER}.el7.centos.noarch.rpm \
  && yum install -y docker-selinux-${DOCKER_VER}.rpm \
  && rm docker-selinux-${DOCKER_VER}.rpm \
  && curl -L -o docker-${DOCKER_VER}.rpm https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-${DOCKER_VER}.el7.centos.x86_64.rpm \
  && yum install -y docker-${DOCKER_VER}.rpm \
  && rm docker-${DOCKER_VER}.rpm

RUN curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo \
  && yum install -y git sbt-${SBT_VER} java-1.8.0-openjdk java-1.8.0-openjdk-devel \
  && sbt about
# yum downloads a thin launcher, runnning sbt actually triggers the download of sbt files

RUN curl -L -o /tmp/mysql57-community-release-el7-11.noarch.rpm https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm \
  && yum localinstall -y /tmp/mysql57-community-release-el7-11.noarch.rpm \
  && yum install -y mysql-community-client \
  && rm /tmp/mysql57-community-release-el7-11.noarch.rpm

RUN curl https://s3.amazonaws.com/aws-cli/awscli-bundle.zip -o awscli-bundle.zip \
  && yum install -y unzip \
  && unzip awscli-bundle.zip \
  && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws \
  && rm -rf ./awscli-bundle.zip ./awscli-bundle

RUN curl -L -o dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN curl -L -o /tmp/google-chrome-stable.rpm https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm \
  && yum install -y /tmp/google-chrome-stable.rpm

RUN yum install -y yum-utils \
  && rpm --import https://repo.yandex.ru/clickhouse/CLICKHOUSE-KEY.GPG \
  && yum-config-manager --add-repo https://repo.yandex.ru/clickhouse/rpm/stable/x86_64 \
  && yum install -y clickhouse-client
