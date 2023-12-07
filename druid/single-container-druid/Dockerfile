FROM openjdk:11-jre

RUN apt-get update \
    && apt-get install -y perl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ARG DRUID_VERSION
ARG DRUID_JAR=apache-druid-${DRUID_VERSION}-bin.tar.gz
ARG DRUID_URL=https://downloads.apache.org/druid/${DRUID_VERSION}/${DRUID_JAR}
ARG DRUID_SHA=c971ccbb4220fa2ae9f8a0a0f82c3e4b87750d27ac15d863d1e9f415863ccb8b8e5c764122dc8ef76044a42d27e1108b980ca2b88de8aff660db5a22356d6ab7
ARG WORKDIR=/opt/druid

RUN wget -q ${DRUID_URL} \
 && echo "${DRUID_SHA} ${DRUID_JAR}" | sha512sum -c - \
 && mkdir ${WORKDIR} \
 && tar -xvf ${DRUID_JAR} -C ${WORKDIR} --strip-components=1 \
 && rm -f ${DRUID_JAR}

WORKDIR ${WORKDIR}

EXPOSE 8081-8083 8090-8091 8100-8199 8888

CMD ["./bin/start-micro-quickstart"]
