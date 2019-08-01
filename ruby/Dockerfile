## ref: https://hub.docker.com/r/pubnative/ruby

ARG RUBY_VERSION="2.6.3"
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
 && curl -sL https://deb.nodesource.com/setup_8.x -o nodesource_setup.sh \
 && bash nodesource_setup.sh \
 && rm -f nodesource_setup.sh \
 && apt-get install -y nodejs \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /usr/share/{doc,info,man} \
 && mkdir /usr/local/share/yarn/ \
 && curl -L https://yarnpkg.com/${YARN_VERSION}.tar.gz \
  | tar -xz -C /usr/local/share/yarn --strip 1 \
 && ln -s /usr/local/share/yarn/bin/yarn /usr/local/bin \
 && ln -s /usr/local/share/yarn/bin/yarnpkg /usr/local/bin \
 && yarn --version \
 && echo 'gem: --no-document' >> /etc/gemrc \
 && gem install --no-document bundler:2.0.2 puma \
 && apt-get purge -y --auto-remove \
 && rm -fr /tmp/*
