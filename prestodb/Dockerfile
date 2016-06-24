FROM java:8-jdk

MAINTAINER PubNative Team <team@pubnative.net>

ENV PRESTO_VERSION 0.148

RUN mkdir -p /opt/presto/data /opt/presto/installation /opt/presto/installation/etc/catalog
WORKDIR /opt/presto/installation

RUN mkdir /tmp/presto && \
    cd /tmp/presto && \
    wget -nv http://central.maven.org/maven2/com/facebook/presto/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz && \
    tar zxf presto-server-${PRESTO_VERSION}.tar.gz && \
    mv -v /tmp/presto/presto-server-${PRESTO_VERSION}/* /opt/presto/installation && \
    cd /opt/presto/installation/bin && \
    wget -nv -O presto http://central.maven.org/maven2/com/facebook/presto/presto-cli/${PRESTO_VERSION}/presto-cli-${PRESTO_VERSION}-executable.jar && \
    chmod +x presto && \
    rm -rf /tmp/presto

ENV CONFD_VERSION  0.11.0

RUN mkdir -p /usr/local/bin/ && \
    wget -nv -O /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 &&\
    chmod +x /usr/local/bin/confd

ADD confd /etc/confd
ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
