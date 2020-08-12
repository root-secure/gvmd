Name:           openvas-manager
Version:        8.0.2
Release:        1%{?dist}
Group:          Unspecified
Summary:        Manager Module for the Open Vulnerability Assessment System (OpenVAS)

License:        GPLv2+
URL:            http://www.openvas.org
Source:         https://github.com/root-secure/gvmd/tree/awn-gvmd-8.0
Vendor:         Greenbone https://www.greenbone.net

ExclusiveArch:  x86_64

BuildRoot:      /tmp/rpmbuild

%description
The Greenbone Vulnerability Manager is the central management service between
security scanners and the user clients.
.
It manages the storage of any vulnerability management configurations and of
the scan results.

%install
mkdir -p %{buildroot}/etc/logrotate.d/
mkdir -p %{buildroot}/etc/systemd/system/multi-user.target.wants/
cp /etc/logrotate.d/openvas-manager %{buildroot}/etc/logrotate.d/
cp /etc/systemd/system/multi-user.target.wants/openvas-manager.service %{buildroot}/etc/systemd/system/multi-user.target.wants/

%files
/etc/logrotate.d/openvas-manager
/etc/systemd/system/multi-user.target.wants/openvas-manager.service

%changelog
* Wed Aug 5 2020 aschryver Arctic Wolf Network
-
