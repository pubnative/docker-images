NAME	:= pubnative/all-spark-notebook
TAG		:= 1.0
IMG		:= ${NAME}:${TAG}

requirements:
	cp ../dependencies/requirements.txt .

build: requirements
	docker build . -t ${IMG}
