OWNER			:= pubnative
RELEASE_VER		:= 1.0.0


NAME			:= ${OWNER}/jupyterhub
BUILD_VERSION	:= $$(poetry version | cut -f2 -d' ')
HUB_VERSION		:= spark3.4.1-py3.11-hadoop3-openjdk17-scala2.12-build${BUILD_VERSION}
JUPYTERHUB		:= ${NAME}:${HUB_VERSION}

curr_dir		:= $$(pwd)

dependencies:
	@poetry export --output requirements.txt

jupyterhub: dependencies
	docker build . -t ${JUPYTERHUB}

push_jupyterhub: jupyterhub
	docker push ${JUPYTERHUB}
	@echo pushed ${JUPYTERHUB} to DockerHub

bump_version:
	@poetry version