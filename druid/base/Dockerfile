# Image: pubnative/druid

FROM openjdk:8-jre

ARG DRUID_VERSION="0.12.3"
ENV DRUID_HOME=/druid
ENV DRUID_JAVA_OPTS="-server -Xms0m -Xmx128m -Duser.timezone=UTC -Dfile.encoding=UTF-8 -Djava.util.logging.manager=org.apache.logging.log4j.jul.LogManager -XX:+PrintGC"

RUN groupadd -g 999 druid \
 && useradd -r -u 999 -g druid druid \
 && mkdir -p $DRUID_HOME \
 && curl -SL "http://static.druid.io/artifacts/releases/druid-$DRUID_VERSION-bin.tar.gz" \
  | tar zxf - --strip-components 1 -C $DRUID_HOME \
 && curl -SL "http://static.druid.io/artifacts/releases/mysql-metadata-storage-$DRUID_VERSION.tar.gz" \
  | tar zxf - -C $DRUID_HOME/extensions \
 && chown druid:druid -R $DRUID_HOME

RUN mkdir $DRUID_HOME/extensions/druid-parquet-extensions \
 && cd $DRUID_HOME/extensions/druid-parquet-extensions \
 && wget https://repo1.maven.org/maven2/io/druid/extensions/contrib/druid-parquet-extensions/$DRUID_VERSION/druid-parquet-extensions-$DRUID_VERSION.jar

USER druid
WORKDIR $DRUID_HOME

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
