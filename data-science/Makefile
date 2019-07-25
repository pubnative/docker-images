NAME    := pubnative/data-science
TAG     := $$(git log -1 --pretty=%h)
IMG     := ${NAME}:ci-${TAG}
LATEST  := ${NAME}:ci-latest
 
all: build push

build:
	@docker build . -t ${IMG}
	@docker tag ${IMG} ${LATEST}

push:
	@docker push ${IMG}
	@docker push ${LATEST}
