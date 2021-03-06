
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.012.
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "break up numbers into arbitrary denominations",
  "AUTHOR" => "Zoffix Znet <cpan\@zoffix.com>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Number-Denominal",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Number::Denominal",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Exporter" => 0,
    "List::ToHumanString" => "1.002",
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::Deep" => 0,
    "Test::More" => 0
  },
  "VERSION" => "2.001001",
  "test" => {
    "TESTS" => "t/*.t t/regression/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Exporter" => 0,
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "List::ToHumanString" => "1.002",
  "Test::Deep" => 0,
  "Test::More" => 0,
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



