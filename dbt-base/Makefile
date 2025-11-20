SUB_NAME = $(shell grep '^name' home/pyproject.toml | sed 's/name = "\(.*\)"/\1/')
NAME = pubnative/${SUB_NAME}
UPSTREAM_IMAGE_VERSION = $(shell grep '^version' home/pyproject.toml | sed 's/version = "\(.*\)"/\1/')
VERSIONED = ${NAME}:${UPSTREAM_IMAGE_VERSION}
LATEST = ${NAME}:latest
ALL_COMMANDS = build push
 
all: $(ALL_COMMANDS)
.PHONY: $(ALL_COMMANDS)

build:
	docker build --rm . -t ${VERSIONED}
	docker tag ${VERSIONED} ${LATEST}

push:
	docker push ${VERSIONED}
	docker push ${LATEST}
