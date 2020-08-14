FROM centos:7.8.2003

# setup environment
ENV ZLIB_VERSION ${ZLIB_VERSION:-1.2.11}
ENV LIBGPG_ERROR_VERSION ${LIBGPG_ERROR_VERSION:-1.38}
ENV LIBASSUAN_VERSION ${LIBASSUAN_VERSION:-2.5.3}
ENV GPGME_VERSION ${GPGME_VERSION:-1.14.0}
ENV UTIL_LINUX_VERSION ${UTIL_LINUX_VERSION:-2.36}
ENV LIB_INSTALL_PREFIX ${LIB_INSTALL_PREFIX:-/}
ENV GVMD_RPM_BUILD_DIR ${GVMD_RPM_BUILD_DIR:-/root/gvmd/rpmbuild}
ENV OPENVAS_MGR_RPM_BUILD_DIR ${OPENVAS_MGR_RPM_BUILD_DIR:-/root/openvas-manager/rpmbuild}
ENV SQLITE_DEVEL_RPM_BUILD_DIR ${SQLITE_DEVEL_RPM_BUILD_DIR:-/root/sqlite/rpmbuild}

# install repositories
RUN yum -y install epel-release && \
  yum repolist

# install packages
RUN yum update -y && \
  yum install -q -y \
    git \
    tcl \
    wget \
    which \
    rpm-build \
    rpmlint \
    gnupg2-smime \
    tar \
    bzip2 \
    cmake3 \
    gcc \
    bison \
    glib2-devel \
    libgcrypt-devel \
    gnutls-devel \
    hiredis-devel \
    libssh-devel \
    libical-devel && \
  yum clean all && \
  rm -rf /var/cache/yum/*

# install missing packages from source
WORKDIR /tmp/zlib
RUN wget https://www.zlib.net/zlib-${ZLIB_VERSION}.tar.gz && \
  tar -xzvf zlib-${ZLIB_VERSION}.tar.gz --strip-components=1 && \
  ./configure --prefix=/ --libdir=/lib64 --includedir=/usr/include && make && make install
WORKDIR /tmp/libgpg-error
RUN wget https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-${LIBGPG_ERROR_VERSION}.tar.bz2 && \
  tar -jxvf libgpg-error-${LIBGPG_ERROR_VERSION}.tar.bz2 --strip-components=1 && \
  ./configure --prefix=/ --libdir=/lib64 --includedir=/usr/include && make && make install
WORKDIR /tmp/libassuan
RUN wget https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-${LIBASSUAN_VERSION}.tar.bz2 && \
  tar -jxvf libassuan-${LIBASSUAN_VERSION}.tar.bz2 --strip-components=1 && \
  ./configure --prefix=/ --libdir=/lib64 --includedir=/usr/include && make && make install
WORKDIR /tmp/gpgme
RUN wget https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-${GPGME_VERSION}.tar.bz2 && \
  tar -jxvf gpgme-${GPGME_VERSION}.tar.bz2 --strip-components=1 && \
  ./configure CC=c99 --prefix=/ --libdir=/lib64 --includedir=/usr/include && make && make install
WORKDIR /tmp/sqlite
RUN set -x && \
  wget -O sqlite.tar.gz https://www.sqlite.org/src/tarball/sqlite.tar.gz?v=3.33.0 && \
  tar -xzvf sqlite.tar.gz && \
  mkdir build && cd build && \
  ../sqlite/configure --prefix=/ --libdir=/lib64 --includedir=/usr/include && make && make install
WORKDIR /tmp/util-linux
RUN wget https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v${UTIL_LINUX_VERSION}/util-linux-${UTIL_LINUX_VERSION}.tar.gz && \
  tar -xzvf util-linux-${UTIL_LINUX_VERSION}.tar.gz --strip-components=1 && \
  ./configure --prefix=/ --libdir=/lib64 --includedir=/usr/include && make && make install
WORKDIR /tmp/gvm-libs
RUN set -x && \
  git clone https://github.com/root-secure/gvm-libs.git && \
  cd gvm-libs && \
  git fetch && git checkout awn-gvm-libs-10.0 && \
  mkdir build && cd build && \
  cmake3 -DCMAKE_INSTALL_PREFIX=${LIB_INSTALL_PREFIX} .. && make && make install

# build gvmd
WORKDIR /tmp/gvmd
COPY . .
RUN set -x && \
  mkdir build && cd build && \
  cmake3 -DCMAKE_INSTALL_PREFIX=${LIB_INSTALL_PREFIX} .. && make && make install

# build the RPM
WORKDIR ${GVMD_RPM_BUILD_DIR}
COPY RPM/gvmd/rpmbuild .
RUN set -x && \
  rpmbuild -bb SPECS/gvmd.spec
WORKDIR ${OPENVAS_MGR_RPM_BUILD_DIR}
COPY RPM/openvas-manager/openvas-manager.logrotate /etc/logrotate.d/openvas-manager
COPY RPM/openvas-manager/openvas-manager.service /etc/systemd/system/multi-user.target.wants/openvas-manager.service
COPY RPM/openvas-manager/rpmbuild .
RUN set -x && \
  rpmbuild -bb SPECS/openvas-manager.spec
WORKDIR ${SQLITE_DEVEL_RPM_BUILD_DIR}
COPY RPM/sqlite-devel/rpmbuild .
RUN set -x && \
  rpmbuild -bb SPECS/sqlite-devel.spec