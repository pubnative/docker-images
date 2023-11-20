DRUID_VERSION?=28.0.0
VERSION=v$(DRUID_VERSION)
DOCKER_REPO=pubnative/single-container-druid
DOCKER_REPO_DOCKERFILE_FOLDER?=.
DOCKER_REPO_VERSION=$(DOCKER_REPO):$(VERSION)
DOCKER_REPO_LATEST=$(DOCKER_REPO):latest

build:
	docker build --build-arg DRUID_VERSION=$(DRUID_VERSION) -t $(DOCKER_REPO_VERSION) $(DOCKER_REPO_DOCKERFILE_FOLDER)
	docker tag $(DOCKER_REPO_VERSION) $(DOCKER_REPO_LATEST)

publish: publish-latest publish-version

publish-latest: build
    docker push $(DOCKER_REPO_LATEST)

publish-version: build
	docker push $(DOCKER_REPO_VERSION)
