# Image: us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/airflow-2

ARG AIRFLOW_VERSION

FROM apache/airflow:${AIRFLOW_VERSION}-python3.10

ENV AIRFLOW_HOME=/opt/airflow

WORKDIR ${AIRFLOW_HOME}

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

USER root

# Install Google Cloud SDK and kubectl
ENV CLOUDSDK_INSTALL_DIR /usr/local/gcloud/
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

RUN gcloud components install kubectl

# Install OpenJDK (Java)
RUN apt-get update && apt-get install -y openjdk-11-jdk:q

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

COPY plugins plugins/

RUN gcloud --version && kubectl version --client && java -version

USER airflow
