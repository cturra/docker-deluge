#!/bin/bash

# grab global variables
source vars

DOCKER=$(which docker)

# build image and tag with build tag (MonthDayYearMinute)
$DOCKER build --pull --tag ${IMAGE_NAME}:${BUILD_TAG} .

# add latest tag
$DOCKER tag ${IMAGE_NAME}:${BUILD_TAG} ${IMAGE_NAME}:latest
