FROM kibana:4.3.1

RUN /opt/kibana/bin/kibana plugin --install elasticsearch/marvel/latest \
    && chown -R kibana:kibana /opt/kibana
