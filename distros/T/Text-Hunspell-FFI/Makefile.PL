use strict; use warnings;
BEGIN {
  unless(eval q{ use 5.020; 1}) {
    print "Perl 5.020 or better required\n";
    exit;
  }
}
# This file was automatically generated by Dist::Zilla::Plugin::Author::Plicease::MakeMaker v2.03.
use strict;
use warnings;

use 5.020;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Perl FFI interface to the Hunspell library",
  "AUTHOR" => "Graham Ollis <plicease\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Text-Hunspell-FFI",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.020",
  "NAME" => "Text::Hunspell::FFI",
  "PM" => {
    "lib/Text/Hunspell/FFI.pm" => "\$(INST_LIB)/Text/Hunspell/FFI.pm",
    "lib/Text/Hunspell/FFI/Lib.pm" => "\$(INST_LIB)/Text/Hunspell/FFI/Lib.pm"
  },
  "PREREQ_PM" => {
    "FFI::CheckLib" => "0.14",
    "FFI::Platypus" => "0.40",
    "FFI::Platypus::Type::StringArray" => "0.01"
  },
  "TEST_REQUIRES" => {
    "Test::More" => "0.94"
  },
  "VERSION" => "0.02",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "FFI::CheckLib" => "0.14",
  "FFI::Platypus" => "0.40",
  "FFI::Platypus::Type::StringArray" => "0.01",
  "Test::More" => "0.94"
);

# inserted by Dist::Zilla::Plugin::DynamicPrereqs 0.023
if (! eval { use lib 'lib'; require Text::Hunspell::FFI::Lib; scalar Text::Hunspell::FFI::Lib::_libs() }) {
requires('Alien::Hunspell', 0)
}



unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

# inserted by Dist::Zilla::Plugin::DynamicPrereqs 0.023
sub _add_prereq {
  my ($mm_key, $module, $version_or_range) = @_;
  warn "$module already exists in $mm_key -- need to do a sane metamerge!"
    if exists $WriteMakefileArgs{$mm_key}{$module}
      and $WriteMakefileArgs{$mm_key}{$module} ne ($version_or_range || 0);
  warn "$module already exists in FallbackPrereqs -- need to do a sane metamerge!"
    if exists $FallbackPrereqs{$module} and $FallbackPrereqs{$module} ne ($version_or_range || 0);
  $WriteMakefileArgs{$mm_key}{$module} = $FallbackPrereqs{$module} = $version_or_range || 0;
  return;
}

sub requires { goto &runtime_requires }

sub runtime_requires {
  my ($module, $version_or_range) = @_;
  _add_prereq(PREREQ_PM => $module, $version_or_range);
}
