Name:           perl-Geo-Forward
Version:        0.14
Release:        1%{?dist}
Summary:        Calculate geographic location from latitude, longitude, distance, and heading
License:        Perl
Group:          Development/Libraries
URL:            http://search.cpan.org/dist/Geo-Forward/
Source0:        http://www.cpan.org/CPAN/authors/id/M/MR/MRDVT/Geo-Forward-%{version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch:      noarch
BuildRequires:  perl(ExtUtils::MakeMaker)
BuildRequires:  perl(Geo::Constants) >= 0.04
BuildRequires:  perl(Geo::Ellipsoids) >= 0.09
BuildRequires:  perl(Geo::Functions) >= 0.03
BuildRequires:  perl(Package::New)
BuildRequires:  perl(Test::Simple) >= 0.44
Requires:       perl(Package::New)
Requires:       perl(:MODULE_COMPAT_%(eval "`%{__perl} -V:version`"; echo $version))

%description
This module is a pure Perl port of the NGS program in the public domain
"forward" by Robert (Sid) Safford and Stephen J. Frakes.

%prep
%setup -q -n Geo-Forward-%{version}

%build
%{__perl} Makefile.PL INSTALLDIRS=vendor
make %{?_smp_mflags}

%install
rm -rf $RPM_BUILD_ROOT

make pure_install PERL_INSTALL_ROOT=$RPM_BUILD_ROOT

find $RPM_BUILD_ROOT -type f -name .packlist -exec rm -f {} \;
find $RPM_BUILD_ROOT -depth -type d -exec rmdir {} 2>/dev/null \;

%{_fixperms} $RPM_BUILD_ROOT/*

%check
make test

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%doc Changes LICENSE README
%{perl_vendorlib}/*
%{_mandir}/man3/*

%changelog
* Fri Dec 09 2011 Michael R. Davis (mdavis@stopllc.com) 0.14-1
- Updated for version 0.14

* Fri Dec 09 2011 Michael R. Davis (mdavis@stopllc.com) 0.13-2
- Fixed rpmlint warnings and errors
  - Updated Source URL
  - Spelled out lat and lon
  - Fixed Type-O in change log version
- Added BuildRequires for Package::New

* Fri Dec 09 2011 Michael R. Davis (mdavis@stopllc.com) 0.13-1
- Updated for version 0.13

* Sun Oct 30 2011 Michael R. Davis (mdavis@stopllc.com) 0.12-1
- Specfile autogenerated by cpanspec 1.78.
