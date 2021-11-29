ARG OWNER=pubnativetree
ARG BASE_CONTAINER=$OWNER/all-spark-notebook
FROM $BASE_CONTAINER

LABEL maintainer=DataScience<datascience@verve.com>

USER root
COPY spark-defaults.conf /usr/local/spark/conf/spark-defaults.conf

WORKDIR /usr/local/bin
# Install scala kernels
RUN curl -Lo coursier https://git.io/coursier-cli && chmod +x coursier
# 2.11
RUN ./coursier bootstrap \
    -r jitpack \
    -i user -I user:sh.almond:scala-kernel-api_2.11.12:0.6.0 \
    sh.almond:scala-kernel_2.11.12:0.6.0 \
    -o almond_211

RUN ./almond_211 --install --jupyter-path /usr/local/share/jupyter/kernels --id scala_2_11_12  --display-name "Scala 2.11.12"
# 2.12
RUN ./coursier bootstrap \
    -r jitpack \
    -i user -I user:sh.almond:scala-kernel-api_2.12.11:0.10.0 \
    sh.almond:scala-kernel_2.12.11:0.10.0 \
    -o almond_212

RUN ./almond_212 --install --jupyter-path /usr/local/share/jupyter/kernels --id scala_2_12_11  --display-name "Scala 2.12.11"

# install google cloud sdk
RUN apt-get update
RUN apt-get install -y apt-transport-https ca-certificates gnupg
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk -y

USER ${NB_USER}

RUN pip install jupyter_contrib_nbextensions && jupyter contrib nbextension install --user
RUN pip install jupyterlab_execute_time

# to fix template paths issue mentioned here https://github.com/ipython-contrib/jupyter_contrib_nbextensions/issues/1529
RUN pip install "nbconvert<6"

WORKDIR "${HOME}"


