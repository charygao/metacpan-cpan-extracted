# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.012.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Module to help build the Perl Kubernetes client",
  "AUTHOR" => "Jose Luis Martinez <jlmartinez\@capside.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "KubeBuilder",
  "LICENSE" => "apache",
  "NAME" => "KubeBuilder",
  "PREREQ_PM" => {
    "Moose" => 0,
    "Path::Class" => 0,
    "Swagger::Schema::Kubernetes" => 0,
    "Template" => 0
  },
  "VERSION" => "0.02",
  "test" => {
    "TESTS" => ""
  }
);


my %FallbackPrereqs = (
  "Moose" => 0,
  "Path::Class" => 0,
  "Swagger::Schema::Kubernetes" => 0,
  "Template" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
