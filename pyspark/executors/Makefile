OWNER			:= us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative
REPO			:= ${OWNER}/pyspark-executor
TAG				:= v3.4.1-python3.11-4
IMAGE			:= ${REPO}:${TAG}

build:
	docker build . -t ${IMAGE}

push: build
	docker push ${IMAGE}

# copy of the jupyterhub requirements without pendulum (breaks the executor build, only used in CLIs)
requirements:
	grep -v '^pendulum==' ../../jupyterhub/requirements.txt > requirements.txt
