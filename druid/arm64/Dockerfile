ARG DRUID_VERSION="33.0.0"
ARG JDK_VERSION="17"
FROM apache/druid:$DRUID_VERSION AS druid

## Based on https://github.com/apache/druid/blob/master/distribution/docker/Dockerfile
FROM alpine:3 AS bash-static
ARG TARGETARCH="arm64"
#
# Download bash-static binary to execute scripts that require bash.
# Although bash-static supports multiple platforms, but there's no need for us to support all those platform, amd64 and arm64 are enough.
#
ARG BASH_URL_BASE="https://github.com/robxu9/bash-static/releases/download/5.1.016-1.2.3"
RUN if [ "$TARGETARCH" = "arm64" ]; then \
      BASH_URL="${BASH_URL_BASE}/bash-linux-aarch64" ; \
    elif [ "$TARGETARCH" = "amd64" ]; then \
      BASH_URL="${BASH_URL_BASE}/bash-linux-x86_64" ; \
    else \
      echo "Unsupported architecture ($TARGETARCH)" && exit 1; \
    fi; \
    echo "Downloading bash-static from ${BASH_URL}" \
    && wget ${BASH_URL} -O /bin/bash

FROM busybox:1.35.0-glibc AS busybox

FROM gcr.io/distroless/java$JDK_VERSION-debian12
LABEL maintainer="Apache Druid Developers <dev@druid.apache.org>"

COPY --from=busybox /bin/busybox /busybox/busybox
RUN ["/busybox/busybox", "--install", "/bin"]

RUN addgroup -S -g 1000 druid \
 && adduser -S -u 1000 -D -H -h /opt/druid -s /bin/sh -g '' -G druid druid


COPY --from=bash-static /bin/bash /bin/bash
RUN chmod 755 /bin/bash

### Instead copy files from apache:druid
COPY --from=druid /druid.sh /druid.sh
COPY --from=druid /peon.sh /peon.sh
COPY --from=druid /deduplicate_jars.sh /deduplicate_jars.sh

RUN --mount=type=bind,from=druid,source=/opt,target=/builder/opt \
 mkdir -p /opt/druid/var /opt/shared \
 && cp -r /builder/opt/druid /opt/ \
 && /deduplicate_jars.sh /opt/druid \
 && chown -R druid:druid /opt/druid /opt/shared \
 && chmod 775 /opt/druid/var /opt/shared

# Based on https://github.com/apache/druid/blob/master/distribution/docker/Dockerfile.mysql
WORKDIR /opt/druid/extensions/mysql-metadata-storage

ARG MYSQL_URL="https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.2.0/mysql-connector-j-8.2.0.jar"
ARG MYSQL_JAR="mysql-connector-j-8.2.0.jar"
ARG MYSQL_SHA="56d34aea30915904b1c883f1cfae731dd2df6029"

ADD --chown=druid:druid ${MYSQL_URL} /opt/druid/extensions/mysql-metadata-storage/

RUN echo "${MYSQL_SHA}  ${MYSQL_JAR}" | sha1sum -c \
 && ln -s ../extensions/mysql-metadata-storage/${MYSQL_JAR} /opt/druid/lib

USER druid
VOLUME /opt/druid/var
WORKDIR /opt/druid

ENTRYPOINT ["/druid.sh"]
