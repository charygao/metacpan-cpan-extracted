# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.015.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "miscellaneous methods for analyzing a DOM",
  "AUTHOR" => "Steve Dondley <s\@dondley.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Mojo-DOM-Role-Analyzer",
  "LICENSE" => "perl",
  "NAME" => "Mojo::DOM::Role::Analyzer",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Class::Method::Modifiers" => 0,
    "Mojolicious" => "7.42",
    "Role::Tiny" => 0,
    "overload" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Mojo::DOM" => 0,
    "Path::Tiny" => 0,
    "Test::More" => 0,
    "Test::Most" => 0
  },
  "VERSION" => "0.015",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Class::Method::Modifiers" => 0,
  "Mojo::DOM" => 0,
  "Mojolicious" => "7.42",
  "Path::Tiny" => 0,
  "Role::Tiny" => 0,
  "Test::More" => 0,
  "Test::Most" => 0,
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
