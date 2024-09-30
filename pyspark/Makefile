OWNER			:= us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative
REPO			:= ${OWNER}/pyspark
TAG				:= v3.4.1-python3.11-1
IMAGE			:= ${REPO}:${TAG}

pyspark:
	@echo ${SPARK_HOME}
	docker-image-tool.sh \
		-r ${OWNER} \
		-t v3.4.1 \
		-p ./bindings/python/Dockerfile \
		build

build: pyspark
	docker build . -t ${IMAGE}

push: build
	docker push ${IMAGE}
