NAME    := pubnative/pyspark-ci
TAG     := $$(git log -1 --pretty=%h)
IMG     := ${NAME}:base-${TAG}
LATEST  := ${NAME}:base-latest

all: build push

build:
	@docker build . -t ${IMG}
	@docker tag ${IMG} ${LATEST}

push:
	@docker push ${IMG}
	@docker push ${LATEST}
