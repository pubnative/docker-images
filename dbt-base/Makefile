SUB_NAME = $(shell grep '^name' home/pyproject.toml | sed 's/name = "\(.*\)"/\1/')
NAME = pubnative/${SUB_NAME}
COMMIT := $(shell git log -1 --pretty=%h)
UPSTREAM_IMAGE_VERSION = v$(shell grep '^version' home/pyproject.toml | sed 's/version = "\(.*\)"/\1/')-${COMMIT}
DOCKER_REPO := us-docker.pkg.dev/vgi-pn-277619/data-team
VERSIONED = ${DOCKER_REPO}/${NAME}:${UPSTREAM_IMAGE_VERSION}
LATEST = ${DOCKER_REPO}/${NAME}:latest
ALL_COMMANDS = build push
 
all: $(ALL_COMMANDS)
.PHONY: $(ALL_COMMANDS)

build:
	docker build --platform linux/amd64 --rm . -t ${VERSIONED}
	docker tag ${VERSIONED} ${LATEST}

push:
	docker push ${VERSIONED}
	docker push ${LATEST}
