AIRFLOW_VERSION := 2.5.1
COMMIT := $(shell git log -1 --pretty=%h)
VERSION := v${AIRFLOW_VERSION}-${COMMIT}
DOCKER_REPO := us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative/airflow-2
DOCKER_REPO_DOCKERFILE_FOLDER := .
DOCKER_REPO_VERSION := ${DOCKER_REPO}:${VERSION}
DOCKER_REPO_LATEST := ${DOCKER_REPO}:latest

build: update-req
	docker build \
		   --platform linux/amd64 \
	    --build-arg AIRFLOW_VERSION=$(AIRFLOW_VERSION) \
	    -t $(DOCKER_REPO_VERSION) \
	    $(DOCKER_REPO_DOCKERFILE_FOLDER)

	docker tag $(DOCKER_REPO_VERSION) $(DOCKER_REPO_LATEST)

update-req:
	rye lock
	rye sync
	sed '/-e/d' requirements.lock > requirements.txt

publish: publish-latest publish-version

publish-latest: build
	docker push ${DOCKER_REPO_LATEST}

publish-version: build
	docker push ${DOCKER_REPO_VERSION}
