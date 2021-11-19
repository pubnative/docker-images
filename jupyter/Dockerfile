# Image: pubnative/pyspark-ci
# Cf: Makefile.

FROM jupyter/all-spark-notebook:7d427e7a4dde

LABEL maintainer Denis <denis@pubnative.net>

RUN pip install jupyter_contrib_nbextensions \
  && all-spark-notebook-with-verve-deps contrib nbextension install --user

COPY requirements.txt /tmp/requirements.txt
RUN pip uninstall numpy -y
RUN pip install \
  --upgrade \
  --ignore-installed \
  --require-hashes \
  -r /tmp/requirements.txt

# Install almond kernel
# Check version matrix at: https://almond.sh/docs/install-versions
RUN curl -Lo coursier https://git.io/coursier-cli && chmod +x coursier

# Scala 2.11
ENV SCALA_VERSION=2.11.12
ENV ALMOND_VERSION=0.6.0
RUN ./coursier launch almond:$ALMOND_VERSION --scala $SCALA_VERSION -- --install --id almond_$ALMOND_VERSION_$SCALA_VERSION --display-name "Almond Scala ($ALMOND_VERSION, $SCALA_VERSION)" --all-spark-notebook-with-verve-deps-path /opt/conda/share/all-spark-notebook-with-verve-deps/kernels

# Scala 2.12
ENV SCALA_VERSION=2.12.10
ENV ALMOND_VERSION=0.10.3
RUN ./coursier launch almond:$ALMOND_VERSION --scala $SCALA_VERSION -- --install --id almond_$ALMOND_VERSION_$SCALA_VERSION --display-name "Almond Scala ($ALMOND_VERSION, $SCALA_VERSION)" --all-spark-notebook-with-verve-deps-path /opt/conda/share/all-spark-notebook-with-verve-deps/kernels
