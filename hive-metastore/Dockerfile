FROM openjdk:8-jre

ARG HIVE_METASTORE_VERSION="3.0.0"
ARG HADOOP_VERSION="3.3.3"
ARG MYSQL_VERSION="8.0.29"

ENV HADOOP_HOME=/opt/hadoop
ENV HIVE_METASTORE_HOME=/opt/hive-metastore

WORKDIR /opt

RUN curl https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz \
   | tar xvz -C . \
   && mkdir -p ${HADOOP_HOME} \
   && mv hadoop-${HADOOP_VERSION}/* ${HADOOP_HOME} \
   && rm -r hadoop-${HADOOP_VERSION} \
   && rm -r ${HADOOP_HOME}/share/doc

RUN curl -L https://archive.apache.org/dist/hive/hive-standalone-metastore-${HIVE_METASTORE_VERSION}/hive-standalone-metastore-${HIVE_METASTORE_VERSION}-bin.tar.gz \
   | tar xvz -C . \
   && mkdir -p ${HIVE_METASTORE_HOME} \
   && mv apache-hive-metastore-${HIVE_METASTORE_VERSION}-bin/* ${HIVE_METASTORE_HOME} \
   && rm -r apache-hive-metastore-${HIVE_METASTORE_VERSION}-bin

RUN curl -L https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_VERSION}.tar.gz \
  | tar xvz -C . \
  && cp mysql-connector-java-${MYSQL_VERSION}/mysql-connector-java-${MYSQL_VERSION}.jar ${HADOOP_HOME}/share/hadoop/common/lib/ \
  && cp mysql-connector-java-${MYSQL_VERSION}/mysql-connector-java-${MYSQL_VERSION}.jar ${HIVE_METASTORE_HOME}/lib/ \
  && rm -r mysql-connector-java-${MYSQL_VERSION}