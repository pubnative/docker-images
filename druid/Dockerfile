# Based on https://github.com/apache/druid/blob/master/distribution/docker/Dockerfile.mysql

ARG DRUID_VERSION
FROM apache/druid:$DRUID_VERSION

WORKDIR /opt/druid/extensions/mysql-metadata-storage

ARG MYSQL_URL=https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.30/mysql-connector-java-8.0.30.jar
ARG MYSQL_JAR=mysql-connector-java-8.0.30.jar
# https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.30/mysql-connector-java-8.0.30.jar.sha1
ARG MYSQL_SHA=b26dd6e4e917d3d4726c34d09d2fd67df7c1dd37

ADD --chown=druid:druid ${MYSQL_URL} /opt/druid/extensions/mysql-metadata-storage/

RUN echo "${MYSQL_SHA}  ${MYSQL_JAR}" | sha1sum -c \
 && ln -s ../extensions/mysql-metadata-storage/${MYSQL_JAR} /opt/druid/lib

WORKDIR /opt/druid