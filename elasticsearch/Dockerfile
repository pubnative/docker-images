FROM elasticsearch:2.2.0
MAINTAINER PubNative Team <team@pubnative.net>

RUN /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head \
    && /usr/share/elasticsearch/bin/plugin install license \
    && /usr/share/elasticsearch/bin/plugin install marvel-agent
