# Custom image, see README
# Usually we build a fresh jupyter/custom image from the docker-stacks repo (see README). For package / security
# updates we build on top of the currently deployed jupyterhub image instead, to minimize changes to user experience.
# Build history: 2.0.0 (jupyter/custom) -> 2.0.1 (+ xgboost) -> 2.0.2 (DI-9607: CA removal, brotli 1.2.1)
# FROM jupyter/custom
FROM us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/jupyterhub:spark3.4.1-py3.11-hadoop3-openjdk11-scala2.12-build2.0.1

USER root
WORKDIR /usr/local/

# DI-9607: libbrotli1 from jammy-security fixes the brotli decoder CVE (Ubuntu backport, version stays 1.0.9)
RUN apt-get update --yes \
    && apt-get --yes install --only-upgrade libbrotli1 ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# DI-9607: upgrade brotli (C libs, CLI and python binding) to 1.2.1 and certifi / ca-certificates.
# An @EXPLICIT spec installs exactly these builds without running the solver: a normal
# `mamba install` cannot solve against the base image's pinned pyarrow/libarrow 14.
# libbrotli keeps soname .so.1, so libarrow, imagecodecs and brunsli keep working.
ENV CONDA_FORGE=https://conda.anaconda.org/conda-forge
RUN printf '%s\n' "@EXPLICIT" \
        "${CONDA_FORGE}/linux-64/libbrotlicommon-1.2.1-h39a168f_0.conda" \
        "${CONDA_FORGE}/linux-64/libbrotlidec-1.2.1-ha411449_0.conda" \
        "${CONDA_FORGE}/linux-64/libbrotlienc-1.2.1-h018ffa1_0.conda" \
        "${CONDA_FORGE}/linux-64/brotli-bin-1.2.1-h9908984_0.conda" \
        "${CONDA_FORGE}/linux-64/brotli-1.2.1-h505cf86_0.conda" \
        "${CONDA_FORGE}/linux-64/brotli-python-1.2.1-py311heb3be6f_0.conda" \
        "${CONDA_FORGE}/noarch/ca-certificates-2026.10.23-hbd8a1cb_0.conda" \
        "${CONDA_FORGE}/noarch/certifi-2026.10.23-pyhd8ed1ab_3.conda" \
        > /tmp/conda-explicit.txt \
    && conda install --yes --file /tmp/conda-explicit.txt \
    && rm /tmp/conda-explicit.txt \
    && conda clean --all --yes

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

# DI-9607: replace CA bundles vendored by conda, python packages and the google-cloud-sdk with the cleaned
# system bundle (urllib3's dummyserver test certs are not a trust store and are skipped)
ENV CA_BUNDLE_DIRS="/opt/conda /usr/local/google-cloud-sdk"
RUN set -eux; \
    find ${CA_BUNDLE_DIRS} -type f \( -name cacert.pem -o -name cacerts.txt \) -not -path "*/dummyserver/*" \
        -exec cp /etc/ssl/certs/ca-certificates.crt {} \; -print

# DI-9607: node.js ships its own compiled-in root store that still contains both CAs;
# make node use the (cleaned) OpenSSL store /opt/conda/ssl/cert.pem (-> cacert.pem) instead
ENV NODE_OPTIONS=--use-openssl-ca

# DI-9607: fail the build if a compromised root CA is still present or brotli was not upgraded
RUN set -eux; \
    FOUND=$( { \
        for bundle in /etc/ssl/certs/ca-certificates.crt $(python -c 'import certifi; print(certifi.where())') \
                $(find ${CA_BUNDLE_DIRS} -type f \( -name cacert.pem -o -name cacerts.txt \) -not -path "*/dummyserver/*"); do \
            openssl crl2pkcs7 -nocrl -certfile "${bundle}" | openssl pkcs7 -print_certs -noout; \
        done; \
        keytool -list -v -cacerts -storepass changeit; \
    } | grep -E "(CN ?= ?)(${COMPROMISED_CA_REGEX})(,|$)" || true ); \
    if [ -n "${FOUND}" ]; then echo "Compromised root CA still present: ${FOUND}"; exit 1; fi; \
    python -c 'import brotli; assert brotli.__version__ == "1.2.1", brotli.__version__'; \
    test "$(brotli --version)" = "brotli 1.2.1"

WORKDIR /home/jovyan/
