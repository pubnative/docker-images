NAME := pubnative/jupyter
TAG := $$(git log -1 --pretty=%h)
IMG := ${NAME}:${TAG}
LATEST := ${NAME}:latest
 
all: compile build push

compile:
	poetry export > requirements.txt

build:
	docker build --rm . -t ${IMG}
	docker tag ${IMG} ${LATEST}

push:
	docker push ${NAME}
