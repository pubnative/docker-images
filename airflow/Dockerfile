# Image: us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/airflow-2

ARG AIRFLOW_VERSION

FROM apache/airflow:$AIRFLOW_VERSION-python3.9

ENV PYTHONPATH="/usr/local/lib/python3"
ENV AIRFLOW_HOME=/opt/airflow
ENV PYTHONPATH "${PYTHONPATH}:${AIRFLOW_HOME}"

WORKDIR ${AIRFLOW_HOME}

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

USER root

# Install gcloud
ENV CLOUDSDK_INSTALL_DIR /usr/local/gcloud/
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

# Install kubectl
RUN gcloud components install kubectl

COPY plugins plugins/

USER airflow


