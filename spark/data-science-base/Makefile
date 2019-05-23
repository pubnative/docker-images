NAME 	:= pubnative/pyspark-ci
TAG 	:= $$(git log -1 --pretty=%h)
IMG 	:= ${NAME}:data-science-base-${TAG}
LATEST 	:= ${NAME}:data-science-base-latest
 
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
