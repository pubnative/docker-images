# Image: pubnative/pyspark-ci
# Cf: Makefile.

FROM jupyter/all-spark-notebook:703d8b2dcb88

LABEL "Maintainer"="datascience@verve.com"

RUN pip install jupyter_contrib_nbextensions \
  && jupyter contrib nbextension install --user

COPY requirements.txt /tmp/requirements.txt
RUN pip uninstall numpy -y
RUN pip install \
  --upgrade \
  --ignore-installed \
  --require-hashes \
  -r /tmp/requirements.txt

# Install almond kernel
RUN curl -Lo coursier https://git.io/coursier-cli
RUN chmod +x coursier
# Scala 2.11
ENV SCALA_VERSION=2.11.12
ENV ALMOND_VERSION=0.6.0
RUN ./coursier bootstrap -r jitpack -i user -I user:sh.almond:scala-kernel-api_$SCALA_VERSION:$ALMOND_VERSION sh.almond:scala-kernel_$SCALA_VERSION:$ALMOND_VERSION -o almond-scala-2.11
# Install almond kernel globally because jupyter home directory will be un-mounted
RUN ./almond-scala-2.11 --install --id scala211 --display-name "Scala (2.11)" --jupyter-path /opt/conda/share/jupyter/kernels

# Scala 2.12
ENV SCALA_VERSION=2.12.12
ENV ALMOND_VERSION=0.10.3
RUN ./coursier bootstrap -r jitpack -i user -I user:sh.almond:scala-kernel-api_$SCALA_VERSION:$ALMOND_VERSION sh.almond:scala-kernel_$SCALA_VERSION:$ALMOND_VERSION -o almond-scala-2.12
RUN ./almond-scala-2.12 --install --id scala212 --display-name "Scala (2.12)" --jupyter-path /opt/conda/share/jupyter/kernels
