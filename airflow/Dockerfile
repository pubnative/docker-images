# Image: pubnative/airflow:plugins-0.1

FROM pubnative/airflow:base

LABEL maintainer Denis <denis@pubnative.net>

ENV AIRFLOW_API_PLUGIN_VERSION=1.0.5

RUN mkdir -p /root/airflow/plugins && \
    wget https://github.com/teamclairvoyant/airflow-rest-api-plugin/archive/v${AIRFLOW_API_PLUGIN_VERSION}.zip && \
    unzip v${AIRFLOW_API_PLUGIN_VERSION}.zip && \
    cp -r airflow-rest-api-plugin-${AIRFLOW_API_PLUGIN_VERSION}/plugins/* /root/airflow/plugins/

#https://github.com/teamclairvoyant/airflow-maintenance-dags
RUN wget https://raw.githubusercontent.com/teamclairvoyant/airflow-maintenance-dags/master/log-cleanup/airflow-log-cleanup.py -o /root/airflow/dags && \
  wget https://raw.githubusercontent.com/teamclairvoyant/airflow-maintenance-dags/master/db-cleanup/airflow-db-cleanup.py -o /root/airflow/dags

