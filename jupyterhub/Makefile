OWNER			:= pubnative
RELEASE_VER		:= 11
PYSPARK			:= ${OWNER}/pyspark-notebook

ALL_SPARK		:= ${OWNER}/all-spark-notebook

NAME			:= ${OWNER}/jupyterhub
HUB_VERSION		:= spark3.2-hadoop3.2-py3.9-java8-${RELEASE_VER}
JUPYTERHUB		:= ${NAME}:${HUB_VERSION}

SPARK_EXEC		:= ${OWNER}/spark-py
SPARK_EXEC_VER  := 3.2-hadoop3.2-py3.9-java8-${RELEASE_VER}
SPARK_EXEC_IMG	:= ${SPARK_EXEC}:${SPARK_EXEC_VER}

openjdk_version	:= 8
curr_dir		:= $$(pwd)

dependencies:
	@cd ${curr_dir}/package-dependencies && poetry export --output requirements.txt --without-hashes

spark_defaults:
	@sed 's#<spark-executor-image>#${SPARK_EXEC_IMG}#g' ${curr_dir}/data-science-notebook/spark-defaults.conf.template > ${curr_dir}/data-science-notebook/spark-defaults.conf

pyspark: dependencies
	@cp ${curr_dir}/package-dependencies/requirements.txt ${curr_dir}/pyspark-notebook/.
	# we override openjdk version 11 with 8 since gcs-connector only works with java 8
	docker build \
		--build-arg BASE_CONTAINER=jupyter/scipy-notebook:6e246ea4bbff \
		--build-arg openjdk_version=${openjdk_version} \
		${curr_dir}/pyspark-notebook -t ${PYSPARK}

spark_executors: pyspark
	docker build --build-arg base_img=${PYSPARK} ${curr_dir}/spark-executors -t ${SPARK_EXEC_IMG}

push_executors: spark_executors
	docker push ${SPARK_EXEC_IMG}
	@echo pushed ${SPARK_EXEC_IMG} to DockerHub

all_spark: pyspark
	docker build --build-arg BASE_CONTAINER=${PYSPARK} ${curr_dir}/all-spark-notebook -t ${ALL_SPARK}

jupyterhub: all_spark spark_defaults
	docker build --build-arg BASE_CONTAINER=${ALL_SPARK} ${curr_dir}/data-science-notebook -t ${JUPYTERHUB}

push_jupyterhub: jupyterhub
	docker push ${JUPYTERHUB}
	@echo pushed ${JUPYTERHUB} to DockerHub

