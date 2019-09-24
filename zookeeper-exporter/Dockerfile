# https://hub.docker.com/r/pubnative/zookeeper-exporter/
# Use `make` to build and push
FROM golang:1.11.4 AS builder
RUN go get -u github.com/carlpett/zookeeper_exporter
WORKDIR /go/src/github.com/carlpett/zookeeper_exporter/
RUN make build

FROM scratch
EXPOSE 9141
ENTRYPOINT ["/zookeeper_exporter"]
COPY --from=builder /go/src/github.com/carlpett/zookeeper_exporter/zookeeper_exporter /zookeeper_exporter

