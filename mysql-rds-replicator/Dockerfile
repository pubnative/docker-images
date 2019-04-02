## ref: https://hub.docker.com/r/pubnative/mysql-rds-replicator

ARG MYSQL_VERSION="5.7.24"
FROM mysql:${MYSQL_VERSION}

LABEL maintainer="Eros Garcia Ponte <eros902002@googlemail.com>"

RUN apt-get update \
 && apt-get install --no-install-recommends --no-install-suggests -y \
                    curl \
                    ca-certificates \
 && apt-get purge -y --auto-remove \
 && rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/temp.list \
           /usr/share/doc \
           /var/log/ \
           /var/cache/debconf \
           /usr/share/zsh

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
