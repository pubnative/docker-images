NAME	:= pubnative/jupyterhub-all-spark-notebook
TAG		:= $(shell git log -1 --format='%cd.%h' --date=format:%Y%m%d-%H%M)
IMG		:= ${NAME}:${TAG}

requirements:
	cp ../dependencies/requirements.txt .

build: requirements
	docker build . -t ${IMG}

push: build
	docker push ${IMG}
	@echo pushed ${IMG} to DockerHub
