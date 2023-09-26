#!/bin/bash

WORK_DIR=$(pwd)
IMAGE_NAME=u20melp

if [[ "$(docker images -q $IMAGE_NAME 2> /dev/null)" == "" ]]; then
	echo "Image doesn't exists locally"
	echo "Building..."
	cd $WORK_DIR/Docker
	docker build . -t $IMAGE_NAME
fi

cd $WORK_DIR
mkdir .home &>/dev/null

echo "Starting Docker Container"

docker run \
	-it \
	--rm \
	-v $WORK_DIR/work:/work \
	-v $WORK_DIR/.home:/home/${USER} \
	-v /etc/passwd:/etc/passwd:ro \
	-v /etc/group:/etc/group:ro \
	-u $(id -u ${USER}):$(id -g ${USER}) \
	$IMAGE_NAME \
	/bin/bash

