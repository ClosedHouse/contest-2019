Name:       math-functions
Summary:    Package provides python implementation of factorial and fibonacci.
Version:    1.1
Release:    0%{?dist}
License:    GPLv2
BuildArch:  noarch
Group:      Applications/Math
URL:        https://redhat.com
Requires:   python3

Source0:    https://redhat.com/%{name}-%{version}.tar.gz

%description
TODO

%prep
%setup -q
%build
%install
install -m 0755 -d $RPM_BUILD_ROOT/bin/
install -m 0755 factorial $RPM_BUILD_ROOT/bin/factorial
install -m 0755 fibonacci $RPM_BUILD_ROOT/bin/fibonacci
echo "/bin/factorial" > files.lst
echo "/bin/fibonacci" >> files.lst

# TODO %files
%files -f files.lst


%changelog
* Thu Mar 28 2019 Jakub Heger <jheger@redhat.com> - 1.1.0
- Input validation

* Fri Mar 22 2019 Jakub Heger <jheger@redhat.com> - 1.0.0
- Initial commit
