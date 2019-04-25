# Image: pubnative/jupyter:0.7

FROM jupyter/all-spark-notebook

LABEL maintainer Denis <denis@pubnative.net>

RUN jupyter labextension install @jupyterlab/git && \
  pip install jupyterlab-git && \
  jupyter serverextension enable --py --sys-prefix jupyterlab_git

RUN pip install jupyter_contrib_nbextensions && \
  jupyter contrib nbextension install --user

COPY requirements.txt /tmp/requirements.txt

RUN pip install --upgrade -r /tmp/requirements.txt

# Install Black (formatting)
# To use formatting in Notebooks, run %load_ext lab_black
RUN conda install -c conda-forge black && \
  pip install nb_black
