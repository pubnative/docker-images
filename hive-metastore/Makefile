HIVE_METASTORE_VERSION?=3.0.0
HADOOP_VERSION?=3.3.3
MYSQL_VERSION?=8.0.29
VERSION=v$(HIVE_METASTORE_VERSION)
DOCKER_REPO=pubnative/hive-metastore
DOCKER_REPO_DOCKERFILE_FOLDER?=.
DOCKER_REPO_VERSION=$(DOCKER_REPO):$(VERSION)
DOCKER_REPO_LATEST=$(DOCKER_REPO):latest

build:
	docker build \
	    --platform linux/amd64 \
	    --build-arg HIVE_METASTORE_VERSION=$(HIVE_METASTORE_VERSION) \
	    --build-arg HADOOP_VERSION=$(HADOOP_VERSION) \
	    --build-arg MYSQL_VERSION=$(MYSQL_VERSION) \
	    -t $(DOCKER_REPO_VERSION) \
	    $(DOCKER_REPO_DOCKERFILE_FOLDER)

	docker tag $(DOCKER_REPO_VERSION) $(DOCKER_REPO_LATEST)

publish: publish-latest publish-version

publish-latest: build
    docker push $(DOCKER_REPO_LATEST)

publish-version: build
	docker push $(DOCKER_REPO_VERSION)