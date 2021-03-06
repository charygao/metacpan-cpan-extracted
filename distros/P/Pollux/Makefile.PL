# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.043.
use strict;
use warnings;

use 5.020000;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Redux-like store",
  "AUTHOR" => "Yanick Champoux <yanick\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Pollux",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.020000",
  "NAME" => "Pollux",
  "PREREQ_PM" => {
    "Clone" => 0,
    "Const::Fast" => 0,
    "Hash::Merge" => 0,
    "List::AllUtils" => 0,
    "List::MoreUtils" => 0,
    "Moo" => 0,
    "Moose" => 0,
    "Moose::Exporter" => 0,
    "MooseX::MungeHas" => 0,
    "Scalar::Util" => 0,
    "Type::Tiny" => 0,
    "Types::Standard" => 0,
    "experimental" => 0,
    "overload" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::Exception" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.0.2",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Clone" => 0,
  "Const::Fast" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "Hash::Merge" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "List::AllUtils" => 0,
  "List::MoreUtils" => 0,
  "Moo" => 0,
  "Moose" => 0,
  "Moose::Exporter" => 0,
  "MooseX::MungeHas" => 0,
  "Scalar::Util" => 0,
  "Test::Exception" => 0,
  "Test::More" => 0,
  "Type::Tiny" => 0,
  "Types::Standard" => 0,
  "experimental" => 0,
  "overload" => 0,
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
