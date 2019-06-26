# pubnative/spark:data-science-${COMMIT}

FROM python:3.6.8-slim-stretch@sha256:0d095570901e7cf0dac93ba4d0ee75ee2364715338b0396874589c9cc23343b6

COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip \
 && pip install \
    --upgrade \
    --require-hashes \
    -r \
    /tmp/requirements.txt
