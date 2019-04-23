container_name=pubnative/spark
version=pyspark
tag=$(container_name):$(version)

all: build push

build:
	docker build . -t $(tag)

run:
	docker run $(tag)

push:
	docker push $(tag)
