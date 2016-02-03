FROM kibana:4.4.0
MAINTAINER PubNative Team <team@pubnative.net>

RUN /opt/kibana/bin/kibana plugin --install elasticsearch/marvel/latest \
    && chown -R kibana:kibana /opt/kibana
