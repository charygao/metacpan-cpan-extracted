# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.008.
use strict;
use warnings;

use 5.008005;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Box up imports into an object or unified function.",
  "AUTHOR" => "Chad Granum <exodist\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Import-Box",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.008005",
  "NAME" => "Import::Box",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Scalar::Util" => 0
  },
  "TEST_REQUIRES" => {
    "Test2::Suite" => "0.000060"
  },
  "VERSION" => "0.001",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Scalar::Util" => 0,
  "Test2::Suite" => "0.000060"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
