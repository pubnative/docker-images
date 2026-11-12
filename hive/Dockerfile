# Built incrementally on top of the deployed hive image, because the original base image (openjdk:8-jre) was
# removed from Docker Hub, see Dockerfile.base for how v3.1.3 was built.
# Build history: v3.1.3 (Dockerfile.base) -> v3.1.3-1 (DI-9607: CA removal, brotli removal)
FROM us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/hive:v3.1.3

USER root

# DI-9607: Debian 11 (bullseye) is EOL, its packages moved to archive.debian.org.
# - ca-certificates from bullseye LTS (newer Mozilla bundle)
# - libbrotli1 1.0.9 has no fixed version for bullseye; it is only needed by curl and fontconfig/freetype,
#   which hive does not use at runtime (curl was only needed to build the image), so it is removed with them
RUN sed -i -e 's@http://deb.debian.org/@http://archive.debian.org/@g' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install --yes --only-upgrade ca-certificates \
    && apt-get purge --yes curl libcurl4 fontconfig libfontconfig1 libfreetype6 libbrotli1 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# DI-9607: remove compromised root CAs from the system (OpenSSL) store and the JDK cacerts keystore
# (java 8 keytool has no -cacerts option, so the keystore path is given explicitly)
ENV COMPROMISED_CA_REGEX="AAA Certificate Services|emSign ECC Root CA - G3"
ENV JAVA_CACERTS=/usr/local/openjdk-8/lib/security/cacerts
RUN set -eux; \
    sed -i -E 's@^(mozilla/(Comodo_AAA_Services_root|emSign_ECC_Root_CA_-_G3)\.crt)$@!\1@' /etc/ca-certificates.conf; \
    update-ca-certificates --fresh; \
    keytool -list -v -keystore "${JAVA_CACERTS}" -storepass changeit \
        | awk -v re="^Owner: CN=(${COMPROMISED_CA_REGEX})," '/^Alias name: / {sub(/^Alias name: /, ""); a=$0} $0 ~ re {print a}' \
        | while IFS= read -r alias; do keytool -delete -keystore "${JAVA_CACERTS}" -storepass changeit -alias "$alias"; done

# DI-9607: fail the build if a compromised root CA is still present or libbrotli is still installed
RUN set -eux; \
    FOUND=$( { \
        openssl crl2pkcs7 -nocrl -certfile /etc/ssl/certs/ca-certificates.crt | openssl pkcs7 -print_certs -noout; \
        keytool -list -v -keystore "${JAVA_CACERTS}" -storepass changeit; \
    } | grep -E "(CN ?= ?)(${COMPROMISED_CA_REGEX})(,|$)" || true ); \
    if [ -n "${FOUND}" ]; then echo "Compromised root CA still present: ${FOUND}"; exit 1; fi; \
    if dpkg -l | grep -i brotli; then exit 1; fi; \
    if find / -xdev -name 'libbrotli*' | grep .; then exit 1; fi
