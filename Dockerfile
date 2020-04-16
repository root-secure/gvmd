FROM debian:latest
ENV LIB_INSTALL_PREFIX ${LIB_INSTALL_PREFIX:-/usr}
ENV DEB_BUILD_DIR ${DEB_BUILD_DIR:-/tmp/gvmd}
RUN apt-get update && apt-get install -q -y --fix-missing \
  tar \
  devscripts \
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
  libsqlite3-dev && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
WORKDIR /tmp/build/gvm-libs
RUN set -x && \
  git clone https://github.com/root-secure/gvm-libs.git && \
  cd gvm-libs && \
  git fetch && git checkout awn-gvm-libs-10.0 && \
  mkdir build && cd build && \
  cmake -DCMAKE_INSTALL_PREFIX=${LIB_INSTALL_PREFIX} .. && make && make install
WORKDIR /tmp/build/gvmd
COPY . .
RUN set -x && \
  mkdir build && cd build && \
  cmake -DCMAKE_INSTALL_PREFIX=${LIB_INSTALL_PREFIX} .. && make && make install
RUN set -x && \
  # create directories
  mkdir -p ${DEB_BUILD_DIR}/gvmd-8.0.1/usr \
  ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/bin \
  ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/etc/gvm \
  ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/sbin \
  ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/share \
  ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/share/doc/gvm \
  ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/share/gvm \
  ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/share/man \
  ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/share/man/man1 \
  ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/share/man/man8 && \
  # copy files
  cp /usr/bin/gvm-manage-certs ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/bin/ && \
  cp /usr/etc/gvm/*.conf ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/etc/gvm/ && \
  cp /usr/sbin/database-statistics-sqlite ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/sbin/ && \
  cp /usr/sbin/greenbone-* ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/sbin/ && \
  cp /usr/sbin/gvm-* ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/sbin/ && \
  cp /usr/sbin/gvmd* ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/sbin/ && \
  cp /usr/share/doc/gvm/* ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/share/doc/gvm/ && \
  cp -r /usr/share/gvm/* ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/share/gvm/ && \
  cp /usr/share/man/man1/gvm-manage-certs.1 ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/share/man/man1/ && \
  cp /usr/share/man/man8/database-statistics-sqlite.8 ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/share/man/man8/ && \
  cp /usr/share/man/man8/greenbone-*.8 ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/share/man/man8/ && \
  cp /usr/share/man/man8/gvm-*.8 ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/share/man/man8/ && \
  cp /usr/share/man/man8/gvmd.8 ${DEB_BUILD_DIR}/gvmd-8.0.1/usr/share/man/man8/ && \
  # create original archive
  cd ${DEB_BUILD_DIR} && \
  tar -czvf gvmd_8.0.1.orig.tar.gz gvmd-8.0.1
COPY Debian /tmp/gvmd/gvmd-8.0.1
RUN set -x && \
  cd ${DEB_BUILD_DIR}/gvmd-8.0.1 && \
  debuild -us -uc