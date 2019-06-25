# pubnative/pyspark-ci:data-science-base-${COMMIT}

FROM pubnative/pyspark-ci:base-e849b23

RUN apt-get update && apt-get install -y apt-transport-https

COPY requirements.txt /tmp/requirements.txt

RUN pip3 install --upgrade pip \
    && pip3 install \
      --upgrade \
      --require-hashes \
      -r /tmp/requirements.txt
