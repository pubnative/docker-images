# Image: pubnative/single-container-druid

FROM openjdk:8-jre

RUN apt-get update \
    && apt-get install -y perl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV DRUID_VERSION=28.0.0
ENV DRUID_DOWNLOAD_URL=https://downloads.apache.org/druid/${DRUID_VERSION}/apache-druid-${DRUID_VERSION}-bin.tar.gz

RUN mkdir /opt/druid

RUN wget -q -O /tmp/druid.tar.gz ${DRUID_DOWNLOAD_URL} \
    && tar -xzf /tmp/druid.tar.gz -C /opt/druid --strip-components=1 \
    && rm /tmp/druid.tar.gz

WORKDIR /opt/druid

EXPOSE 8081 8082 8083 8090 8091 8100-8199 8888

# Command to start Druid
CMD ["bin/start-micro-quickstart"]
