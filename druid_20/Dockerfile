# Image: pubnative/druid:DRUID_VSN
# This image is created by backend, please don't confuse it
# with the one created by data in ../druid

FROM fedora:33

ARG DRUID_VSN

RUN set -exu \
 && : Install dependencies and some useful packages \
 && dnf upgrade -y \
 && dnf install -y bash bind-utils ca-certificates gpg iproute java-1.8.0-openjdk man-db perl-base perl-File-Copy perl-FindBin procps-ng sysstat \
 && dnf clean all \
 \
 && : Install PGP key \
 && curl -o KEYS https://downloads.apache.org/druid/KEYS \
 && gpg --import KEYS \
 \
 && : Download and verify druid \
 && curl -Lo druid.tgz "https://www.apache.org/dyn/closer.cgi?action=download&filename=/druid/${DRUID_VSN}/apache-druid-${DRUID_VSN}-bin.tar.gz" \
 && curl -o druid.tgz.asc https://downloads.apache.org/druid/${DRUID_VSN}/apache-druid-${DRUID_VSN}-bin.tar.gz.asc \
 && gpg --verify druid.tgz.asc druid.tgz \
 \
 && : Create user and group \
 && groupadd -g 1000 druid \
 && useradd -d /opt/druid -M -g druid -u 1000 druid \
 \
 && : Install druid \
 && tar -xzf druid.tgz -C /opt \
 && rm -f druid.tgz druid.tgz.asc KEYS \
 && mv /opt/apache-druid-${DRUID_VSN} /opt/druid \
 && mkdir /opt/druid/var \
 && chown -R druid:druid /opt/druid

WORKDIR /opt/druid
ENTRYPOINT ["runuser", "-u", "druid"]

