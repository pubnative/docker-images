NAME := pubnative/pyspark-ci
TAG := $$(git log -1 --pretty=%h)
IMG := ${NAME}:${TAG}
LATEST := ${NAME}:latest
 
build:
	./compile_dependencies.sh
	@docker build . -t ${IMG}
	@docker tag ${IMG} ${LATEST}
 
push:
	@docker push ${NAME}
