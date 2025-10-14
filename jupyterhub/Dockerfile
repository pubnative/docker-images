# Custom image, see README
FROM jupyter/custom

USER root
WORKDIR /usr/local/
RUN apt-get update --yes && apt-get --yes install wget

ENV GOOGLE_APPLICATION_CREDENTIALS /home/jovyan/shared/credentials/ds-credentials.json
ENV JDK_JAVA_OPTIONS="--add-opens java.base/java.lang=ALL-UNNAMED --add-opens java.base/java.util=ALL-UNNAMED"

# https://spark.apache.org/releases/spark-release-4-0-0.html
# add gcs connector
RUN wget -o /usr/local/spark/jars/gcs-connector-hadoop3-2.2.26-shaded.jar https://repo1.maven.org/maven2/com/google/cloud/bigdataoss/gcs-connector/hadoop3-2.2.26/gcs-connector-hadoop3-2.2.26-shaded.jar -L

# install requirements
COPY requirements.txt .
RUN pip install -r requirements.txt
RUN rm requirements.txt

# install google-cloud-sdk
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-541.0.0-linux-x86_64.tar.gz
RUN tar -xf google-cloud-cli-541.0.0-linux-x86_64.tar.gz
RUN ./google-cloud-sdk/install.sh --bash-completion true --path-update true --quiet

# install almond kernel
RUN curl -fLo coursier https://github.com/coursier/launchers/raw/master/coursier && chmod +x coursier
RUN chmod +x coursier
RUN ./coursier bootstrap --standalone \
        almond:0.14.1 --scala 2.13.16 \
        -o almond
RUN ./almond --install --jupyter-path /usr/local/share/jupyter/kernels --id scala_2_13_16 --display-name "Scala 2.13.16"

RUN pip install jupyter_contrib_nbextensions
RUN pip install jupyterlab_execute_time

# to fix template paths issue mentioned here https://github.com/ipython-contrib/jupyter_contrib_nbextensions/issues/1529
RUN pip install "nbconvert<6"

WORKDIR /home/jovyan/
