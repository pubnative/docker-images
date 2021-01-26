NAME := pubnative/airflow-bi
COMMIT := $$(git log -1 --pretty=%h)
VERSIONED := ${NAME}:${COMMIT}
LATEST := ${NAME}:latest
 
all: compile build push

.PHONY: build
build:
	poetry export -f requirements.txt --output requirements.txt
	docker build --rm . -t ${VERSIONED}
	docker tag ${VERSIONED} ${LATEST}

.PHONY: push
push:
	docker push ${VERSIONED}
	docker push ${LATEST}
