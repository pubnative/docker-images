FROM centos:latest
MAINTAINER PubNative Team <team@pubnative.net>

ADD https://download.elastic.co/logstash/logstash/packages/centos/logstash-2.1.1-1.noarch.rpm /tmp/logstash.rpm
RUN yum update -y && \
    yum install -y \
      logrotate \
      java-1.8.0 && \
    rpm -i /tmp/logstash.rpm && \
    rm -f /tmp/logstash.rpm && \
    mkdir -p /opt/logstash/plugins/logstash/filters

ADD ./filters /opt/logstash/plugins/logstash/filters

ENV JAVA_HOME /usr/lib/jvm/jre

ENTRYPOINT ["/opt/logstash/bin/logstash", "agent", "-p", "/opt/logstash/plugins"]
