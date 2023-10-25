VERSION=28_20190219
# DOCKER_REPO=pubnative/android
# DOCKER_REPO_VERSION=$(DOCKER_REPO):$(VERSION)
# DOCKER_REPO_LATEST=$(DOCKER_REPO):latest
IMG_NAME=pubnative
IMG_TAG=android

build:
	docker build -t $(IMG_NAME):$(IMG_TAG) .

# build:
# 	docker build -t $(DOCKER_REPO_VERSION) .
# 	docker tag $(DOCKER_REPO_VERSION) $(DOCKER_REPO_LATEST)

# publish: publish-latest publish-version

# publish-latest: build
#     docker push $(DOCKER_REPO_LATEST)

# publish-version: build
# 	docker push $(DOCKER_REPO_VERSION)