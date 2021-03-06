# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.008.
use strict;
use warnings;

use 5.008000;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Inflators to serialize data structures for DBIx::Class",
  "AUTHOR" => "Jose Luis Martinez (jlmartinez\@capside.com)",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "DBIx-Class-InflateColumn-Serializer",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.008000",
  "NAME" => "DBIx::Class::InflateColumn::Serializer",
  "PREREQ_PM" => {
    "DBIx::Class" => 0,
    "JSON::MaybeXS" => "1.002005",
    "YAML" => 0,
    "namespace::clean" => 0
  },
  "TEST_REQUIRES" => {
    "DBD::SQLite" => 0,
    "Test::Exception" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.09",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "DBD::SQLite" => 0,
  "DBIx::Class" => 0,
  "JSON::MaybeXS" => "1.002005",
  "Test::Exception" => 0,
  "Test::More" => 0,
  "YAML" => 0,
  "namespace::clean" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
