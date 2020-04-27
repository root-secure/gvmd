#!/bin/bash

GVMD_DEB_BUILD_DIR=/tmp/gvmd
OPENVAS_MGR_DEB_BUILD_DIR=/tmp/openvas-manager
IMAGE="$1"
docker run -it ${IMAGE} /bin/true
LATEST=$(docker ps -l -f ancestor=${IMAGE} --format "{{.ID}}")
docker cp ${LATEST}:${GVMD_DEB_BUILD_DIR}/gvmd_8.0.1_amd64.deb ./
docker cp ${LATEST}:${OPENVAS_MGR_DEB_BUILD_DIR}/openvas-manager_8.0.1_amd64.deb ./
for dock in $(docker ps -f ancestor=${IMAGE} -a -q) ; do
	docker rm $dock
done