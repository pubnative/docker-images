FROM python:3.6.5

LABEL maintainer="valentin.mouret@pubnative.net"

# Java
ARG JAVA_MAJOR_VERSION=8
ARG JAVA_UPDATE_VERSION=131
ARG JAVA_BUILD_NUMBER=11

ENV JAVA_HOME /usr/jdk1.${JAVA_MAJOR_VERSION}.0_${JAVA_UPDATE_VERSION}
ENV SPARK_CLASSPATH='/opt/app/java_libs/aws-java-sdk-1.7.4.jar:/opt/app/java_libs/hadoop-aws-2.7.3.jar'
ENV PATH $PATH:$JAVA_HOME/bin

RUN curl -sL --retry 3 --insecure \
    --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
    "https://download.oracle.com/otn-pub/java/jdk/${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-b${JAVA_BUILD_NUMBER}/d54c1d3a095b4ff2b6607d096fa80163/server-jre-${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-linux-x64.tar.gz" \
    | gunzip \
    | tar x -C /usr/ \
    && ln -s $JAVA_HOME /usr/java \
    && rm -rf $JAVA_HOME/man

# AWS
RUN mkdir -p /opt/app/java_libs && cd /opt/app/java_libs
RUN wget http://central.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar -O /opt/app/java_libs/aws-java-sdk-1.7.4.jar
RUN wget http://central.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.3/hadoop-aws-2.7.3.jar -O /opt/app/java_libs/hadoop-aws-2.7.3.jar

# Mesos
RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
RUN apt -q update && apt install -y libssl1.0.0
RUN echo 'deb http://repos.mesosphere.com/ubuntu xenial main' >> /etc/apt/sources.list.d/mesosphere.list
RUN apt-get install dirmngr && apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF \
  && apt-get -y update \
  && apt-get -y install mesos=1.3.0-2.0.3 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
