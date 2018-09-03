container_name=pubnative/spark
version=python3.6.5_java1.8.131_hadoop2.7.3_mesos1.3.0
tag=$(container_name):$(version)

docker-build:
	docker build . -t $(tag)

docker-run:
	docker run $(tag)

docker-build-and-run:
	make docker-build
	make docker-run

docker-push:
	docker push $(tag)
