GPG_KEY=3F7A1D16FA4217B1DC75E1C9FFE35B7F15DFA1BA
ZOOKEEPER_VERSION=3.4.14
VERSION=$(ZOOKEEPER_VERSION)-1
DOCKER_REPO=pubnative/zookeeper
DOCKER_REPO_VERSION=$(DOCKER_REPO):$(VERSION)
DOCKER_REPO_LATEST=$(DOCKER_REPO):latest

build:
	docker build --build-arg GPG_KEY=$(GPG_KEY) --build-arg ZK_DIST="zookeeper-$(ZOOKEEPER_VERSION)" -t $(DOCKER_REPO_VERSION) .
	docker tag $(DOCKER_REPO_VERSION) $(DOCKER_REPO_LATEST)

publish: publish-latest publish-version

publish-latest: build
    docker push $(DOCKER_REPO_LATEST)

publish-version: build
	docker push $(DOCKER_REPO_VERSION)

.PHONY: build publish publish-latest publish-version
