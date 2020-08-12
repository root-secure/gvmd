Name:           gvmd
Version:        8.0.2
Release:        1%{?dist}
Group:          Unspecified
Summary:        Manager Module for the Open Vulnerability Assessment System (OpenVAS)

License:        GPLv2+
URL:            http://www.openvas.org
Source:         https://github.com/greenbone/gvmd/archive/v8.0.2.tar.gz
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
mkdir -p %{buildroot}/var/lib/gvm/gvmd
mkdir -p %{buildroot}/bin/
mkdir -p %{buildroot}/etc/gvm/
mkdir -p %{buildroot}/sbin/
mkdir -p %{buildroot}/share/doc/gvm/
mkdir -p %{buildroot}/share/gvm/
mkdir -p %{buildroot}/share/man/
mkdir -p %{buildroot}/share/man/man1/
mkdir -p %{buildroot}/share/man/man8/
cp /bin/gvm-manage-certs %{buildroot}/bin/
cp /etc/gvm/*.conf %{buildroot}/etc/gvm/
cp /sbin/database-statistics-sqlite %{buildroot}/sbin/
cp /sbin/greenbone-* %{buildroot}/sbin/
cp /sbin/gvm-* %{buildroot}/sbin/
cp /sbin/gvmd-sqlite %{buildroot}/sbin/
ln -s /sbin/gvmd-sqlite %{buildroot}/sbin/gvmd
cp /share/doc/gvm/* %{buildroot}/share/doc/gvm/
cp -r /share/gvm/* %{buildroot}/share/gvm/
cp /share/man/man1/gvm-manage-certs.1 %{buildroot}/share/man/man1/
cp /share/man/man8/database-statistics-sqlite.8 %{buildroot}/share/man/man8/
cp /share/man/man8/greenbone-*.8 %{buildroot}/share/man/man8/
cp /share/man/man8/gvm-*.8 %{buildroot}/share/man/man8/
cp /share/man/man8/gvmd.8 %{buildroot}/share/man/man8/

%files
/var/lib/gvm/gvmd
/etc/gvm/gvmd_log.conf
/etc/gvm/pwpolicy.conf
/share/gvm/gvmd/report_formats/5057e5cc-b825-11e4-9d0e-28d24461215b/report_format.xml
/share/gvm/gvmd/report_formats/5057e5cc-b825-11e4-9d0e-28d24461215b/Anonymous_XML.xsl
/share/gvm/gvmd/report_formats/5057e5cc-b825-11e4-9d0e-28d24461215b/generate
/share/gvm/gvmd/report_formats/910200ca-dc05-11e1-954f-406186ea4fc5/report_format.xml
/share/gvm/gvmd/report_formats/910200ca-dc05-11e1-954f-406186ea4fc5/ARF.xsl
/share/gvm/gvmd/report_formats/910200ca-dc05-11e1-954f-406186ea4fc5/generate
/share/gvm/gvmd/report_formats/5ceff8ba-1f62-11e1-ab9f-406186ea4fc5/report_format.xml
/share/gvm/gvmd/report_formats/5ceff8ba-1f62-11e1-ab9f-406186ea4fc5/CPE.xsl
/share/gvm/gvmd/report_formats/5ceff8ba-1f62-11e1-ab9f-406186ea4fc5/generate
/share/gvm/gvmd/report_formats/c1645568-627a-11e3-a660-406186ea4fc5/report_format.xml
/share/gvm/gvmd/report_formats/c1645568-627a-11e3-a660-406186ea4fc5/CSV_Results.xsl
/share/gvm/gvmd/report_formats/c1645568-627a-11e3-a660-406186ea4fc5/generate
/share/gvm/gvmd/report_formats/9087b18c-626c-11e3-8892-406186ea4fc5/report_format.xml
/share/gvm/gvmd/report_formats/9087b18c-626c-11e3-8892-406186ea4fc5/CSV_Hosts.xsl
/share/gvm/gvmd/report_formats/9087b18c-626c-11e3-8892-406186ea4fc5/generate
/share/gvm/gvmd/report_formats/77bd6c4a-1f62-11e1-abf0-406186ea4fc5/report_format.xml
/share/gvm/gvmd/report_formats/77bd6c4a-1f62-11e1-abf0-406186ea4fc5/ITG.xsl
/share/gvm/gvmd/report_formats/77bd6c4a-1f62-11e1-abf0-406186ea4fc5/generate
/share/gvm/gvmd/report_formats/a684c02c-b531-11e1-bdc2-406186ea4fc5/report_format.xml
/share/gvm/gvmd/report_formats/a684c02c-b531-11e1-bdc2-406186ea4fc5/latex.xsl
/share/gvm/gvmd/report_formats/a684c02c-b531-11e1-bdc2-406186ea4fc5/generate
/share/gvm/gvmd/report_formats/9ca6fe72-1f62-11e1-9e7c-406186ea4fc5/report_format.xml
/share/gvm/gvmd/report_formats/9ca6fe72-1f62-11e1-9e7c-406186ea4fc5/NBE.xsl
/share/gvm/gvmd/report_formats/9ca6fe72-1f62-11e1-9e7c-406186ea4fc5/generate
/share/gvm/gvmd/report_formats/c402cc3e-b531-11e1-9163-406186ea4fc5/latex.xsl
/share/gvm/gvmd/report_formats/c402cc3e-b531-11e1-9163-406186ea4fc5/report_format.xml
/share/gvm/gvmd/report_formats/c402cc3e-b531-11e1-9163-406186ea4fc5/generate
/share/gvm/gvmd/report_formats/9e5e5deb-879e-4ecc-8be6-a71cd0875cdd/report_format.xml
/share/gvm/gvmd/report_formats/9e5e5deb-879e-4ecc-8be6-a71cd0875cdd/hostvisdot-summary.xsl
/share/gvm/gvmd/report_formats/9e5e5deb-879e-4ecc-8be6-a71cd0875cdd/generate
/share/gvm/gvmd/report_formats/a3810a62-1f62-11e1-9219-406186ea4fc5/report_format.xml
/share/gvm/gvmd/report_formats/a3810a62-1f62-11e1-9219-406186ea4fc5/TXT.xsl
/share/gvm/gvmd/report_formats/a3810a62-1f62-11e1-9219-406186ea4fc5/generate
/share/gvm/gvmd/report_formats/a994b278-1f62-11e1-96ac-406186ea4fc5/report_format.xml
/share/gvm/gvmd/report_formats/a994b278-1f62-11e1-96ac-406186ea4fc5/generate
/share/gvm/gvmd/report_formats/c15ad349-bd8d-457a-880a-c7056532ee15/report_format.xml
/share/gvm/gvmd/report_formats/c15ad349-bd8d-457a-880a-c7056532ee15/Verinice_ISM.xsl
/share/gvm/gvmd/report_formats/c15ad349-bd8d-457a-880a-c7056532ee15/classification.xsl
/share/gvm/gvmd/report_formats/c15ad349-bd8d-457a-880a-c7056532ee15/generate
/share/gvm/gvmd/report_formats/50c9950a-f326-11e4-800c-28d24461215b/report_format.xml
/share/gvm/gvmd/report_formats/50c9950a-f326-11e4-800c-28d24461215b/Verinice_ITG.xsl
/share/gvm/gvmd/report_formats/50c9950a-f326-11e4-800c-28d24461215b/classification-helpers.xsl
/share/gvm/gvmd/report_formats/50c9950a-f326-11e4-800c-28d24461215b/generate
/share/gvm/gvmd/global_schema_formats/02052818-dab6-11df-9be4-002264764cea/rnc.2.xsl
/share/gvm/gvmd/global_schema_formats/02052818-dab6-11df-9be4-002264764cea/HTML.xsl
/share/gvm/gvmd/global_schema_formats/02052818-dab6-11df-9be4-002264764cea/generate
/share/gvm/gvmd/global_schema_formats/787a4a18-dabc-11df-9486-002264764cea/rnc.2.xsl
/share/gvm/gvmd/global_schema_formats/787a4a18-dabc-11df-9486-002264764cea/rnc.1.xsl
/share/gvm/gvmd/global_schema_formats/787a4a18-dabc-11df-9486-002264764cea/generate
/share/gvm/gvmd/global_schema_formats/18e826fc-dab6-11df-b913-002264764cea/GMP.xml
/share/gvm/gvmd/global_schema_formats/18e826fc-dab6-11df-b913-002264764cea/generate
/share/gvm/gvmd/global_schema_formats/d6cf255e-947c-11e1-829a-406186ea4fc5/GMP.xsl
/share/gvm/gvmd/global_schema_formats/d6cf255e-947c-11e1-829a-406186ea4fc5/generate
/share/gvm/gvmd/global_alert_methods/2db07698-ec49-11e5-bcff-28d24461215b/alert
/share/gvm/gvmd/global_alert_methods/4a398d42-87c0-11e5-a1c0-28d24461215b/alert
/share/gvm/gvmd/global_alert_methods/c427a688-b653-40ab-a9d0-d6ba842a9d63/alert
/share/gvm/gvmd/global_alert_methods/9d435134-15d3-11e6-bf5c-28d24461215b/alert
/share/gvm/gvmd/global_alert_methods/cd1f5a34-6bdc-11e0-9827-002264764cea/alert
/share/gvm/gvmd/global_alert_methods/5b39c481-9137-4876-b734-263849dd96ce/alert
/share/gvm/gvmd/global_alert_methods/5b39c481-9137-4876-b734-263849dd96ce/report-convert.py
/share/gvm/gvmd/global_alert_methods/5b39c481-9137-4876-b734-263849dd96ce/report-convert.pyc
/share/gvm/gvmd/global_alert_methods/5b39c481-9137-4876-b734-263849dd96ce/report-convert.pyo
/share/gvm/gvmd/global_alert_methods/f9d97653-f89b-41af-9ba1-0f6ee00e9c1a/alert
/share/gvm/gvmd/global_alert_methods/159f79a5-fce8-4ec5-aa49-7d17a77739a3/alert
/share/gvm/gvmd/wizards/quick_first_scan.xml
/share/gvm/gvmd/wizards/get_tasks_deep.xml
/share/gvm/gvmd/wizards/delete_task_deep.xml
/share/gvm/gvmd/wizards/quick_auth_scan.xml
/share/gvm/gvmd/wizards/quick_task.xml
/share/gvm/gvmd/wizards/reset_task.xml
/share/gvm/gvmd/wizards/modify_task.xml
/share/gvm/gvmd/portnames_update.xsl
/share/gvm/scap/cpe_getbyname.xsl
/share/gvm/scap/cve_getbyname.xsl
/share/gvm/scap/ovaldef_getbyname.xsl
/share/gvm/cert/cert_bund_getbyname.xsl
/share/gvm/cert/dfn_cert_getbyname.xsl
/sbin/gvm-portnames-update
/sbin/greenbone-scapdata-sync
/sbin/greenbone-certdata-sync
/share/gvm/gvm-lsc-deb-creator.sh
/share/gvm/gvm-lsc-rpm-creator.sh
/sbin/gvm-migrate-to-postgres
/sbin/database-statistics-sqlite
/bin/gvm-manage-certs
/share/man/man1/gvm-manage-certs.1
/share/doc/gvm/example-gvm-manage-certs.conf
/sbin/gvmd-sqlite
/sbin/gvmd
/share/man/man8/gvmd.8
/share/man/man8/greenbone-certdata-sync.8
/share/man/man8/greenbone-scapdata-sync.8
/share/man/man8/database-statistics-sqlite.8
/share/man/man8/gvm-migrate-to-postgres.8
/share/man/man8/gvm-portnames-update.8

%changelog
* Wed Aug 5 2020 aschryver Arctic Wolf Networks
-
