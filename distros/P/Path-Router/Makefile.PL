# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.037.
use strict;
use warnings;

use 5.008;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "A tool for routing paths",
  "AUTHOR" => "Stevan Little <stevan\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Path-Router",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.008",
  "NAME" => "Path::Router",
  "PREREQ_PM" => {
    "B" => 0,
    "Carp" => "1.32",
    "Clone::PP" => "1.04",
    "Data::Dumper" => "2.154",
    "Eval::Closure" => "0.13",
    "File::Spec::Unix" => "3.40",
    "Moo" => "2.000001",
    "Sub::Exporter" => "0.981",
    "Term::ReadLine" => "1.11",
    "Test::Builder" => "1.001013",
    "Test::Deep" => "0.113",
    "Try::Tiny" => "0.19",
    "Type::Tiny" => "1.000005",
    "Types::Standard" => "1.000005",
    "constant" => "1.24",
    "namespace::clean" => "0.23"
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::Fatal" => "0.012",
    "Test::More" => "1.001013"
  },
  "VERSION" => "0.15",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "B" => 0,
  "Carp" => "1.32",
  "Clone::PP" => "1.04",
  "Data::Dumper" => "2.154",
  "Eval::Closure" => "0.13",
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "File::Spec::Unix" => "3.40",
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Moo" => "2.000001",
  "Sub::Exporter" => "0.981",
  "Term::ReadLine" => "1.11",
  "Test::Builder" => "1.001013",
  "Test::Deep" => "0.113",
  "Test::Fatal" => "0.012",
  "Test::More" => "1.001013",
  "Try::Tiny" => "0.19",
  "Type::Tiny" => "1.000005",
  "Types::Standard" => "1.000005",
  "constant" => "1.24",
  "namespace::clean" => "0.23"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
