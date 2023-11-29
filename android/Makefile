VERSION=34_20231122
DOCKER_REPO=pubnative/android
DOCKER_REPO_VERSION=$(DOCKER_REPO):$(VERSION)
DOCKER_REPO_LATEST=$(DOCKER_REPO):latest

build:
	docker build -t $(DOCKER_REPO_VERSION) .
	docker tag $(DOCKER_REPO_VERSION) $(DOCKER_REPO_LATEST)

publish: publish-latest publish-version

publish-latest: build
    docker push $(DOCKER_REPO_LATEST)

publish-version: build
	docker push $(DOCKER_REPO_VERSION)
