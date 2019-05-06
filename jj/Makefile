JJ_VERSION=1.2.2
VERSION=$(JJ_VERSION)-1
DOCKER_REPO=pubnative/jj
DOCKER_REPO_VERSION=$(DOCKER_REPO):$(VERSION)
DOCKER_REPO_LATEST=$(DOCKER_REPO):latest

build:
	docker build --build-arg ZK_JJ_VERSIONDIST="$(JJ_VERSION)" -t $(DOCKER_REPO_VERSION) .
	docker tag $(DOCKER_REPO_VERSION) $(DOCKER_REPO_LATEST)

publish: publish-latest publish-version

publish-latest: build
	docker push $(DOCKER_REPO_LATEST)

publish-version: build
	docker push $(DOCKER_REPO_VERSION)

.PHONY: build publish publish-latest publish-version
