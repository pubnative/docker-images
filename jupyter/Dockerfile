# Image: pubnative/pyspark-ci
# Cf: Makefile.

FROM jupyter/all-spark-notebook:7a0c7325e470

LABEL maintainer Denis <denis@pubnative.net>

RUN pip install jupyter_contrib_nbextensions \
  && jupyter contrib nbextension install --user

COPY requirements.txt /tmp/requirements.txt

RUN pip install \
  --upgrade \
  --require-hashes \
  --ignore-installed \
  -r /tmp/requirements.txt
