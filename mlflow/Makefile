VERSION=0.0.1
DOCKER_REPO=pubnative/mlflow
DOCKER_REPO_VERSION=$(DOCKER_REPO):$(VERSION)

build:
	docker build -t $(DOCKER_REPO_VERSION) .

publish: build
	docker push $(DOCKER_REPO_VERSION)
