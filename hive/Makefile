HIVE_VERSION?=3.1.3
# increase for every new image built on top of v$(HIVE_VERSION), see Dockerfile
IMAGE_REVISION?=1
VERSION=v$(HIVE_VERSION)-$(IMAGE_REVISION)
DOCKER_REPO=us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/hive
DOCKER_REPO_DOCKERFILE_FOLDER?=.
DOCKER_REPO_VERSION=$(DOCKER_REPO):$(VERSION)
DOCKER_REPO_LATEST=$(DOCKER_REPO):latest

build:
	docker build \
	    --platform linux/amd64 \
	    -t $(DOCKER_REPO_VERSION) \
	    $(DOCKER_REPO_DOCKERFILE_FOLDER)

	docker tag $(DOCKER_REPO_VERSION) $(DOCKER_REPO_LATEST)

publish: publish-latest publish-version

publish-latest: build
	docker push $(DOCKER_REPO_LATEST)

publish-version: build
	docker push $(DOCKER_REPO_VERSION)