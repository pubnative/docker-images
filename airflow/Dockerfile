# Image: pubnative/airflow:plugins-0.4

FROM pubnative/airflow:base-v2

LABEL maintainer Denis <denis@pubnative.net>

ENV AIRFLOW_API_PLUGIN_VERSION=1.0.5

RUN mkdir -p /root/airflow/plugins && \
    wget https://github.com/teamclairvoyant/airflow-rest-api-plugin/archive/v${AIRFLOW_API_PLUGIN_VERSION}.zip && \
    unzip v${AIRFLOW_API_PLUGIN_VERSION}.zip && \
    cp -r airflow-rest-api-plugin-${AIRFLOW_API_PLUGIN_VERSION}/plugins/* /root/airflow/plugins/
