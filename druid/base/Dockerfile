# Image: pubnative/druid

FROM openjdk:8-jre

ARG DRUID_VERSION="0.12.2"
ENV DRUID_HOME=/druid
ENV DRUID_JAVA_OPTS="-server -Xms0m -Xmx128m -Duser.timezone=UTC -Dfile.encoding=UTF-8 -Djava.util.logging.manager=org.apache.logging.log4j.jul.LogManager -XX:+PrintGC"

RUN groupadd -g 999 druid \
 && useradd -r -u 999 -g druid druid \
 && mkdir -p $DRUID_HOME \
 && curl -sSL "http://static.druid.io/artifacts/releases/druid-$DRUID_VERSION-bin.tar.gz" \
  | tar zxf - --strip-components 1 -C $DRUID_HOME \
 && chown druid:druid -R $DRUID_HOME

USER druid
WORKDIR $DRUID_HOME

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
