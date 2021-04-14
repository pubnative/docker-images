NAME	:= annoyingllama
TAG		:= 3.1.1-hadoop2.7-python3.8

requirements:
	cp ../dependencies/requirements.txt ${SPARK_HOME}/requirements.txt

build:
	docker-image-tool.sh  -r ${NAME} -t ${TAG} -p Dockerfile build

push:
	docker-image-tool.sh  -r ${NAME} -t ${TAG} -p Dockerfile build

build-push:
	docker-image-tool.sh  -r ${NAME} -t ${TAG} -X -p Dockerfile build

clean:
	rm ${SPARK_HOME}/requirements.txt