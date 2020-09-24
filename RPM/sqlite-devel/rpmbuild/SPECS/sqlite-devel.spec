Name:           sqlite-devel
Version:        3.33.0
Release:        1%{?dist}
Group:          Development/Libraries
Summary:        Development tools for the sqlite3 embeddable SQL database engine

License:        Public Domain
URL:            http://www.sqlite.org/
Source:         https://www.sqlite.org/src/tarball/sqlite.tar.gz?v=3.33.0
Vendor:         CentOS

ExclusiveArch:  x86_64

BuildRoot:      /tmp/rpmbuild

%description
This package contains the header files and development documentation
for sqlite. If you like to develop programs using sqlite, you will need
to install sqlite-devel.

%install
mkdir -p %{buildroot}/opt/awn/bin
mkdir -p %{buildroot}/opt/awn/usr/include
mkdir -p %{buildroot}/opt/awn/lib64/pkgconfig
mkdir -p %{buildroot}/etc/ld.so.conf.d
cp /bin/sqlite3 %{buildroot}/opt/awn/bin/
cp /usr/include/sqlite3.h %{buildroot}/opt/awn/usr/include/
cp /usr/include/sqlite3ext.h %{buildroot}/opt/awn/usr/include/
cp /lib64/libsqlite3.a %{buildroot}/opt/awn/lib64/
cp /lib64/libsqlite3.la %{buildroot}/opt/awn/lib64/
ln -s /lib64/libsqlite3.so.0.8.6 %{buildroot}/opt/awn/lib64/libsqlite3.so
ln -s /lib64/libsqlite3.so.0.8.6 %{buildroot}/opt/awn/lib64/libsqlite3.so.0
cp /lib64/libsqlite3.so.0.8.6 %{buildroot}/opt/awn/lib64/
cp /lib64/pkgconfig/sqlite3.pc %{buildroot}/opt/awn/lib64/pkgconfig/
cp /ld.so.conf %{buildroot}/etc/ld.so.conf.d/sqlite.conf

%files
/opt/awn/bin/sqlite3
/opt/awn/usr/include/sqlite3.h
/opt/awn/usr/include/sqlite3ext.h
/opt/awn/lib64/libsqlite3.a
/opt/awn/lib64/libsqlite3.la
/opt/awn/lib64/libsqlite3.so
/opt/awn/lib64/libsqlite3.so.0
/opt/awn/lib64/libsqlite3.so.0.8.6
/opt/awn/lib64/pkgconfig/sqlite3.pc
/etc/ld.so.conf.d/sqlite.conf

%changelog
* Wed Aug 5 2020 aschryver Arctic Wolf Network
-
