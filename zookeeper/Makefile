GPG_KEY=AF3D175EC05DB249738D01AC8D8C3C3ED0B02E66
ZOOKEEPER_VERSION=3.7.0
VERSION=$(ZOOKEEPER_VERSION)-1
DOCKER_REPO=us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/zookeeper
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
