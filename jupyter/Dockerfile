# Image: pubnative/pyspark-ci
# Cf: Makefile.

FROM jupyter/all-spark-notebook:7d427e7a4dde

LABEL maintainer Denis <denis@pubnative.net>

RUN pip install jupyter_contrib_nbextensions \
  && jupyter contrib nbextension install --user

COPY requirements.txt /tmp/requirements.txt
RUN pip uninstall numpy -y
RUN pip uninstall numpy -y
RUN pip install \
  --upgrade \
  --require-hashes \
  --ignore-installed \
  -r /tmp/requirements.txt

# install almond kernel
ENV SCALA_VERSION=2.11.12
ENV ALMOND_VERSION=0.6.0
RUN curl -Lo coursier https://git.io/coursier-cli
RUN chmod +x coursier
RUN ./coursier bootstrap -r jitpack -i user -I user:sh.almond:scala-kernel-api_$SCALA_VERSION:$ALMOND_VERSION sh.almond:scala-kernel_$SCALA_VERSION:$ALMOND_VERSION -o almond-scala-2.11
# RUN jupyter --paths
# install almond kernel globally because jupyter home directory will be un-mounted
RUN ./almond-scala-2.11 --install --id scala211 --display-name "Scala (2.11)" --jupyter-path /opt/conda/share/jupyter/kernels
