VERSION=0.9.0.1-4
KAFKA_VERSION=0.9.0.1
DOCKER_REPO=pubnative/kafka
DOCKER_REPO_VERSION=$(DOCKER_REPO):$(VERSION)
DOCKER_REPO_LATEST=$(DOCKER_REPO):latest

build:
	docker build --build-arg KAFKA_VERSION=${KAFKA_VERSION} -t $(DOCKER_REPO_VERSION) .
	docker tag $(DOCKER_REPO_VERSION) $(DOCKER_REPO_LATEST)

publish: publish-latest publish-version

publish-latest: build
    docker push $(DOCKER_REPO_LATEST)

publish-version: build
	docker push $(DOCKER_REPO_VERSION)
