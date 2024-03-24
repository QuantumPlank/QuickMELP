#!/bin/bash

WORK_DIR=$(pwd)

IMAGE_NAME=u20melp
IMAGE_SHA=($(sha1sum Docker/Dockerfile))
IMAGE=$IMAGE_NAME:$IMAGE_SHA

echo "Checking docker image availability"
if [[ "$(docker images -q $IMAGE 2> /dev/null)" == "" ]]; then
	echo "Image doesn't exists locally"
	echo "Building..."
	cd $WORK_DIR/Docker
	docker build . -t $IMAGE
	cd $WORK_DIR
fi

mkdir work &>/dev/null

echo "Starting Docker Container"
docker run \
	-it \
	--rm \
	-v $WORK_DIR/Docker/scripts:/scripts \
	-v $WORK_DIR/Docker/patches:/patches \
	-v $WORK_DIR/work:/work \
	-w /work \
	$IMAGE \
	/bin/bash
