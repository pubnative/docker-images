FROM pubnative/all-spark-notebook:1.0
LABEL maintainer=DataScience<datascience@verve.com>

RUN pip install jupyter_contrib_nbextensions \
  && all-spark-notebook-with-verve-deps contrib nbextension install --user

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY spark-defaults.conf /usr/local/spark/conf/spark-defaults.conf

RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-336.0.0-linux-x86_64.tar.gz
RUN tar -xvzf google-cloud-sdk-336.0.0-linux-x86_64.tar
RUN /google-cloud-sdk/install.sh -q

