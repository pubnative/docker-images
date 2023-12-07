FROM openjdk:11-jre

RUN apt-get update \
    && apt-get install -y perl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ARG DRUID_VERSION
ARG DRUID_JAR=apache-druid-${DRUID_VERSION}-bin.tar.gz
ARG DRUID_URL=https://downloads.apache.org/druid/${DRUID_VERSION}/${DRUID_JAR}

WORKDIR /opt/druid

RUN wget -q ${DRUID_URL}

EXPOSE 8081-8083 8090-8091 8100-8199 8888

CMD ["bin/start-micro-quickstart"]
