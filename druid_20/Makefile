NAME = druid
TAG  = $(DRUID_VSN)
IMAGE = pubnative/$(NAME):$(TAG)
BUILD_PARAMS = --build-arg DRUID_VSN=${DRUID_VSN}

DRUID_VSN = 0.20.0

build:
	docker build $(BUILD_PARAMS) -t $(IMAGE) .

push:
	docker push $(IMAGE)
