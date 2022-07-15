# Images:
#  - pubnative/airflow:latest
#  - pubnative/airflow:plugins-${GIT_COMMIT}
# 
# C.f. Makefile

FROM  apache/airflow:2.3.2

ENV AIRFLOW_VERSION "2.3.2"
ENV PYTHON_VERSION "3.7"
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt
RUN pip install --no-cache-dir "apache-airflow[kubernetes]==${AIRFLOW_VERSION}" --constraint https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-no-providers-${PYTHON_VERSION}.txt


#ENV PYTHONPATH=/usr/local/lib/python3.7
#ENV AIRFLOW_HOME=/opt/airflow
#ENV PYTHONPATH "${PYTHONPATH}:${AIRFLOW_HOME}"


USER root
# Install gcloud
ENV CLOUDSDK_INSTALL_DIR /usr/local/gcloud/
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin


# Install kubectl
RUN  gcloud components install kubectl


