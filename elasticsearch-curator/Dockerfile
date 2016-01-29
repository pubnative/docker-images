FROM python:2.7
MAINTAINER PubNative Team <team@pubnative.net>

COPY docker-entrypoint.sh /

# grab gosu for easy step-down from root
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN arch="$(dpkg --print-architecture)" \
	&& set -x \
	&& curl -o /usr/local/bin/gosu -fSL "https://github.com/tianon/gosu/releases/download/1.3/gosu-$arch" \
	&& curl -o /usr/local/bin/gosu.asc -fSL "https://github.com/tianon/gosu/releases/download/1.3/gosu-$arch.asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r curator && useradd -r -g curator curator \
    && pip install elasticsearch-curator==3.4.0 \
    && chown curator:curator /docker-entrypoint.sh \
    && chmod +x /docker-entrypoint.sh

ENV INTERVAL_IN_HOURS=24
ENV OLDER_THAN_IN_DAYS="20"
ENV ELASTICSEARCH_HOST=elasticsearch
ENV MAX_SPACE=10024

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["curator"]
