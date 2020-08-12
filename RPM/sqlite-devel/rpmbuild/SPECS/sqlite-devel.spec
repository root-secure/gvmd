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
mkdir %{buildroot}/bin
mkdir -p %{buildroot}/usr/include
mkdir -p %{buildroot}/lib64/pkgconfig
cp /bin/sqlite3 %{buildroot}/bin/
cp /usr/include/sqlite3.h %{buildroot}/usr/include/
cp /usr/include/sqlite3ext.h %{buildroot}/usr/include/
cp /lib64/libsqlite3.a %{buildroot}/lib64/
cp /lib64/libsqlite3.la %{buildroot}/lib64/
ln -s /lib64/libsqlite3.so.0.8.6 %{buildroot}/lib64/libsqlite3.so
ln -s /lib64/libsqlite3.so.0.8.6 %{buildroot}/lib64/libsqlite3.so.0
cp /lib64/libsqlite3.so.0.8.6 %{buildroot}/lib64/
cp /lib64/pkgconfig/sqlite3.pc %{buildroot}/lib64/pkgconfig/

%files
/bin/sqlite3
/usr/include/sqlite3.h
/usr/include/sqlite3ext.h
/lib64/libsqlite3.a
/lib64/libsqlite3.la
/lib64/libsqlite3.so
/lib64/libsqlite3.so.0
/lib64/libsqlite3.so.0.8.6
/lib64/pkgconfig/sqlite3.pc

%changelog
* Wed Aug 5 2020 aschryver Arctic Wolf Network
-
