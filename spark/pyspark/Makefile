container_name=pubnative/pyspark-ci
version=1.0.2
tag=$(container_name):$(version)

all: build push

build:
	docker build . -t $(tag)

run:
	docker run $(tag)

push:
	docker push $(tag)
