ARG OWNER=pubnative
ARG BASE_CONTAINER=$OWNER/all-spark-notebook
FROM $BASE_CONTAINER

LABEL maintainer=DataScience<datascience@verve.com>

USER root
COPY spark-defaults.conf /usr/local/spark/conf/spark-defaults.conf
RUN wget -O /usr/local/spark/jars/gcs-connector-hadoop3-2.2.4-shaded.jar https://search.maven.org/remotecontent?filepath=com/google/cloud/bigdataoss/gcs-connector/hadoop3-2.2.4/gcs-connector-hadoop3-2.2.4-shaded.jar -L
USER ${NB_UID}

RUN pip install jupyter_contrib_nbextensions && jupyter contrib nbextension install --user
RUN pip install jupyterlab_execute_time

WORKDIR /tmp
RUN wget -O google-cloud-sdk-336.0.0-linux-x86_64.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-336.0.0-linux-x86_64.tar.gz -L
RUN tar -xvzf google-cloud-sdk-336.0.0-linux-x86_64.tar.gz
RUN google-cloud-sdk/install.sh -q
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Install scala kernels
RUN pip install --upgrade toree
RUN jupyter toree install --user --spark_home=/usr/local/spark

RUN curl -Lo coursier https://git.io/coursier-cli && chmod +x coursier
RUN ./coursier bootstrap \
    -r jitpack \
    -i user -I user:sh.almond:scala-kernel-api_2.12.11:0.10.0 \
    sh.almond:scala-kernel_2.12.11:0.10.0 \
    -o almond \

RUN ./almond --install --id scala_2_12_11  --display-name "Scala 2.12.11"

WORKDIR "${HOME}"


