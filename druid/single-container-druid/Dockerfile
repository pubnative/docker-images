# Image: pubnative/single-container-druid

FROM openjdk:11-jre

RUN apt-get update \
    && apt-get install -y perl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ARG DRUID_VERSION

ENV DRUID_DOWNLOAD_URL=https://downloads.apache.org/druid/${DRUID_VERSION}/apache-druid-${DRUID_VERSION}-bin.tar.gz
ENV DRUID_SHA_URL=https://downloads.apache.org/druid/${DRUID_VERSION}/apache-druid-${DRUID_VERSION}-bin.tar.gz.sha512

RUN mkdir /opt/druid

RUN wget -q -O /tmp/druid.tar.gz ${DRUID_DOWNLOAD_URL} \
    && wget -q -O /tmp/druid.tar.gz.sha512 ${DRUID_SHA_URL}

# Verify the SHA checksum
RUN echo "$(cat /tmp/druid.tar.gz.sha512) /tmp/druid.tar.gz" | sha512sum -c -

RUN tar -xzf /tmp/druid.tar.gz -C /opt/druid --strip-components=1 \
    && rm /tmp/druid.tar.gz /tmp/druid.tar.gz.sha512

WORKDIR /opt/druid

EXPOSE 8081 8082 8083 8090 8091 8100-8199 8888

# Command to start Druid
CMD ["bin/start-micro-quickstart"]
