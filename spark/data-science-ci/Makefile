NAME 	:= pubnative/pyspark-ci
TAG 	:= $$(git log -1 --pretty=%h)
IMG 	:= ${NAME}:data-science-ci-${TAG}
LATEST 	:= ${NAME}:data-science-ci-latest
 
all: build push

build:
	@docker build . -t ${IMG}
	@docker tag ${IMG} ${LATEST}

push:
	@docker push ${IMG}
	@docker push ${LATEST}
