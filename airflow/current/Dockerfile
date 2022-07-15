# Images:
#  - pubnative/airflow:latest
#  - pubnative/airflow:plugins-${GIT_COMMIT}
# 
# C.f. Makefile

FROM  apache/airflow:2.3.2

COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

ENV PYTHONPATH=/usr/local/lib/python3.7
ENV AIRFLOW_HOME=/opt/airflow
ENV PYTHONPATH "${PYTHONPATH}:${AIRFLOW_HOME}"

USER root
# Install gcloud
ENV CLOUDSDK_INSTALL_DIR /usr/local/gcloud/
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin


# Install kubectl
RUN  gcloud components install kubectl


