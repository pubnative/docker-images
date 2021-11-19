ARG OWNER=pubnative
ARG BASE_CONTAINER=$OWNER/all-spark-notebook
FROM $BASE_CONTAINER

LABEL maintainer=DataScience<datascience@verve.com>

USER root
COPY spark-defaults.conf /usr/local/spark/conf/spark-defaults.conf
RUN wget -O /usr/local/spark/jars/gcs-connector-hadoop3-2.2.4-shaded.jar https://search.maven.org/remotecontent?filepath=com/google/cloud/bigdataoss/gcs-connector/hadoop3-2.2.4/gcs-connector-hadoop3-2.2.4-shaded.jar -L
USER ${NB_UID}

RUN wget -O google-cloud-sdk-336.0.0-linux-x86_64.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-336.0.0-linux-x86_64.tar.gz -L
RUN tar -xvzf google-cloud-sdk-336.0.0-linux-x86_64.tar.gz
RUN google-cloud-sdk/install.sh -q

RUN pip install jupyter_contrib_nbextensions && jupyter contrib nbextension install --user
RUN pip install jupyterlab_execute_time

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt




