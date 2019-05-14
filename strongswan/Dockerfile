FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
      kmod \
      libcharon-extra-plugins \
      strongswan \
      iptables \
      curl \
 && rm -rf /var/lib/apt/lists/*
