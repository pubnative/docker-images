# Image: pubnative/druid

ARG DRUID_VERSION
FROM apache/druid:$DRUID_VERSION

WORKDIR /opt/druid/extensions/mysql-metadata-storage

ARG MYSQL_URL=https://repo1.maven.org/maven2/mysql/mysql-connector-java/5.1.48/mysql-connector-java-5.1.48.jar
ARG MYSQL_JAR=mysql-connector-java-5.1.48.jar
ARG MYSQL_SHA=9140be77aafa5050bf4bb936d560cbacb5a6b5c1

RUN wget -q ${MYSQL_URL} \
 && echo "${MYSQL_SHA}  ${MYSQL_JAR}" | sha1sum -c \
 && ln -s /opt/druid/extensions/mysql-metadata-storage/${MYSQL_JAR} /opt/druid/lib

WORKDIR /opt/druid
