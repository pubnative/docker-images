OWNER			:=pubnative
PYSPARK			:= ${OWNER}/pyspark-notebook
ALL_SPARK		:= ${OWNER}/all-spark-notebook

NAME			:= ${OWNER}/verve-all-spark-notebook
IMAGE_VERSION	:= 2.0
JUPYTERHUB		:= ${NAME}:${IMAGE_VERSION}

openjdk_version	:= 8
curr_dir		:= $$(pwd)

dependencies:
	cd ${curr_dir}/package-dependencies && poetry export --output requirements.txt --without-hashes
	mv ${curr_dir}/package-dependencies/requirements.txt ${curr_dir}/verve-all-spark-notebook/.

pyspark:
	# we override openjdk version 11 with 8 since gcs-connector only works with java 8
	docker build \
		--build-arg openjdk_version=${openjdk_version} \
		${curr_dir}/pyspark-notebook -t ${PYSPARK}

all_spark: pyspark
	docker build \
		--build-arg BASE_CONTAINER=${PYSPARK} \
		${curr_dir}/all-spark-notebook -t ${ALL_SPARK}

jupyterhub: all_spark dependencies
	docker build \
 		--build-arg BASE_CONTAINER=${ALL_SPARK} \
 		${curr_dir}/verve-all-spark-notebook -t ${JUPYTERHUB}

push: jupyterhub
	docker push ${JUPYTERHUB}
	@echo pushed ${JUPYTERHUB} to DockerHub
