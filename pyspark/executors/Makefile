OWNER			:= us-docker.pkg.dev/vgi-pn-277619/data-team/pubnative
REPO			:= ${OWNER}/pyspark-executor
TAG				:= v4.0.1-python3.12-1
IMAGE			:= ${REPO}:${TAG}

build:
	docker buildx build . -t ${IMAGE} --platform linux/amd64

push: build
	docker push ${IMAGE}
