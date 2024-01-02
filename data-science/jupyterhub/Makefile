OWNER			:= pubnative
NAME			:= ${OWNER}/jupyterhub
BUILD_VERSION	:= $$(poetry version -s)
HUB_VERSION		:= spark3.4.1-py3.11-hadoop3-openjdk17-scala2.12-build${BUILD_VERSION}
JUPYTERHUB		:= ${NAME}:${HUB_VERSION}

curr_dir		:= $$(pwd)

rule = major minor patch

$(rule):
	@poetry version $@

dependencies: patch
	@poetry export --output requirements.txt

build: dependencies
	docker build . -t ${JUPYTERHUB}

publish: build
	docker push ${JUPYTERHUB}
	@echo pushed ${JUPYTERHUB} to DockerHub

