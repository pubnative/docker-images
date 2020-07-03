NAME = pubnative/wordpress
UPSTREAM_IMAGE_VERSION = php7.4
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
