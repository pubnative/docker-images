NAME := pubnative/jupyter
TAG := $$(git log -1 --pretty=%h)
IMG := ${NAME}:${TAG}
LATEST := ${NAME}:latest
 
all: build push

compile_dependencies:
	pip-compile \
	  --generate-hashes \
	  --output-file requirements.txt \
	  --allow-unsafe \
	  requirements.in
	chmod +r requirements.txt

build: compile_dependencies
	docker build --rm . -t ${IMG}

push:
	docker push ${IMG}
