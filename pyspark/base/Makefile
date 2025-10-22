OWNER			:= us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative
REPO			:= ${OWNER}/pyspark
TAG				:= v4.0.1-python3.12-1
IMAGE			:= ${REPO}:${TAG}

pyspark:
	@echo ${SPARK_HOME}
	docker-image-tool.sh \
		-r ${OWNER} \
		-t v4.0.1 \
		-p ./bindings/python/Dockerfile \
		build

build:
	docker buildx build . -t ${IMAGE} --platform linux/amd64

push: build
	docker push ${IMAGE}
