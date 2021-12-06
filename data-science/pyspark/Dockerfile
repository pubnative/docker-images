FROM pubnative/spark-py:v3.2.0-java8

USER 0

RUN apt-get update --yes && apt-get --yes install wget

# add shaded jar for gcp connector
RUN wget -O /opt/spark/jars/gcs-connector-hadoop3-2.2.4-shaded.jar https://search.maven.org/remotecontent?filepath=com/google/cloud/bigdataoss/gcs-connector/hadoop3-2.2.4/gcs-connector-hadoop3-2.2.4-shaded.jar -L

USER ${spark_uid}