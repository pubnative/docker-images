NAME = foundationdb
TAG  = v$(FDB_VERSION)
IMAGE = pubnative/$(NAME):$(TAG)
IMAGE_TOP = pubnative/$(NAME):$(TAG)-fdbtop
BUILD_PARAMS = --build-arg VSN=${FDB_VERSION}

FDB_VERSION = 6.1.12

build:
	docker build $(BUILD_PARAMS) -t $(IMAGE) .

push:
	docker push $(IMAGE)

build-fdbtop:
	docker build $(BUILD_PARAMS) -f Dockerfile.fdbtop -t $(IMAGE_TOP) .

push-fdbtop:
	docker push $(IMAGE_TOP)
