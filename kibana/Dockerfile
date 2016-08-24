FROM kibana:4.5.4
MAINTAINER PubNative Team <team@pubnative.net>

RUN /opt/kibana/bin/kibana plugin --install kibana/timelion \
    && /opt/kibana/bin/kibana plugin --install elastic/sense \
    && /opt/kibana/bin/kibana plugin -i vectormap -u https://github.com/stormpython/vectormap/archive/master.zip \
    && chown -R kibana:kibana /opt/kibana
