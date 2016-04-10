FROM kibana:4.5.0
MAINTAINER PubNative Team <team@pubnative.net>

RUN /opt/kibana/bin/kibana plugin --install kibana/timelion \
    && chown -R kibana:kibana /opt/kibana
