
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.030.
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker;



my %WriteMakefileArgs = (
  "ABSTRACT" => "monkey-patch DBIx::Simple to use SQL::Concrete",
  "AUTHOR" => "Aristotle Pagaltzis <pagaltzis\@gmx.de>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "DBIx-Simple-Concrete",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.006",
  "NAME" => "DBIx::Simple::Concrete",
  "PREREQ_PM" => {
    "DBIx::Simple" => 0,
    "Import::Into" => 0,
    "SQL::Concrete" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Find" => 0,
    "File::Temp" => 0,
    "Test::More" => "0.88",
    "lib" => 0
  },
  "VERSION" => "1.001",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "DBIx::Simple" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Find" => 0,
  "File::Temp" => 0,
  "Import::Into" => 0,
  "SQL::Concrete" => 0,
  "Test::More" => "0.88",
  "lib" => 0,
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



