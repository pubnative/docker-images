OWNER			:= pubnative
JAVA_BASE		:= 8-jre-slim

REPO			:= ${OWNER}/pyspark
TAG				:= v3.2.0-java8
IMAGE			:= ${REPO}:${TAG}



pyspark:
	@echo ${SPARK_HOME}
	docker-image-tool.sh \
		-r ${OWNER} \
		-t v3.2.0-java8-base \
		-b java_image_tag=8-jre-slim \
		-p ${SPARK_HOME}/kubernetes/dockerfiles/spark/bindings/python/Dockerfile \
		build

build: pyspark
	docker build . -t ${IMAGE}

push: build
	docker push ${IMAGE}
