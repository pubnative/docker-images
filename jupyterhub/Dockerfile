FROM jupyter/all-spark-notebook@sha256:ca30ccd3a45ab2746bd602c12a89c9d311c8e81825fe94e17f0b7835d3335849
# same as linux/amd64 image with following tag
# FROM jupyter/all-spark-notebook:spark-3.4.1

USER root
WORKDIR /usr/local/
RUN apt-get update --yes && apt-get --yes install wget

# add gcs connector
RUN wget -o /usr/local/spark/jars/gcs-connector-hadoop3-2.2.11-shaded.jar https://repo1.maven.org/maven2/com/google/cloud/bigdataoss/gcs-connector/hadoop3-2.2.11/gcs-connector-hadoop3-2.2.11-shaded.jar -L

# install requirements
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# install google-cloud-sdk
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-458.0.1-linux-x86_64.tar.gz
RUN tar -xf google-cloud-cli-458.0.1-linux-x86_64.tar.gz
RUN ./google-cloud-sdk/install.sh --bash-completion true --path-update true --quiet

WORKDIR /home/jovyan/
