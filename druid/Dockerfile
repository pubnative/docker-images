# Based on https://github.com/apache/druid/blob/master/distribution/docker/Dockerfile.mysql

ARG DRUID_VERSION
FROM apache/druid:$DRUID_VERSION

WORKDIR /opt/druid/extensions/mysql-metadata-storage

ARG MYSQL_URL=https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.49/mysql-connector-java-5.1.49.jar
ARG MYSQL_JAR=mysql-connector-java-5.1.49.jar
# https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.49/mysql-connector-java-5.1.49.jar.sha1
ARG MYSQL_SHA=cf76d2e4c9c3782a85c15c87bec5772b34ffd0e5

RUN wget -q ${MYSQL_URL} \
 && echo "${MYSQL_SHA}  ${MYSQL_JAR}" | sha1sum -c \
 && ln -s ../extensions/mysql-metadata-storage/${MYSQL_JAR} /opt/druid/lib

WORKDIR /opt/druid
