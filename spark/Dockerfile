FROM centos:7
MAINTAINER PubNative Team <team@pubnative.net>

LABEL os="centos"

ENV SPARK_VERSION="2.0.2"

RUN rpm -Uvh http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm \
  && yum update -y \
  && yum install -y mesos-0.28.2 java-1.8.0-openjdk java-1.8.0-openjdk-devel \
  && yum clean all

RUN curl -SL http://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz \
  | tar -xzC / \
  && ln -s /spark-${SPARK_VERSION}-bin-hadoop2.7 /spark

WORKDIR /spark

