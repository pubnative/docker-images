FROM centos:latest

MAINTAINER denis@pubnative.net

ENV DRUID_VERSION 0.9.2
ENV HADOOP_LOCAL_DIR_TTL ""
RUN yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel wget
ENV DNS_TTL=300

ENV DRUID_URL http://static.druid.io/artifacts/releases/druid-$DRUID_VERSION-bin.tar.gz
RUN wget -q -O -       $DRUID_URL | tar -xzf - -C /opt 
RUN  ln -s /opt/druid-$DRUID_VERSION /opt/druid

RUN cd /opt/druid && java -classpath "lib/*" io.druid.cli.Main tools pull-deps --clean \
  -c io.druid.extensions:mysql-metadata-storage:$DRUID_VERSION \
  -c io.druid.extensions:druid-s3-extensions:$DRUID_VERSION \
  -c io.druid.extensions:druid-avro-extensions:$DRUID_VERSION \
  -c io.druid.extensions:druid-caffeine-cache:$DRUID_VERSION \
  -c io.druid.extensions.contrib:druid-parquet-extensions:$DRUID_VERSION \
  -c io.druid.extensions.contrib:graphite-emitter:$DRUID_VERSION \
  -h org.apache.hadoop:hadoop-client:2.7.2 \
  -h org.apache.hadoop:hadoop-aws:2.7.2

ENV HADOOP_EXT_PATH /opt/druid/extensions/druid-parquet-extensions/
ENV PARQUET_URI http://central.maven.org/maven2/org/apache/parquet

# Temporary fix for warnings: `org.apache.parquet.CorruptStatistics: Ignoring statistics because created_by could not be parsed (see PARQUET-251): parquet-mr`
# until writer be migrated to 1.8.1 version
RUN rm $HADOOP_EXT_PATH/parquet-*-1.8.1.jar && \
  wget -P $HADOOP_EXT_PATH $PARQUET_URI/parquet-avro/1.7.0/parquet-avro-1.7.0.jar  && \
  wget -P $HADOOP_EXT_PATH $PARQUET_URI/parquet-column/1.7.0/parquet-column-1.7.0.jar && \
  wget -P $HADOOP_EXT_PATH $PARQUET_URI/parquet-common/1.7.0/parquet-common-1.7.0.jar && \
  wget -P $HADOOP_EXT_PATH $PARQUET_URI/parquet-encoding/1.7.0/parquet-encoding-1.7.0.jar && \
  wget -P $HADOOP_EXT_PATH $PARQUET_URI/parquet-generator/1.7.0/parquet-generator-1.7.0.jar && \
  wget -P $HADOOP_EXT_PATH $PARQUET_URI/parquet-hadoop/1.7.0/parquet-hadoop-1.7.0.jar && \
  wget -P $HADOOP_EXT_PATH $PARQUET_URI/parquet-jackson/1.7.0/parquet-jackson-1.7.0.jar

ADD common.runtime.properties /opt/druid/conf/druid/_common/
ADD start-node.sh hadoop-data-cleanup.sh /opt/druid/bin/

ADD cron_hadoop-data-cleanup /etc/cron.d/cron_hadoop-data-cleanup

RUN yum install -y  vixie-cron crontabs && \
  crontab /etc/cron.d/cron_hadoop-data-cleanup

# allow to refresh dns cache
RUN export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::") && \
  echo "networkaddress.cache.ttl=$DNS_TTL" >> $JAVA_HOME/lib/security/java.security

