NAME := pubnative/pyspark-ci
TAG := $$(git log -1 --pretty=%h)
IMG := ${NAME}:${TAG}
LATEST := ${NAME}:latest
 
build:
	@docker build . -t ${IMG}
	@docker tag ${IMG} ${LATEST}
 
push:
	@docker push ${NAME}
