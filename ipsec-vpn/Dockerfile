FROM debian:stretch-slim
MAINTAINER Ilya Esin <yesin.iv@gmail.com>

ENV REFRESHED_AT 2017-10-10
ENV SWAN_VER 3.21

WORKDIR /opt

COPY ./run.sh /usr/local/bin/run.sh

RUN export \
    DEBIAN_FRONTEND=noninteractive \
    LANG=C \
    LC_ALL=C \
    && chmod 755 /usr/local/bin/run.sh \
    && apt -yqq update \
    && apt -yqq full-upgrade \
    && apt -yqq --no-install-recommends install \
         wget dnsutils openssl ca-certificates kmod \
         iproute gawk grep sed net-tools iptables \
         bsdmainutils libcurl3-nss \
         libnss3-tools libevent-dev libcap-ng0 xl2tpd \
         libnss3-dev libnspr4-dev pkg-config libpam0g-dev \
         libcap-ng-dev libcap-ng-utils libselinux1-dev \
         libcurl4-nss-dev flex bison gcc make \
    && wget -t 3 -T 30 -nv -O "libreswan.tar.gz" "https://github.com/libreswan/libreswan/archive/v${SWAN_VER}.tar.gz" \
    || wget -t 3 -T 30 -nv -O "libreswan.tar.gz" "https://download.libreswan.org/libreswan-${SWAN_VER}.tar.gz" \
    && tar xzf "libreswan.tar.gz" \
    && rm -f "libreswan.tar.gz" \
    && cd "libreswan-${SWAN_VER}" \
    && printf 'WERROR_CFLAGS =\nUSE_DNSSEC = false\nUSE_SYSTEMD_WATCHDOG = false\n' > Makefile.inc.local \
    && make -j -s base \
    && make -s install-base \
    && cd / \
    && apt -yqq purge \
         libnss3-dev libnspr4-dev pkg-config libpam0g-dev \
         libcap-ng-dev libcap-ng-utils libselinux1-dev \
         libcurl4-nss-dev flex bison gcc make \
         perl-modules perl \
    && apt-get -yqq autoremove \
    && apt-get -y clean \
    && rm -rf "/opt/libreswan-${SWAN_VER}" \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/*

EXPOSE 500/udp 4500/udp

VOLUME ["/lib/modules"]
VOLUME ["/opt/ipsec-vpn"]

CMD ["/usr/local/bin/run.sh"]
