FROM openjdk:8-jre

ARG HIVE_VERSION="3.1.3"
ARG HADOOP_VERSION="3.3.3"
ARG MYSQL_VERSION="8.0.29"

ENV HADOOP_HOME=/opt/hadoop
ENV HIVE_HOME=/opt/hive

WORKDIR /opt

RUN curl https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz \
   | tar xvz -C . \
   && mkdir -p ${HADOOP_HOME} \
   && mv hadoop-${HADOOP_VERSION}/* ${HADOOP_HOME} \
   && rm -r hadoop-${HADOOP_VERSION} \
   && rm -r ${HADOOP_HOME}/share/doc

RUN curl -L https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz \
   | tar xvz -C . \
   && mkdir -p ${HIVE_HOME} \
   && mv apache-hive-${HIVE_VERSION}-bin/* ${HIVE_HOME} \
   && rm -r apache-hive-${HIVE_VERSION}-bin

RUN curl -L https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_VERSION}.tar.gz \
  | tar xvz -C . \
  && cp mysql-connector-java-${MYSQL_VERSION}/mysql-connector-java-${MYSQL_VERSION}.jar ${HADOOP_HOME}/share/hadoop/common/lib/ \
  && cp mysql-connector-java-${MYSQL_VERSION}/mysql-connector-java-${MYSQL_VERSION}.jar ${HIVE_HOME}/lib/ \
  && rm -r mysql-connector-java-${MYSQL_VERSION}

RUN wget https://storage.googleapis.com/hadoop-lib/gcs/gcs-connector-hadoop3-2.2.7.jar \
  && cp gcs-connector-hadoop3-2.2.7.jar ${HIVE_HOME}/lib/ \
  && rm -r gcs-connector-hadoop3-2.2.7.jar