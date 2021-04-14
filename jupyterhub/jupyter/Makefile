NAME	:= annoyingllama/jupyter
TAG		:= $(shell git log -1 --format='%cd.%h' --date=format:%Y%m%d-%H%M)
IMG		:= ${NAME}:${TAG}
LATEST	:= ${NAME}:latest

requirements:
	cp ../dependencies/requirements.txt .

build: requirements
	docker build . -t ${IMG} -t ${LATEST}

push: build
	docker push ${IMG}
	@echo pushed ${IMG} to DockerHub
