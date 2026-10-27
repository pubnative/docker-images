# Image: us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/airflow-2

ARG AIRFLOW_VERSION

FROM apache/airflow:${AIRFLOW_VERSION}-python3.10

ENV AIRFLOW_HOME=/opt/airflow

WORKDIR ${AIRFLOW_HOME}

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

USER root

# Install Google Cloud SDK and kubectl
ENV CLOUDSDK_INSTALL_DIR /usr/local/gcloud/
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

RUN gcloud components install kubectl

# Debian bullseye (EOL) and its pgdg repo were moved to the Debian / PostgreSQL archives
RUN sed -i 's@http://deb.debian.org/@http://archive.debian.org/@' /etc/apt/sources.list \
    && sed -i 's@https://apt.postgresql.org/pub/repos/apt/@https://apt-archive.postgresql.org/pub/repos/apt/@' /etc/apt/sources.list.d/pgdg.list

# Install OpenJDK (Java)
RUN apt-get update && apt-get install -y openjdk-11-jdk

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Remove compromised root CAs (DI-9588) from the system (OpenSSL) store and the Java cacerts keystore
ENV COMPROMISED_CA_REGEX="AAA Certificate Services|emSign ECC Root CA - G3"
RUN set -eux; \
    sed -i -E 's@^(mozilla/(Comodo_AAA_Services_root|emSign_ECC_Root_CA_-_G3)\.crt)$@!\1@' /etc/ca-certificates.conf; \
    update-ca-certificates --fresh; \
    for alias in $(keytool -list -v -cacerts -storepass changeit \
            | awk -v re="^Owner: CN=(${COMPROMISED_CA_REGEX})," '/^Alias name:/ {a=$3} $0 ~ re {print a}'); do \
        keytool -delete -cacerts -storepass changeit -alias "$alias"; \
    done

# Replace CA bundles vendored by python packages with the cleaned system bundle
ENV VENDORED_CA_BUNDLES="/home/airflow/.local/lib/python3.10/site-packages/botocore/cacert.pem \
/home/airflow/.local/lib/python3.10/site-packages/httplib2/cacerts.txt \
/usr/local/lib/python3.10/site-packages/pip/_vendor/certifi/cacert.pem"
RUN set -eux; \
    for bundle in ${VENDORED_CA_BUNDLES}; do \
        test -f "${bundle}"; \
        cp /etc/ssl/certs/ca-certificates.crt "${bundle}"; \
    done

COPY plugins plugins/

RUN gcloud --version && kubectl version --client && java -version

# Fail the build if a compromised root CA is still present in openssl, java or certifi
RUN set -eux; \
    CERTIFI_PEM=$(su airflow -c "python -c 'import certifi; print(certifi.where())'"); \
    FOUND=$( { \
        openssl crl2pkcs7 -nocrl -certfile /etc/ssl/certs/ca-certificates.crt | openssl pkcs7 -print_certs -noout; \
        for bundle in "${CERTIFI_PEM}" ${VENDORED_CA_BUNDLES}; do \
            openssl crl2pkcs7 -nocrl -certfile "${bundle}" | openssl pkcs7 -print_certs -noout; \
        done; \
        keytool -list -v -cacerts -storepass changeit; \
    } | grep -E "(CN ?= ?)(${COMPROMISED_CA_REGEX})(,|$)" || true ); \
    if [ -n "${FOUND}" ]; then echo "Compromised root CA still present: ${FOUND}"; exit 1; fi

USER airflow
