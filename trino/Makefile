TRINO_VERSION := 476
AGENT_VERSION := 0.20.0
COMMIT := $(shell git log -1 --pretty=%h)
VERSION := v$(TRINO_VERSION)-$(COMMIT)
DOCKER_REPO := us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/trino
DOCKER_REPO_DOCKERFILE_FOLDER := .
DOCKER_REPO_VERSION := $(DOCKER_REPO):$(VERSION)
DOCKER_REPO_LATEST := $(DOCKER_REPO):latest

build:
	docker build \
	    --platform linux/amd64 \
	    --build-arg TRINO_VERSION=$(TRINO_VERSION) \
	    --build-arg AGENT_VERSION=$(AGENT_VERSION) \
	    -t $(DOCKER_REPO_VERSION) \
	    $(DOCKER_REPO_DOCKERFILE_FOLDER)

	docker tag $(DOCKER_REPO_VERSION) $(DOCKER_REPO_LATEST)

publish: publish-latest publish-version

publish-latest: build
 docker push $(DOCKER_REPO_LATEST)

publish-version: build
	docker push $(DOCKER_REPO_VERSION)
