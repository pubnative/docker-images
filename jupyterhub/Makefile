OWNER := pubnative
NAME := ${OWNER}/jupyterhub
BUILD_VERSION := $(shell poetry version -s)
HUB_VERSION := spark3.4.1-py3.11-hadoop3-openjdk11-scala2.12-build${BUILD_VERSION}
JUPYTERHUB	:= ${NAME}:${HUB_VERSION}

rule = major minor patch

$(rule):
	@poetry version $@

requirements:
	@poetry export --without-hashes --output requirements.txt

build: requirements
	# update variables after version patching
	@echo building ${JUPYTERHUB}
	docker build \
	   --platform linux/amd64 \
	   --build-arg env_image_tag=${HUB_VERSION} \
	   --build-arg build_version=${BUILD_VERSION} \
	   -t ${JUPYTERHUB} .

publish: build
	docker push ${JUPYTERHUB}
	@echo pushed ${JUPYTERHUB} to DockerHub
