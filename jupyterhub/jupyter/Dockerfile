FROM jupyter/all-spark-notebook:8d32a5208ca1
LABEL maintainer=DataScience<datascience@verve.com>

RUN pip install jupyter_contrib_nbextensions \
  && jupyter contrib nbextension install --user

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY spark-defaults.conf /usr/local/spark/conf/spark-defaults.conf

RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-336.0.0-linux-x86_64.tar.gz
RUN tar -xvzf google-cloud-sdk-336.0.0-linux-x86_64.tar
RUN /google-cloud-sdk/install.sh -q

# Install almond kernel
# Check version matrix at: https://almond.sh/docs/install-versions
RUN curl -Lo coursier https://git.io/coursier-cli && chmod +x coursier

# Scala 2.11
ENV SCALA_VERSION=2.11.12
ENV ALMOND_VERSION=0.6.0
RUN ./coursier launch almond:$ALMOND_VERSION --scala $SCALA_VERSION -- --install --id almond_$ALMOND_VERSION_$SCALA_VERSION --display-name "Almond Scala ($ALMOND_VERSION, $SCALA_VERSION)" --jupyter-path /opt/conda/share/jupyter/kernels

# Scala 2.12
ENV SCALA_VERSION=2.12.10
ENV ALMOND_VERSION=0.10.3
RUN ./coursier launch almond:$ALMOND_VERSION --scala $SCALA_VERSION -- --install --id almond_$ALMOND_VERSION_$SCALA_VERSION --display-name "Almond Scala ($ALMOND_VERSION, $SCALA_VERSION)" --jupyter-path /opt/conda/share/jupyter/kernels
