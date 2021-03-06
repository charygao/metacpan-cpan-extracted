
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.021.
use strict;
use warnings;

use 5.010;

use ExtUtils::MakeMaker;



my %WriteMakefileArgs = (
  "ABSTRACT" => "NHANES 2000 Growth Charts",
  "AUTHOR" => "Charles Bailey <cbail\@cpan.org>",
  "BUILD_REQUIRES" => {
    "Module::Build" => "0.28"
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "Module::Build" => "0.28"
  },
  "DISTNAME" => "Medical-Growth-NHANES_2000",
  "EXE_FILES" => [],
  "LICENSE" => "open_source",
  "MIN_PERL_VERSION" => "5.010",
  "NAME" => "Medical::Growth::NHANES_2000",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Exporter" => 0,
    "Medical::Growth::Base" => 0,
    "Module::Pluggable" => 0,
    "Module::Runtime" => 0,
    "Moo::Lax" => 0,
    "Scalar::Util" => 0,
    "Statistics::Standard_Normal" => 0,
    "if" => 0,
    "namespace::clean" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "FindBin" => 0,
    "Test::More" => 0,
    "lib" => 0
  },
  "VERSION" => "1.10",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Exporter" => 0,
  "ExtUtils::MakeMaker" => 0,
  "FindBin" => 0,
  "Medical::Growth::Base" => 0,
  "Module::Build" => "0.28",
  "Module::Pluggable" => 0,
  "Module::Runtime" => 0,
  "Moo::Lax" => 0,
  "Scalar::Util" => 0,
  "Statistics::Standard_Normal" => 0,
  "Test::More" => 0,
  "if" => 0,
  "lib" => 0,
  "namespace::clean" => 0,
  "strict" => 0,
  "warnings" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



