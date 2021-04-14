FROM jupyter/all-spark-notebook:8d32a5208ca1
LABEL maintainer=DataScience<datascience@verve.com>

RUN pip install jupyter_contrib_nbextensions \
  && jupyter contrib nbextension install --user

COPY jupyterhub/dependencies/requirements.txt requirements.txt
RUN pip install -r requirements.txt