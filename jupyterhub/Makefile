OWNER := pubnative
NAME := ${OWNER}/jupyterhub
BUILD_VERSION := $(shell poetry version -s)
HUB_VERSION := spark3.4.1-py3.11-hadoop3-openjdk17-scala2.12-build${BUILD_VERSION}
JUPYTERHUB	:= ${NAME}:${HUB_VERSION}

rule = major minor patch

$(rule):
	@poetry version $@

requirements:
	@poetry export --output requirements.txt

build: requirements
	# update variables after version patching
	$(eval BUILD_VERSION := $(shell poetry version -s))
	$(eval HUB_VERSION	:= spark3.4.1-py3.11-hadoop3-openjdk17-scala2.12-build${BUILD_VERSION})
	$(eval JUPYTERHUB	:= ${NAME}:${HUB_VERSION})
	@echo building ${JUPYTERHUB}
	docker build --build-arg env_image_tag=${HUB_VERSION} --build-arg build_version=${BUILD_VERSION} . -t ${JUPYTERHUB}

publish: build
	docker push ${JUPYTERHUB}
	@echo pushed ${JUPYTERHUB} to DockerHub
