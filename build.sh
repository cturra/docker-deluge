#!/bin/bash

IMAGE_NAME="cturra/deluge"
BUILD_TAG=$(date '+%m%d%Y%M')
DOCKER=$(which docker)

# build image and tag with build tag (MonthDayYearMinute)
$DOCKER build -t ${IMAGE_NAME}:${BUILD_TAG} .

# add latest tag
$DOCKER tag --force ${IMAGE_NAME}:${BUILD_TAG} ${IMAGE_NAME}:latest
