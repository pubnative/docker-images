OWNER			:=pubnative

PYSPARK			:= ${OWNER}/pyspark-notebook

ALL_SPARK		:= ${OWNER}/all-spark-notebook

NAME			:= ${OWNER}/verve-all-spark-notebook
HUB_VERSION		:= spark3.2-hadoop3.2-py3.9-java8
JUPYTERHUB		:= ${NAME}:${HUB_VERSION}

EXEC_VERSION	:= spark3.2-hadoop3.2-py3.9-java8
SPARK_EXECUTORS	:= ${OWNER}/spark-executors:${EXEC_VERSION}

openjdk_version	:= 8
curr_dir		:= $$(pwd)

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
	cp ${curr_dir}/package-dependencies/requirements.txt ${curr_dir}/verve-all-spark-notebook/.
	docker build \
 		--build-arg BASE_CONTAINER=${ALL_SPARK} \
 		${curr_dir}/verve-all-spark-notebook -t ${JUPYTERHUB}

push: jupyterhub
	docker push ${JUPYTERHUB}
	@echo pushed ${JUPYTERHUB} to DockerHub

executors: dependencies
	cp ${curr_dir}/package-dependencies/requirements.txt ${curr_dir}/spark-executors/.
	docker build --build-arg \
		openjdk_version=${openjdk_version} \
		${curr_dir}/spark-executors \
		-t ${SPARK_EXECUTORS}