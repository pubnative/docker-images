ARG TRINO_VERSION="439"

FROM trinodb/trino:${TRINO_VERSION}

ARG AGENT_VERSION="0.20.0"

RUN curl -o /usr/lib/trino/lib/jmx_prometheus_javaagent.jar https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${AGENT_VERSION}/jmx_prometheus_javaagent-${AGENT_VERSION}.jar

COPY --chown=trino:trino config.yaml /usr/lib/trino/
