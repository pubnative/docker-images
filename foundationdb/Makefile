NAME = foundationdb
TAG  = v$(FDB_VERSION)
IMAGE = pubnative/$(NAME):$(TAG)
BUILD_PARAMS = --build-arg VSN=${FDB_VERSION}

FDB_VERSION = 6.0.15

build:
	docker build $(BUILD_PARAMS) -t $(IMAGE) .

push:
	docker push $(IMAGE)
