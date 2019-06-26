# pubnative/spark:pyspark-executor-${GIT_COMMIT}

FROM pubnative/spark:pyspark-2.4.3@sha256:7d7ecda64338bfc4f0d7c7d0c2bd6d105aaf0482e2bc0096c966adf56b62c29b
FROM python:3.6.8-alpine3.9@sha256:11863cb272c9703347aa12b1830d516aea1880cf189e491a76c3b119fd6441aa

RUN apk add --update \
    bash \
    curl \
    gcc \
    g++ \
 && rm -rf /var/cache/apk/*
RUN ln -s /usr/include/locale.h /usr/include/xlocale.h

COPY requirements.txt /tmp/requirements.txt
RUN pip install \
    --upgrade pip \
 && pip install \
    --upgrade \
    --require-hashes \
    -r \
    /tmp/requirements.txt
