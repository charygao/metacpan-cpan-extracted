Name:           perl-perfSONAR_PS-Services-MA-CircuitStatus
Version:        0.08
Release:        1%{?dist}
Summary:        perfSONAR_PS::Services::MA::CircuitStatus Perl module
License:        distributable, see LICENSE
Group:          Development/Libraries
URL:            http://search.cpan.org/dist/perfSONAR_PS-Services-MA-CircuitStatus/
Source0:        http://www.cpan.org/modules/by-module/perfSONAR_PS/perfSONAR_PS-Services-MA-CircuitStatus-%{version}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch:      noarch
Requires:       perl(Log::Log4perl) >= 1
Requires:       perl(Params::Validate) >= 0.64
Requires:       perl(perfSONAR_PS::Client::LS::Remote) >= 0.08
Requires:       perl(perfSONAR_PS::Client::Status::SQL) >= 0.08
Requires:       perl(perfSONAR_PS::Common) >= 0.08
Requires:       perl(perfSONAR_PS::Messages) >= 0.08
Requires:       perl(perfSONAR_PS::Services::Base) >= 0.08
Requires:       perl(perfSONAR_PS::Time) >= 0.08
Requires:       perl(perfSONAR_PS::Topology::ID) >= 0.08
Requires:       perl(:MODULE_COMPAT_%(eval "`%{__perl} -V:version`"; echo $version))

%description
perl Makefile.PL make make install

%prep
%setup -q -n perfSONAR_PS-Services-MA-CircuitStatus-%{version}

%build
%{__perl} Makefile.PL INSTALLDIRS=vendor
make %{?_smp_mflags}

%install
rm -rf $RPM_BUILD_ROOT

make pure_install PERL_INSTALL_ROOT=$RPM_BUILD_ROOT

find $RPM_BUILD_ROOT -type f -name .packlist -exec rm -f {} \;
find $RPM_BUILD_ROOT -type d -depth -exec rmdir {} 2>/dev/null \;

chmod -R u+rwX,go+rX,go-w $RPM_BUILD_ROOT/*

%check
make test

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%doc Changes LICENSE README perl-perfSONAR_PS-Services-MA-CircuitStatus.spec
%{perl_vendorlib}/*
%{_mandir}/man3/*

%changelog
* Mon Mar 10 2008 aaron@internet2.edu 0.08-1
- Specfile autogenerated.
