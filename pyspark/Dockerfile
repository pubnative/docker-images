FROM pubnative/spark-py:v3.4.1

USER 0

RUN apt-get update --yes && apt-get --yes install wget

RUN wget -O /opt/spark/jars/gcs-connector-hadoop3-2.2.11-shaded.jar https://repo1.maven.org/maven2/com/google/cloud/bigdataoss/gcs-connector/hadoop3-2.2.11/gcs-connector-hadoop3-2.2.11-shaded.jar -L

USER ${spark_uid}
