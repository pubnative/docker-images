# https://hub.docker.com/r/pubnative/zookeeper-exporter/
# Use `make` to build and push
FROM golang:1.11.4 AS builder
go get -u github.com/cloudflare/kafka_zookeeper_exporter
WORKDIR /go/src/github.com/cloudflare/kafka_zookeeper_exporter
RUN make

FROM scratch
EXPOSE 9141
ENTRYPOINT ["/kafka_zookeeper_exporter"]
COPY --from=builder /go/src/github.com/cloudflare/kafka_zookeeper_exporter/kafka_zookeeper_exporter /kafka_zookeeper_exporter

