DRUID_VERSION="0.12.2"
VERSION="v$(DRUID_VERSION)"
DOCKER_REPO="pubnative/druid"
DOCKER_REPO_VERSION="$(DOCKER_REPO):$(VERSION)"
DOCKER_REPO_LATEST="$(DOCKER_REPO):latest"

build: build-base

build-base:
	docker build --build-arg DRUID_VERSION="$(DRUID_VERSION)" -t $(DOCKER_REPO_VERSION) base; docker tag "$(DOCKER_REPO_VERSION)" "$(DOCKER_REPO_LATEST)"

publish: publish-latest publish-version

publish-latest:
    docker push $(DOCKER_REPO_LATEST)

publish-version:
	docker push $(DOCKER_REPO_VERSION)
