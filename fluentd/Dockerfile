FROM alpine:latest
MAINTAINER PubNative Team <team@pubnative.net>

ENV FLUENTD_VERSION=0.12.23
# Do not split this into multiple RUN!
# Docker creates a layer for every RUN-Statement
# therefore an 'apk delete build*' has no effect
RUN apk --no-cache --update add \
                            build-base \
                            ca-certificates \
                            ruby \
                            ruby-irb \
                            ruby-dev \
                            gettext && \
    echo 'gem: --no-document' >> /etc/gemrc && \
    gem install fluentd -v $FLUENTD_VERSION && \
    gem install fluent-plugin-elasticsearch && \
    fluentd -s /fluentd/etc/ && \
    apk del build-base ruby-dev && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* && \
    adduser -D -g '' -u 1000 -h /home/fluent fluent && \
    chown -R fluent:fluent /home/fluent && \
    mkdir -p /fluentd/log && \
    chown -R fluent:fluent /fluentd

USER fluent
WORKDIR /home/fluent

# Tell ruby to install packages as user
RUN echo "gem: --user-install --no-document" >> ~/.gemrc
ENV PATH /home/fluent/.gem/ruby/2.2.0/bin:$PATH
ENV GEM_PATH /home/fluent/.gem/ruby/2.2.0:$GEM_PATH

ENV FLUENTD_OPT=""

EXPOSE 24224 5140
ADD entrypoint.sh /
ADD fluent.conf.tpl /fluentd/etc/
CMD /entrypoint.sh
