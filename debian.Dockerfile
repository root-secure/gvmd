FROM ubuntu:18.04
ENV LIB_INSTALL_PREFIX ${LIB_INSTALL_PREFIX:-/usr}
ENV GVMD_DEB_BUILD_DIR ${GVMD_DEB_BUILD_DIR:-/tmp/gvmd}
ENV OPENVAS_MGR_DEB_BUILD_DIR ${OPENVAS_MGR_DEB_BUILD_DIR:-/tmp/openvas-manager}
# make tzdata installation noninteractive
ENV DEBIAN_FRONTEND ${DEBIAN_FRONTEND:-noninteractive}
ENV GVM_LIBS_BRANCH ${GVM_LIBS_BRANCH:-sean/43405}
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
# install dependencies
RUN apt-get update && apt-get install -q -y --fix-missing \
  tar \
  devscripts \
  debhelper \
  cmake \
  git \
  gcc \
  pkg-config \
  bison \
  libglib2.0-dev \
  libgpgme-dev \
  libgcrypt20-dev \
  libgnutls28-dev \
  libhiredis-dev \
  libssh-gcrypt-dev \
  uuid-dev \
  libical-dev \
  postgresql \
  postgresql-contrib \
  postgresql-server-dev-10 \
  && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
WORKDIR /tmp/build/gvm-libs
RUN set -x && \
  git clone https://github.com/root-secure/gvm-libs.git && \
  cd gvm-libs && \
  git fetch && git checkout ${GVM_LIBS_BRANCH} && \
  mkdir build && cd build && \
  cmake -DCMAKE_BUILD_TYPE=Release -DBACKEND=POSTGRESQL -DCMAKE_INSTALL_PREFIX=${LIB_INSTALL_PREFIX} .. && make && make install
WORKDIR /tmp/build/gvmd
COPY . .
RUN set -x && \
  mkdir build && cd build && \
  cmake -DCMAKE_BUILD_TYPE=Release -DBACKEND=POSTGRESQL -DCMAKE_INSTALL_PREFIX=${LIB_INSTALL_PREFIX} .. && make && make install
RUN set -x && \
  # create directories
  mkdir -p ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr \
  ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/bin \
  ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/lib \
  ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/etc/gvm \
  ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/sbin \
  ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/share \
  ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/share/doc/gvm \
  ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/share/gvm \
  ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/share/man \
  ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/share/man/man1 \
  ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/share/man/man8 && \
  # copy files
  cp /usr/bin/gvm-manage-certs ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/bin/ && \
  cp /usr/lib/libgvm-pg-server.so* ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/lib/ && \
  cp /usr/etc/gvm/*.conf ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/etc/gvm/ && \
  cp /usr/sbin/greenbone-* ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/sbin/ && \
  cp /usr/sbin/gvm-* ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/sbin/ && \
  cp /usr/sbin/gvmd* ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/sbin/ && \
  cp /usr/share/doc/gvm/* ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/share/doc/gvm/ && \
  cp -r /usr/share/gvm/* ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/share/gvm/ && \
  cp /usr/share/man/man1/gvm-manage-certs.1 ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/share/man/man1/ && \
  cp /usr/share/man/man8/greenbone-*.8 ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/share/man/man8/ && \
  cp /usr/share/man/man8/gvm-*.8 ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/share/man/man8/ && \
  cp /usr/share/man/man8/gvmd.8 ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2/usr/share/man/man8/ && \
  # create original archive
  cd ${GVMD_DEB_BUILD_DIR} && \
  tar -czvf gvmd_8.0.2.orig.tar.gz gvmd-8.0.2
COPY Debian/gvmd ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2
RUN set -x && \
  cd ${GVMD_DEB_BUILD_DIR}/gvmd-8.0.2 && \
  debuild -us -uc
COPY Debian/openvas-manager ${OPENVAS_MGR_DEB_BUILD_DIR}/openvas-manager
RUN set -x && \
  cd ${OPENVAS_MGR_DEB_BUILD_DIR}/openvas-manager && \
  debuild -us -uc
