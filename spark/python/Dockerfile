FROM python:3.6.5-stretch

LABEL maintainer="valentin.mouret@pubnative.net"

# Java
ARG JAVA_MAJOR_VERSION=8
ARG JAVA_UPDATE_VERSION=131
ARG JAVA_BUILD_NUMBER=11

ENV JAVA_HOME /usr/jdk1.${JAVA_MAJOR_VERSION}.0_${JAVA_UPDATE_VERSION}
ENV SPARK_CLASSPATH='/opt/app/java_libs/aws-java-sdk-1.7.4.jar:/opt/app/java_libs/hadoop-aws-2.7.3.jar'
ENV PATH $PATH:$JAVA_HOME/bin
ENV SPARK_VERSION 2.3.2

RUN curl -sL --retry 3 --insecure \
    --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
    "https://download.oracle.com/otn-pub/java/jdk/${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-b${JAVA_BUILD_NUMBER}/d54c1d3a095b4ff2b6607d096fa80163/server-jre-${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-linux-x64.tar.gz" \
    | gunzip \
    | tar x -C /usr/ \
    && ln -s $JAVA_HOME /usr/java \
    && rm -rf $JAVA_HOME/man

# AWS
RUN mkdir -p /opt/app/java_libs && cd /opt/app/java_libs \
    && wget http://central.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar -O /opt/app/java_libs/aws-java-sdk-1.7.4.jar \
    && wget http://central.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.3/hadoop-aws-2.7.3.jar -O /opt/app/java_libs/hadoop-aws-2.7.3.jar

#Spark
RUN curl -SL http://ftp.halifax.rwth-aachen.de/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz \
  | tar -xzC / \
  && ln -s /spark-${SPARK_VERSION}-bin-hadoop2.7 /opt/spark && mkdir /opt/spark/lib
