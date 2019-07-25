NAME    := pubnative/data-science-ci
TAG     := $$(git log -1 --pretty=%h)
IMG     := ${NAME}:${TAG}
LATEST  := ${NAME}:latest
 
all: build push

build:
	@docker build . -t ${IMG}
	@docker tag ${IMG} ${LATEST}

push:
	@docker push ${IMG}
	@docker push ${LATEST}
