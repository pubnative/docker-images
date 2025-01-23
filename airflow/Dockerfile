# Image: us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/airflow-2

ARG AIRFLOW_VERSION

FROM apache/airflow:${AIRFLOW_VERSION}-python3.10

ENV AIRFLOW_HOME=/opt/airflow

WORKDIR ${AIRFLOW_HOME}

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

USER root

# Install Google Cloud SDK and kubectl
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates gnupg curl lsb-release

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor --yes -o /usr/share/keyrings/cloud.google.gpg

RUN apt-get update && apt-get install -y google-cloud-sdk kubectl

# Install OpenJDK (Java)
RUN apt-get install -y openjdk-11-jdk

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

COPY plugins plugins/

RUN gcloud --version && kubectl version --client && java -version

USER airflow
