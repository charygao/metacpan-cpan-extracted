# This Makefile.PL for  was generated by Dist::Zilla.
# Don't edit it but the dist.ini used to construct it.

use strict;
use warnings;
use ExtUtils::MakeMaker 6.30;

my %WriteMakefileArgs = (
  'ABSTRACT' => 'Invoke perl code at PAM phases',
  'AUTHOR' => 'Jonathan Steinert <hachi@cpan.org>',
  'BUILD_REQUIRES' => {
    'ExtUtils::Constant' => '0',
    'ExtUtils::Embed' => '0',
    'XS::Object::Magic' => '0'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::Depends' => '0',
    'ExtUtils::MakeMaker' => '6.30',
    'XS::Object::Magic' => '0'
  },
  'DISTNAME' => 'PAM',
  'EXE_FILES' => [],
  'LIBS' => [
    '-lpam'
  ],
  'LICENSE' => 'perl',
  'NAME' => 'PAM',
  'PREREQ_PM' => {
    'XS::Object::Magic' => '0'
  },
  'VERSION' => '0.31',
  'clean' => {
    'FILES' => 'perlxsi.c perlxsi.o perl_helper.o perl_helper.so pam_perl.o pam_perl.so const-c.inc const-xs.inc'
  },
  'test' => {
    'TESTS' => 't/*.t'
  }
);

use ExtUtils::Depends;
my $pkg = ExtUtils::Depends->new('PAM', 'XS::Object::Magic');

%WriteMakefileArgs = ($pkg->get_makefile_vars, %WriteMakefileArgs);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

package MY;

sub depend {
    return <<'EOT';
PAM.c : const-xs.inc
$(OBJECT) : const-c.inc
EOT
}

sub postamble {
    my $pam_lib_dir = "/lib/security/";

    $pam_lib_dir = "/usr/lib/pam" if $^O eq 'darwin';

    return "PAM_LIB_DIR = $pam_lib_dir\n" . <<'EOT'
CCOPTS = $(shell $(PERLRUN) -MExtUtils::Embed -e ccopts)
LDOPTS = $(shell $(PERLRUN) -MExtUtils::Embed -e ldopts)

perlxsi.c:
	$(PERLRUN) -MExtUtils::Embed -e xsinit

perlxsi.o: perlxsi.c
	$(CC) $(CCOPTS) $(CCCDLFLAGS) $(OPTIMIZE) "-I$(PERL_INC)" -Wall -c perlxsi.c

perl_helper.o: perl_helper.c
	$(CC) $(CCOPTS) $(CCCDLFLAGS) $(OPTIMIZE) "-I$(PERL_INC)" $(INC) -Wall -c perl_helper.c

perl_helper.so: perl_helper.o perlxsi.o
	$(LD) $(LDOPTS) $(LDDLFLAGS) $(EXTRALIBS) -o perl_helper.so perl_helper.o perlxsi.o

pam_perl.o: pam_perl.c
	$(CC) $(CCOPTS) $(CCCDLFLAGS) $(OPTIMIZE) $(INC) -D'PAM_LIB_DIR="$(PAM_LIB_DIR)"' -Wall -c pam_perl.c

pam_perl.so: pam_perl.o
	$(LD) $(LDOPTS) $(LDDLFLAGS) -o pam_perl.so pam_perl.o

pam: pam_perl.so perl_helper.so

pam-install: pam_perl.so perl_helper.so
	install -o 0 -g 0 pam_perl.so perl_helper.so $(PAM_LIB_DIR)

const-xs.inc const-c.inc :: pm_to_blib
	$(PERLRUN) -MExtUtils::Constant=WriteConstants -Mblib -MPAM::Constants \
		-e 'WriteConstants(NAME => "PAM", NAMES => [ map { { name => $$_, macro => 1 } } @PAM::Constants::EXPORT_OK ])'

all :: pam

install :: pam-install

EOT
}
