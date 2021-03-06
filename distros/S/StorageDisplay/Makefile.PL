#
# This file is part of StorageDisplay
#
# This software is copyright (c) 2020 by Vincent Danjean.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.015.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Collect and display storages on linux machines",
  "AUTHOR" => "Vincent Danjean <Vincent.Danjean\@ens-lyon.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "StorageDisplay",
  "EXE_FILES" => [
    "bin/storage2dot"
  ],
  "LICENSE" => "perl",
  "NAME" => "StorageDisplay",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Data::Compare" => 0,
    "Data::Dumper" => 0,
    "Getopt::Long" => 0,
    "IO::Select" => 0,
    "JSON::MaybeXS" => 0,
    "JSON::PP" => 0,
    "Moose" => 0,
    "Moose::Role" => 0,
    "MooseX::NonMoose" => 0,
    "MooseX::Role::Parameterized" => 0,
    "Net::OpenSSH" => 0,
    "Object::ID" => 0,
    "POSIX" => 0,
    "Path::Class::Dir" => 0,
    "Scalar::Util" => 0,
    "Storable" => 0,
    "Term::ReadKey" => 0,
    "bigint" => 0,
    "bignum" => 0,
    "lib" => 0,
    "namespace::sweep" => 0,
    "parent" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Path::Class" => 0,
    "Test2::V0" => 0,
    "Test::File::Contents" => 0,
    "Test::Script" => 0,
    "utf8" => 0
  },
  "VERSION" => "1.0.5",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Data::Compare" => 0,
  "Data::Dumper" => 0,
  "Getopt::Long" => 0,
  "IO::Select" => 0,
  "JSON::MaybeXS" => 0,
  "JSON::PP" => 0,
  "Moose" => 0,
  "Moose::Role" => 0,
  "MooseX::NonMoose" => 0,
  "MooseX::Role::Parameterized" => 0,
  "Net::OpenSSH" => 0,
  "Object::ID" => 0,
  "POSIX" => 0,
  "Path::Class" => 0,
  "Path::Class::Dir" => 0,
  "Scalar::Util" => 0,
  "Storable" => 0,
  "Term::ReadKey" => 0,
  "Test2::V0" => 0,
  "Test::File::Contents" => 0,
  "Test::Script" => 0,
  "bigint" => 0,
  "bignum" => 0,
  "lib" => 0,
  "namespace::sweep" => 0,
  "parent" => 0,
  "strict" => 0,
  "utf8" => 0,
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
