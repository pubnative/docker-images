NAME    := pubnative/spark
TAG     := $$(git log -1 --pretty=%h)
IMG     := ${NAME}:pyspark-executor-${TAG}
LATEST  := ${NAME}:pyspark-executor-latest
 
all: build push

compile_dependencies:
	@pip-compile \
	 --generate-hashes \
	 --output-file requirements.txt \
	 requirements.in
	@chmod +r requirements.txt

build: compile_dependencies
	@docker build . -t ${IMG}
	@docker tag ${IMG} ${LATEST}

push:
	@docker push ${IMG}
	@docker push ${LATEST}
