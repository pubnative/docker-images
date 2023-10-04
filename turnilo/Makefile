NAME := pubnative/turnilo
VERSION := 1.40.2
VERSIONED := ${NAME}:${VERSION}
TMPDIR := $(shell mktemp -d)
 
all: build push

build:
	git clone git@github.com:allegro/turnilo.git ${TMPDIR}/turnilo
	cd ${TMPDIR}/turnilo; \
	git checkout ${VERSION}; \
	docker build --rm . -t ${VERSIONED}
	rm -rf ${TMPDIR}

push:
	docker push ${VERSIONED}
