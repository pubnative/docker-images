# Image: pubnative/druid

FROM openjdk:8-jre

ARG DRUID_VERSION="0.12.2"
ENV DRUID_HOME=/druid

RUN groupadd -g 999 druid \
 && useradd -r -u 999 -g druid druid \
 && mkdir -p $DRUID_HOME \
 && curl -SL "http://static.druid.io/artifacts/releases/druid-$DRUID_VERSION-bin.tar.gz" \
  | tar zxf - --strip-components 1 -C $DRUID_HOME \
 && chown druid:druid -R $DRUID_HOME

USER druid
WORKDIR $DRUID_HOME

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
