FROM java:8-jdk

MAINTAINER PubNative Team <team@pubnative.net>

RUN apt-get update -y

ENV PRESTO_VERSION 0.153

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

ENV PRESTO_INCLUDE_COORDINATOR false
ENV PRESTO_COORDINATOR_ENABLED false
ENV PRESTO_DISCOVERY_ENABLED false
ENV PRESTO_QUERY_MAXMEMORY 20GB
ENV PRESTO_QUERY_MAXMEMORY_PERNODE 1GB
ENV PRESTO_QUERY_MAX_AGE 2880m
ENV PRESTO_ENVIRONMENT production
ENV PRESTO_DATADIR /opt/presto/data
ENV PRESTO_LOG_LEVEL ERROR
ENV PRESTO_DISCOVERY_HOST localhost
ENV PRESTO_DISCOVERY_PORT 8080
ENV PRESTO_HTTP_PORT 8080
ENV JAVA_MAXHEAP_SIZE 16G

ADD confd /etc/confd
ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
