TRANQUILITY_VERSION=0.8.2
VERSION=v$(TRANQUILITY_VERSION)
DOCKER_REPO=pubnative/tranquility
DOCKER_REPO_VERSION=$(DOCKER_REPO):$(VERSION)
DOCKER_REPO_LATEST=$(DOCKER_REPO):latest

build: build-base

build-base:
	docker build --build-arg TRANQUILITY_VERSION="$(TRANQUILITY_VERSION)" -t $(DOCKER_REPO_VERSION) .
	docker tag $(DOCKER_REPO_VERSION) $(DOCKER_REPO_LATEST)

publish: publish-latest publish-version

publish-latest: build-base
    docker push $(DOCKER_REPO_LATEST)

publish-version: build-base
	docker push $(DOCKER_REPO_VERSION)
