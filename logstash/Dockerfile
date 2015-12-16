FROM centos:latest
MAINTAINER PubNative Team <team@pubnative.net>

ADD https://download.elastic.co/logstash/logstash/packages/centos/logstash-2.1.1-1.noarch.rpm /tmp/logstash.rpm
RUN yum update -y && \
    yum install -y \
      logrotate \
      java-1.8.0 && \
    rpm -i /tmp/logstash.rpm

ENV JAVA_HOME /usr/lib/jvm/jre

ENTRYPOINT ["/opt/logstash/bin/logstash"]

