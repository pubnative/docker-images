NAME = pubnative/awscli
UPSTREAM_IMAGE_VERSION = 1.14.5
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
