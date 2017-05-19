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
  && ln -s /spark-${SPARK_VERSION}-bin-hadoop2.7 /opt/spark && mkdir /opt/spark/lib

RUN curl -O http://central.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar \
  && mv aws-java-sdk-1.7.4.jar /opt/spark/lib/

RUN curl -O http://central.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.2/hadoop-aws-2.7.2.jar \
  && mv hadoop-aws-2.7.2.jar /opt/spark/lib/

WORKDIR /opt/spark

