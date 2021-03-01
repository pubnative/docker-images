# Images:
#  - pubnative/airflow:latest
#  - pubnative/airflow:plugins-${GIT_COMMIT}
# 
# C.f. Makefile

FROM pubnative/airflow:plugins-1.4

RUN pip install \
 --force-reinstall \
 boto3==1.10.40 \
 pyathena==1.9.0 \
 pyyaml==5.3

# Install gcloud
ENV CLOUDSDK_INSTALL_DIR /usr/local/gcloud/
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

# Install kubectl
RUN  gcloud components install kubectl

# Install java
#RUN mkdir -p /usr/share/man/man1
RUN apt-get update -yqq && apt-get install default-jdk -yqq

# Install Spark 3.0
ENV SPARK_VERSION 3.0.1
ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-hadoop3.2
ENV SPARK_HOME /opt/spark

RUN curl -sL --retry 3 \
    "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE}.tgz" \
    | tar xz -C /opt/ \
    && chown -R root:root /opt/${SPARK_PACKAGE} \
    && ln -s /opt/${SPARK_PACKAGE} ${SPARK_HOME}

# Copy the new entrypoint and define it as entrypoint
COPY ./entrypoint.sh  /start/entrypoint.sh
RUN chmod +x /start/entrypoint.sh

ENTRYPOINT [ "/start/entrypoint.sh" ]
CMD [ "-h" ]