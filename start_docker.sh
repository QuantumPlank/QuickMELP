#!/bin/bash

WORK_DIR=$(pwd)
IMAGE_NAME=u20melp


if docker image inspect $IMAGE_NAME &>/dev/null; then
	echo "Image doesn't exists locally"
	echo "Building..."
	cd $WORK_DIR/Docker
	docker build . -t ubuntu_melpi
fi
cd $WORK_DIR
echo "Starting Docker Container"

docker run \
	-it \
	--rm \
	-v $(WORK_DIR)/work:/work \
	-v /etc/passwd:/etc/passwd:ro \
	-v /etc/group:/etc/group:ro \
	-u $(id -u ${USER}):$(id -g ${USER}) \
	$IMAGE_NAME \
	/bin/bash

