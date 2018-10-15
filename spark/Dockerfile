FROM centos:7
MAINTAINER PubNative Team <team@pubnative.net>

LABEL os="centos"

ENV SPARK_VERSION="2.3.2"

RUN rpm -Uvh http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm \
  && yum update -y \
  && yum install -y mesos-1.3.0 java-1.8.0-openjdk java-1.8.0-openjdk-devel https://centos7.iuscommunity.org/ius-release.rpm \
  && yum install -y python36u python36u-pip python36u-devel \
  && yum clean all

RUN curl -SL http://ftp.halifax.rwth-aachen.de/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz \
  | tar -xzC / \
  && ln -s /spark-${SPARK_VERSION}-bin-hadoop2.7 /opt/spark && mkdir /opt/spark/lib

RUN curl -O http://central.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar \
  && mv aws-java-sdk-1.7.4.jar /opt/spark/lib/

RUN curl -O http://central.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.3/hadoop-aws-2.7.3.jar \
  && mv hadoop-aws-2.7.3.jar /opt/spark/lib/

WORKDIR /opt/spark

