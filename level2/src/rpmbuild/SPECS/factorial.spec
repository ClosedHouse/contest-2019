Name:       factorial
Summary:    Python implementation of factorial.
Version:    1.1
Release:    1%{?dist}
License:    GPLv2
BuildArch:  noarch
Group:      Applications/Math
URL:        https://redhat.com
Requires:   python3

Source0:    https://redhat.com/%{name}-%{version}.tar.gz

%description
Package provides python script which counts factorial.

%prep
%setup -q
%build
%install
install -m 0755 -d $RPM_BUILD_ROOT/bin/
install -m 0755 factorial $RPM_BUILD_ROOT/bin/factorial

%files
/bin/factorial

%changelog
* Fri Apr 05 2019 Jakub Heger <jheger@redhat.com> - 1.1.1
- Input validation

* Fri Mar 22 2019 Jakub Heger <jheger@redhat.com> - 1.0.1
- Initial commit
