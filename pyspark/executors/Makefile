OWNER			:= us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative
REPO			:= ${OWNER}/pyspark-executor
TAG				:= v3.4.1-python3.11-3
IMAGE			:= ${REPO}:${TAG}

build:
	docker build . -t ${IMAGE}

push: build
	docker push ${IMAGE}
