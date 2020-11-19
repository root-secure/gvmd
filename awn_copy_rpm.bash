#!/bin/bash

RPM_BUILD_DIR=/root/rpmbuild
IMAGE="$1"
docker run -it ${IMAGE} /bin/true
LATEST=$(docker ps -l -f ancestor=${IMAGE} --format "{{.ID}}")
docker cp ${LATEST}:${RPM_BUILD_DIR}/RPMS/x86_64/. ./
for dock in $(docker ps -f ancestor=${IMAGE} -a -q) ; do
	docker rm $dock
done