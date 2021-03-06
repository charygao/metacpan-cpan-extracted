# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.009.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "a summarizer for Plack::Request objects",
  "AUTHOR" => "Matthew Horsfall (alh) <wolfsage\@gmail.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Exception-Reporter-Summarizer-PlackRequest",
  "LICENSE" => "perl",
  "NAME" => "Exception::Reporter::Summarizer::PlackRequest",
  "PREREQ_PM" => {
    "Exception::Reporter::Summarizer" => 0,
    "Plack::Request" => 0,
    "Try::Tiny" => 0,
    "parent" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "Test::More" => "0.96"
  },
  "VERSION" => "0.001",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Exception::Reporter::Summarizer" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "Plack::Request" => 0,
  "Test::More" => "0.96",
  "Try::Tiny" => 0,
  "parent" => 0,
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
