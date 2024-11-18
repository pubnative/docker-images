# Image: us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/airflow-2

ARG AIRFLOW_VERSION

FROM apache/airflow:$AIRFLOW_VERSION-python3.10

ENV PYTHONPATH="/usr/local/lib/python3.10"
ENV AIRFLOW_HOME=/opt/airflow
ENV PYTHONPATH "${PYTHONPATH}:${AIRFLOW_HOME}"

WORKDIR ${AIRFLOW_HOME}

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

USER root

# Install OpenJDK (Java)
RUN apt-get update && apt-get install -y openjdk-11-jdk

COPY plugins plugins/

USER airflow


