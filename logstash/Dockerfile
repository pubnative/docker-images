FROM centos:latest
MAINTAINER PubNative Team <team@pubnative.net>

ENV JAVA_HOME /usr/lib/jvm/jre
ENV LOGSTASH_VERSION 2.3.1

ADD https://download.elastic.co/logstash/logstash/packages/centos/logstash-${LOGSTASH_VERSION}-1.noarch.rpm /tmp/logstash.rpm

RUN yum update -y && \
    yum install -y \
      logrotate \
      java-1.8.0-openjdk-headless && \
    rpm -i /tmp/logstash.rpm && \
    rm -f /tmp/logstash.rpm && \
    mkdir -p /opt/logstash/plugins/logstash/filters && \
    /opt/logstash/bin/logstash-plugin install logstash-filter-de_dot

ADD ./filters /opt/logstash/plugins/logstash/filters

ENTRYPOINT ["/opt/logstash/bin/logstash", "agent", "-p", "/opt/logstash/plugins"]
