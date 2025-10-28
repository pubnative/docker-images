DRUID_VERSION := 33.0.0
JDK_VERSION := 17
TARGETARCH := arm64
COMMIT := $(shell git log -1 --pretty=%h)
VERSION := v${DRUID_VERSION}-${TARGETARCH}-${COMMIT}
DOCKER_REPO := us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/druid
DOCKER_REPO_DOCKERFILE_FOLDER := .
DOCKER_REPO_VERSION := ${DOCKER_REPO}:${VERSION}

build:
	docker build \
	    --platform linux/$(TARGETARCH) \
	    --build-arg DRUID_VERSION=$(DRUID_VERSION) \
	    --build-arg TARGETARCH=$(TARGETARCH) \
	    --build-arg JDK_VERSION=$(JDK_VERSION) \
	    -t $(DOCKER_REPO_VERSION) \
	    $(DOCKER_REPO_DOCKERFILE_FOLDER)

publish: publish-version

publish-version: build
	docker push $(DOCKER_REPO_VERSION)
