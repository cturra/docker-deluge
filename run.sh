#!/bin/bash

IMAGE_NAME="cturra/deluge"
CONTAINER_NAME="deluge"

DOCKER=$(which docker)

# function to check if container is running
function check_container() {
  $DOCKER ps --filter "name=${CONTAINER_NAME}" --format "{{.ID}}"
}

# function to start new docker container
function start_container() {
  $DOCKER run --name ${CONTAINER_NAME} --restart always -p 8112:8112/tcp -p 53160:53160 -p 58846:58846/tcp -d \
    -v /data/deluge:/data -v /data/downloads:/data/downloads -v /data/dropbox/Dropbox/torrent/deluge:/data/torrents \
    ${IMAGE_NAME}:latest > /dev/null
}

# check if docker container with same name is already running.
if [ "$(check_container)" != "" ]; then
  # container found...
  # 1) rename existing container
  $DOCKER rename ${CONTAINER_NAME} "${CONTAINER_NAME}_orig" > /dev/null 2>&1
  # 2) stop exiting container
  $DOCKER stop "${CONTAINER_NAME}_orig" > /dev/null 2>&1
  # 3) start new container
  start_container
  # 4) remover existing container
  if [ "$(check_container)" != "" ]; then
    $DOCKER rm "${CONTAINER_NAME}_orig" > /dev/null 2>&1
  fi

  # finally, lets clean up old docker images
  $DOCKER rmi $($DOCKER images -q ${IMAGE_NAME}) > /dev/null 2>&1

# no docker container found. start a new one.
else
  start_container
fi