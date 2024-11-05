# Based on https://github.com/apache/druid/blob/master/distribution/docker/Dockerfile.mysql

ARG DRUID_VERSION
FROM apache/druid:$DRUID_VERSION

WORKDIR /opt/druid/extensions/mysql-metadata-storage

ARG MYSQL_URL=https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.2.0/mysql-connector-j-8.2.0.jar
ARG MYSQL_JAR=mysql-connector-j-8.2.0.jar
# https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.2.0/mysql-connector-j-8.2.0.jar.sha1
ARG MYSQL_SHA=56d34aea30915904b1c883f1cfae731dd2df6029

ADD --chown=druid:druid ${MYSQL_URL} /opt/druid/extensions/mysql-metadata-storage/

RUN echo "${MYSQL_SHA}  ${MYSQL_JAR}" | sha1sum -c \
 && ln -s ../extensions/mysql-metadata-storage/${MYSQL_JAR} /opt/druid/lib

WORKDIR /opt/druid