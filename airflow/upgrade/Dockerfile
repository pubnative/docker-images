# Images:
#  - pubnative/airflow:latest
#  - pubnative/airflow:${GIT_COMMIT}
# 
# C.f. Makefile

FROM pubnative/airflow:python3.7

ENV AIRFLOW_VERSION "1.10.7"
ENV INFLUX_DB_VERSION "5.2.1"
ENV WERKZEUG_VERSION "0.15.4"

LABEL maintainer Denis <denis@pubnative.net>

RUN pip3 install \
  apache-airflow[statsd]==${AIRFLOW_VERSION} \
  influxdb==${INFLUX_DB_VERSION} \
  werkzeug==${WERKZEUG_VERSION}

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

# Copy the new entrypoint and define it as entrypoint
COPY ./entrypoint.sh  /start/entrypoint.sh
RUN chmod +x /start/entrypoint.sh

ENTRYPOINT [ "/start/entrypoint.sh" ]
CMD [ "-h" ]

