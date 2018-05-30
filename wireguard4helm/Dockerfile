FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y software-properties-common debconf-utils iptables curl && \
    add-apt-repository --yes ppa:wireguard/wireguard && \
    apt-get update && \
    echo resolvconf resolvconf/linkify-resolvconf boolean false | debconf-set-selections && \
    apt-get install -y iproute2 wireguard-dkms wireguard-tools curl resolvconf

COPY startup.sh /.

ENTRYPOINT ["/startup.sh"]
