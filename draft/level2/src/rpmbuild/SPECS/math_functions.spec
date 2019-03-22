Name:       math-functions
Summary:    Package provides python implementation of factorial and fibonacci.
Version:    1.0
Release:    0%{?dist}
License:    GPLv2
BuildArch:  noarch
Group:      Applications/Math
URL:        https://redhat.com

Source0:    https://redhat.com/%{name}-%{version}.tar.gz

%description
TODO

%prep
%setup -q
%build
%install
install -m 0755 -d $RPM_BUILD_ROOT/$HOME/bin/
install -m 0755 factorial $RPM_BUILD_ROOT/$HOME/bin/factorial
install -m 0755 fibonacci $RPM_BUILD_ROOT/$HOME/bin/fibonacci
echo "$HOME/bin/factorial" > files.lst
echo "$HOME/bin/fibonacci" >> files.lst

# TODO %files
%files -f files.lst


%changelog
* Fri Mar 22 2019 Jakub Heger <jheger@redhat.com> - 1.0.1
- Initial commit
