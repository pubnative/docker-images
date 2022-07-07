NAME := pubnative/airflow
COMMIT := $(shell git log -1 --pretty=%h)
VERSIONED := ${NAME}:plugins-${COMMIT}
LATEST := ${NAME}:latest
 
all: build push

.PHONY: build
build: update_req
	docker build --rm . -t ${VERSIONED}
	docker tag ${VERSIONED} ${LATEST}

.PHONY: update_req
update_req:
	poetry export --output requirements.txt

.PHONY: push
push:
	docker push ${VERSIONED}
	docker push ${LATEST}
