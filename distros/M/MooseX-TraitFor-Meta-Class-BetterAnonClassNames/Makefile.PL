#
# This file is part of MooseX-TraitFor-Meta-Class-BetterAnonClassNames
#
# This software is Copyright (c) 2014 by Chris Weyl.
#
# This is free software, licensed under:
#
#   The GNU Lesser General Public License, Version 2.1, February 1999
#
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.009.
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Metaclass trait to *attempt* to demystify generated anonymous class names",
  "AUTHOR" => "Chris Weyl <cweyl\@alumni.drew.edu>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "MooseX-TraitFor-Meta-Class-BetterAnonClassNames",
  "LICENSE" => "lgpl",
  "MIN_PERL_VERSION" => "5.006",
  "NAME" => "MooseX::TraitFor::Meta::Class::BetterAnonClassNames",
  "PREREQ_PM" => {
    "Moose::Exporter" => 0,
    "Moose::Role" => 0,
    "autobox::Core" => 0,
    "namespace::autoclean" => 0
  },
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Moose" => 0,
    "Moose::Util::MetaRole" => 0,
    "Test::CheckDeps" => "0.010",
    "Test::Moose::More" => 0,
    "Test::More" => "0.94",
    "blib" => "1.01",
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.002003",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Moose" => 0,
  "Moose::Exporter" => 0,
  "Moose::Role" => 0,
  "Moose::Util::MetaRole" => 0,
  "Test::CheckDeps" => "0.010",
  "Test::Moose::More" => 0,
  "Test::More" => "0.94",
  "autobox::Core" => 0,
  "blib" => "1.01",
  "namespace::autoclean" => 0,
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
