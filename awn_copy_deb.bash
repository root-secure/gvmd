#!/bin/bash

DEB_BUILD_DIR=/tmp/gvmd
IMAGE="$1"
docker run -it ${IMAGE} /bin/true
LATEST=$(docker ps -l -f ancestor=${IMAGE} --format "{{.ID}}")
docker cp ${LATEST}:${DEB_BUILD_DIR}/gvmd_8.0.1_amd64.deb ./
for dock in $(docker ps -f ancestor=${IMAGE} -a -q) ; do
	docker rm $dock
done