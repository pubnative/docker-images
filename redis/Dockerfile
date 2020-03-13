FROM redis:5.0.7

MAINTAINER PubNative Team <team@pubnative.net>

RUN apt-get update && \
    apt-get install dnsutils -y && \
    mkdir /health && \
    rm -rf /var/lib/apt/lists/*

COPY liveness.sh readiness.sh /health/
