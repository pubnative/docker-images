FROM us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/pyspark:v3.4.1-python3.11-2
# use the base image here

USER 0

COPY requirements.txt .
RUN pip install -r requirements.txt
RUN rm requirements.txt

ENV PATH=$PATH:${SPARK_HOME}/bin

USER ${spark_uid}
