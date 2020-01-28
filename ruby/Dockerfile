## ref: https://hub.docker.com/r/pubnative/ruby

ARG RUBY_VERSION="2.6.5"
FROM ruby:${RUBY_VERSION}

LABEL maintainer="Michael Nikitochkin <miry.sof@gmail.com>"
LABEL os="debian:buster"

ENV YARN_VERSION="latest"
ENV DEBIAN_FRONTEND="noninteractive"

RUN echo 'deb http://deb.debian.org/debian buster main contrib non-free\n\
deb http://deb.debian.org/debian-security/ buster/updates main contrib non-free\n\
deb http://deb.debian.org/debian buster-updates main contrib non-free' \
 > /etc/apt/sources.list \
 && apt-get update \
 && apt-get install --no-install-suggests --no-install-recommends -y \
      vim \
      git \
      libmariadb-dev \
      imagemagick \
      libmagickwand-dev \
      default-mysql-client \
      libcurl4 \
      libjpeg-dev \
      libpng-dev \
      ffmpeg \
      curl \
      geoip-database \
      geoipupdate \
      tzdata \
      time \
 && curl -L https://github.com/rbspy/rbspy/releases/download/v0.3.7/rbspy-v0.3.7-x86_64-unknown-linux-musl.tar.gz \
  | tar xz -C /usr/local/bin \
 && curl -sL https://deb.nodesource.com/setup_13.x | bash \
 && apt-get install -y nodejs \
 && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update && apt-get install -y yarn \
 && node --version \
 && yarn --version \
 && echo 'gem: --no-document' >> /etc/gemrc \
 && gem install --no-document bundler puma rake \
 && apt-get purge -y --auto-remove \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /usr/share/{doc,info,man} \
 && rm -fr /tmp/*
