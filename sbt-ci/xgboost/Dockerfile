FROM centos:7

ENV DOCKER_VER="17.03.2.ce-1"
ENV SBT_VER="0.13.12"
ENV DOCKERIZE_VERSION="v0.5.0"

RUN curl -L -o docker-selinux-${DOCKER_VER}.rpm https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-selinux-${DOCKER_VER}.el7.centos.noarch.rpm \
  && yum install -y docker-selinux-${DOCKER_VER}.rpm \
  && rm docker-selinux-${DOCKER_VER}.rpm

RUN curl -L -o docker-${DOCKER_VER}.rpm https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-${DOCKER_VER}.el7.centos.x86_64.rpm \
  && yum install -y docker-${DOCKER_VER}.rpm \
  && rm docker-${DOCKER_VER}.rpm

RUN curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo \
  && yum install -y sbt-${SBT_VER}

RUN curl -L -o /tmp/mysql57-community-release-el7-11.noarch.rpm https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm \
  && yum localinstall -y /tmp/mysql57-community-release-el7-11.noarch.rpm \
  && yum install -y mysql-community-client

RUN curl https://s3.amazonaws.com/aws-cli/awscli-bundle.zip -o awscli-bundle.zip \
  && yum install -y unzip \
  && unzip awscli-bundle.zip \
  && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

RUN curl -L -o dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz
RUN tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN curl -O http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-10.noarch.rpm
RUN rpm -ivh epel-release-7-10.noarch.rpm
RUN yum update -y && yum install -y \
    make \
    gcc gcc-c++ \
    cmake3 \
    java-1.8.0-openjdk \
    java-1.8.0-openjdk-devel \
    git \
    maven
RUN yum clean all
RUN ln /usr/bin/cmake3 /usr/bin/cmake
ENV CC=gcc CXX=g++

RUN git clone --recursive https://github.com/dmlc/xgboost
RUN cd xgboost/jvm-packages && mvn -DskipTests install

