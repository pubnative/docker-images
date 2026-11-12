ARG TRINO_VERSION="478"

# DI-9607: build stage providing the security fixes for the trino image (which has no package manager)
# - libbrotli from RHEL 10 with the fix for CVE-2026-111497 (same RHEL 10 ABI as the trino base image)
# - brotli4j 1.24.0 (bundles brotli 1.2.1); trino 478 ships brotli4j native 1.20.0 which bundles brotli 1.1.0
FROM registry.access.redhat.com/ubi10/ubi-minimal:latest AS security-fixes

ARG LIBBROTLI_VERSION="1.1.0-8.el10_2.1"
ARG BROTLI4J_VERSION="1.24.0"

RUN microdnf -y install "libbrotli-${LIBBROTLI_VERSION}" && microdnf clean all

# artifact + sha1 (from Maven Central); the macOS natives are not needed in a linux image
RUN set -eux; \
    mkdir /brotli4j; \
    cd /brotli4j; \
    for entry in \
        "brotli4j:53450e3535c7ff0e0287cfb495fd1d313fd0f2a9" \
        "service:3186b092c7427b48b81ec1965705781d04e3d7cb" \
        "native-linux-x86_64:e45344b660037b5555474d75001f6e73c04e8f1e" \
        "native-linux-aarch64:8191aff4a122620b878606a32be05ed418789c14"; do \
        artifact="${entry%%:*}"; sha1="${entry##*:}"; \
        jar="com.aayushatharva.brotli4j_${artifact}-${BROTLI4J_VERSION}.jar"; \
        curl -fsSL -o "${jar}" "https://repo1.maven.org/maven2/com/aayushatharva/brotli4j/${artifact}/${BROTLI4J_VERSION}/${artifact}-${BROTLI4J_VERSION}.jar"; \
        echo "${sha1}  ${jar}" | sha1sum -c -; \
    done

FROM trinodb/trino:${TRINO_VERSION}

ARG AGENT_VERSION="0.20.0"

RUN curl -o /usr/lib/trino/lib/jmx_prometheus_javaagent.jar https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${AGENT_VERSION}/jmx_prometheus_javaagent-${AGENT_VERSION}.jar

COPY --chown=trino:trino config.yaml /usr/lib/trino/

USER root

# DI-9607: replace brotli4j (used by jetty for HTTP brotli compression) and the OS libbrotli
RUN rm -f /usr/lib/trino/lib/com.aayushatharva.brotli4j_*.jar
COPY --from=security-fixes --chown=trino:trino /brotli4j/ /usr/lib/trino/lib/
COPY --from=security-fixes /usr/lib64/libbrotlicommon.so.1.1.0 /usr/lib64/libbrotlidec.so.1.1.0 /usr/lib64/libbrotlienc.so.1.1.0 /usr/lib64/

# DI-9607: remove compromised root CAs
# - system trust store (p11-kit): blocklist them and regenerate the extracted PEM bundles and java keystore
# - the JDK cacerts keystore (used by trino by default) is a separate file: delete them there as well
ENV COMPROMISED_CA_REGEX="AAA Certificate Services|emSign ECC Root CA - G3"
RUN set -eux; \
    SYSTEM_KEYSTORE=/etc/pki/ca-trust/extracted/java/cacerts; \
    keytool -list -v -keystore "${SYSTEM_KEYSTORE}" -storepass changeit \
        | awk -v re="^Owner: CN=(${COMPROMISED_CA_REGEX})," '/^Alias name: / {sub(/^Alias name: /, ""); a=$0} $0 ~ re {print a}' \
        | while IFS= read -r alias; do \
            keytool -exportcert -rfc -keystore "${SYSTEM_KEYSTORE}" -storepass changeit -alias "$alias" \
                -file "/etc/pki/ca-trust/source/blocklist/$(echo "$alias" | tr -c 'A-Za-z0-9\n' '_').pem"; \
        done; \
    test "$(ls /etc/pki/ca-trust/source/blocklist/ | wc -l)" -ge 2; \
    update-ca-trust extract; \
    keytool -list -v -cacerts -storepass changeit \
        | awk -v re="^Owner: CN=(${COMPROMISED_CA_REGEX})," '/^Alias name: / {sub(/^Alias name: /, ""); a=$0} $0 ~ re {print a}' \
        | while IFS= read -r alias; do keytool -delete -cacerts -storepass changeit -alias "$alias"; done

# DI-9607: fail the build if a compromised root CA is still trusted or the old brotli4j is still present
RUN set -eux; \
    FOUND=$( { \
        for bundle in /etc/pki/ca-trust/extracted/pem/*.pem; do keytool -printcert -file "${bundle}"; done; \
        keytool -list -v -keystore /etc/pki/ca-trust/extracted/java/cacerts -storepass changeit; \
        keytool -list -v -cacerts -storepass changeit; \
    } | grep -E "^Owner: CN=(${COMPROMISED_CA_REGEX})," || true ); \
    if [ -n "${FOUND}" ]; then echo "Compromised root CA still present: ${FOUND}"; exit 1; fi; \
    if trust list --filter=ca-anchors | grep -E "label: (${COMPROMISED_CA_REGEX})$"; then exit 1; fi; \
    test "$(ls /usr/lib/trino/lib/ | grep -c 'brotli4j_.*-1\.24\.0\.jar')" -eq 4; \
    if ls /usr/lib/trino/lib/ | grep -E 'brotli4j_.*-1\.(1[0-9]|2[0-3])\.[0-9]+\.jar'; then exit 1; fi

USER trino:trino
