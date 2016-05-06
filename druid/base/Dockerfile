FROM java:7

MAINTAINER Denis Zhuk denis@pubnative.net

ENV DRUID_VERSION 0.9.0
ENV DRUID_URL http://static.druid.io/artifacts/releases/druid-$DRUID_VERSION-bin.tar.gz
RUN wget -q -O - $DRUID_URL | tar -xzf - -C /opt
#ADD druid-$DRUID_VERSION /opt/druid-$DRUID_VERSION
RUN ln -s /opt/druid-$DRUID_VERSION /opt/druid

ADD common.runtime.properties /opt/druid/conf/druid/_common/
ADD start-node.sh pull-deps.sh /opt/druid/bin/

#uncomment ot to add 
#RUN /opt/druid/bin/pull-deps.sh '["io.druid.extensions:druid-s3-extensions"]'
