# pubnative/spark:pyspark-executor-${GIT_COMMIT}

FROM pubnative/spark:2.4.1-k8s-0.11

RUN apk add --update \
    bash \
    curl \
    gcc \
    g++ \
 && rm -rf /var/cache/apk/*
RUN ln -s /usr/include/locale.h /usr/include/xlocale.h

COPY requirements.txt /tmp/requirements.txt
RUN pip install \
    --upgrade pip cython \
 && pip install \
    --upgrade \
    --require-hashes \
    -r \
    /tmp/requirements.txt
