OWNER			:= pubnative
REPO			:= ${OWNER}/pyspark
TAG				:= v3.4.1
IMAGE			:= ${REPO}:${TAG}



pyspark:
	@echo ${SPARK_HOME}
	docker-image-tool.sh \
		-r ${OWNER} \
		-t v3.4.1 \
		-p ${SPARK_HOME}/kubernetes/dockerfiles/spark/bindings/python/Dockerfile \
		build

build: pyspark
	docker build . -t ${IMAGE}

push: build
	docker push ${IMAGE}
