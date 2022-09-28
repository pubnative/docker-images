AIRFLOW_VERSION?=2.3.4
PYTHON_VERSION?=3.7
VERSION=v$(AIRFLOW_VERSION)
DOCKER_REPO=pubnative/airflow-2
DOCKER_REPO_DOCKERFILE_FOLDER?=.
DOCKER_REPO_VERSION=$(DOCKER_REPO):$(VERSION)
DOCKER_REPO_LATEST=$(DOCKER_REPO):latest

build: update-req
	docker build \
	    --build-arg AIRFLOW_VERSION=$(AIRFLOW_VERSION) \
	    --build-arg PYTHON_VERSION=$(PYTHON_VERSION) \
	    -t $(DOCKER_REPO_VERSION) \
	    $(DOCKER_REPO_DOCKERFILE_FOLDER)

	docker tag $(DOCKER_REPO_VERSION) $(DOCKER_REPO_LATEST)

update-req:
	poetry export --without-hashes --output requirements.txt

publish: publish-latest publish-version

publish-latest: build
    docker push $(DOCKER_REPO_LATEST)

publish-version: build
	docker push $(DOCKER_REPO_VERSION)