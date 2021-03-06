# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.012.
use strict;
use warnings;

use 5.024;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Bulk Load for Postgres with ability to skip bad records.",
  "AUTHOR" => "John Karr <brainbuz\@brainbuz.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Pg-BulkLoad",
  "LICENSE" => "gpl",
  "MIN_PERL_VERSION" => "5.024",
  "NAME" => "Pg::BulkLoad",
  "PREREQ_PM" => {
    "Carp" => 0,
    "DBD::Pg" => "3.5.3",
    "DBI" => 0,
    "Data::Dumper" => 0,
    "Data::Printer" => 0,
    "Path::Tiny" => "0.100",
    "Try::Tiny" => "0.30",
    "feature" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Data::Printer" => 0,
    "Mojo::Pg" => "4.10",
    "Test::Exception" => 0,
    "Test::MockObject" => 0,
    "Test::More" => 0
  },
  "VERSION" => "2.031",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "DBD::Pg" => "3.5.3",
  "DBI" => 0,
  "Data::Dumper" => 0,
  "Data::Printer" => 0,
  "Mojo::Pg" => "4.10",
  "Path::Tiny" => "0.100",
  "Test::Exception" => 0,
  "Test::MockObject" => 0,
  "Test::More" => 0,
  "Try::Tiny" => "0.30",
  "feature" => 0,
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
