OWNER			:= pubnative

PYSPARK			:= ${OWNER}/pyspark-notebook

ALL_SPARK		:= ${OWNER}/all-spark-notebook

NAME			:= ${OWNER}/jupyterhub
HUB_VERSION		:= spark3.2-hadoop3.2-py3.9-java8
JUPYTERHUB		:= ${NAME}:${HUB_VERSION}

SPARK_EXEC_VER	:= 3.2-hadoop3.2-py3.9-java8

openjdk_version	:= 8
curr_dir		:= $$(pwd)

SPARK_VERSION 	:= $(shell head -c11 $(SPARK_HOME)/RELEASE)

dependencies:
	cd ${curr_dir}/package-dependencies && poetry export --output requirements.txt --without-hashes

pyspark:
	# we override openjdk version 11 with 8 since gcs-connector only works with java 8
	docker build \
		--build-arg BASE_CONTAINER=jupyter/scipy-notebook:hub-1.5.0 \
		--build-arg openjdk_version=${openjdk_version} \
		${curr_dir}/pyspark-notebook -t ${PYSPARK}

all_spark: pyspark
	docker build \
		--build-arg BASE_CONTAINER=${PYSPARK} \
		${curr_dir}/all-spark-notebook -t ${ALL_SPARK}

jupyterhub: all_spark dependencies
	cp ${curr_dir}/package-dependencies/requirements.txt ${curr_dir}/data-science-notebook/.
	docker build \
 		--build-arg BASE_CONTAINER=${ALL_SPARK} \
 		${curr_dir}/data-science-notebook -t ${JUPYTERHUB}

spark_executors: dependencies
ifeq (${SPARK_VERSION}, "Spark 3.2.0")
	cp ${curr_dir}/package-dependencies/requirements.txt ${SPARK_HOME}/requirements.txt
	docker-image-tool.sh  -r ${OWNER} -t ${SPARK_EXEC_VER} -p ${curr_dir}/spark-executors/Dockerfile \
		-b java_image_tag=8-jre-slim build
else
	@echo spark_version is ${SPARK_VERSION}. Please set SPARK_HOME to spark 3.2.0.
endif

push_jupyterhub: jupyterhub
	docker push ${JUPYTERHUB}
	@echo pushed ${JUPYTERHUB} to DockerHub

push_executors: spark_executors
	docker push ${OWNER}/spark-py:${SPARK_EXEC_VER}
	@echo pushed ${OWNER}/spark-py:${SPARK_EXEC_VER} to DockerHub
