NAME := pubnative/jupyter
TAG := $$(git log -1 --pretty=%h)
IMG := ${NAME}:${TAG}
LATEST := ${NAME}:latest
 
all: compile_dependencies build push

compile_dependencies:
	poetry export > requirements.in
	pip-compile \
	  --generate-hashes \
	  --output-file requirements.txt \
	  --allow-unsafe \
	  requirements.in
	chmod +r requirements.txt

build:
	docker build --rm . -t ${IMG}
	docker tag ${IMG} ${LATEST}

push:
	docker push ${NAME}
