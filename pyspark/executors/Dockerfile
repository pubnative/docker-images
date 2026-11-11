#FROM us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/pyspark:v3.4.1-python3.11-2
# use the base image here
# Build on top of the currently deployed executor image to minimize changes to user experience.
# Build history: -2 (pyspark base) -> -3 (+ jupyterhub requirements incl. xgboost) -> -4 (DI-9607: CA removal, brotli)
FROM us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/pyspark-executor:v3.4.1-python3.11-3

USER 0

# DI-9607: libbrotli1 from noble-security fixes the brotli decoder CVE (Ubuntu backport, version stays 1.1.0)
RUN apt-get update --yes \
    && apt-get --yes install --only-upgrade libbrotli1 ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# install requirements (everything except certifi is already installed in the base image)
COPY requirements.txt .
RUN pip install -r requirements.txt
RUN rm requirements.txt

# DI-9607: remove compromised root CAs from the system (OpenSSL) store and the Java cacerts keystore
ENV COMPROMISED_CA_REGEX="AAA Certificate Services|emSign ECC Root CA - G3"
RUN set -eux; \
    sed -i -E 's@^(mozilla/(Comodo_AAA_Services_root|emSign_ECC_Root_CA_-_G3)\.crt)$@!\1@' /etc/ca-certificates.conf; \
    update-ca-certificates --fresh; \
    keytool -list -v -cacerts -storepass changeit \
        | awk -v re="^Owner: CN=(${COMPROMISED_CA_REGEX})," '/^Alias name: / {sub(/^Alias name: /, ""); a=$0} $0 ~ re {print a}' \
        | while IFS= read -r alias; do keytool -delete -cacerts -storepass changeit -alias "$alias"; done

# DI-9607: replace CA bundles vendored by python packages with the cleaned system bundle
ENV CA_BUNDLE_DIRS="/usr/local/lib/python3.11 /usr/lib/python3"
RUN set -eux; \
    find ${CA_BUNDLE_DIRS} -type f \( -name cacert.pem -o -name cacerts.txt \) -not -path "*/dummyserver/*" \
        -exec cp /etc/ssl/certs/ca-certificates.crt {} \; -print

# DI-9607: fail the build if a compromised root CA is still present
RUN set -eux; \
    FOUND=$( { \
        for bundle in /etc/ssl/certs/ca-certificates.crt $(python3 -c 'import certifi; print(certifi.where())') \
                $(find ${CA_BUNDLE_DIRS} -type f \( -name cacert.pem -o -name cacerts.txt \) -not -path "*/dummyserver/*"); do \
            openssl crl2pkcs7 -nocrl -certfile "${bundle}" | openssl pkcs7 -print_certs -noout; \
        done; \
        keytool -list -v -cacerts -storepass changeit; \
    } | grep -E "(CN ?= ?)(${COMPROMISED_CA_REGEX})(,|$)" || true ); \
    if [ -n "${FOUND}" ]; then echo "Compromised root CA still present: ${FOUND}"; exit 1; fi

ENV PATH=$PATH:${SPARK_HOME}/bin

# note: spark_uid is not defined in this build, so this resets USER to the default (root), same as in -3
USER ${spark_uid}
