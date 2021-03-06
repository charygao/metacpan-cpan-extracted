# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.010.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "no-frills file rotation",
  "AUTHOR" => "Robert Rothenberg <rrwo\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "File-Rotate-Simple",
  "LICENSE" => "artistic_2",
  "NAME" => "File::Rotate::Simple",
  "PREREQ_PM" => {
    "Graph" => 0,
    "List::Util" => "1.43",
    "Module::Runtime" => 0,
    "Moo" => "1.001000",
    "Path::Tiny" => "0.018",
    "Ref::Util" => 0,
    "Time::Seconds" => 0,
    "Types::Standard" => 0,
    "namespace::autoclean" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "Module::Metadata" => 0,
    "Path::Tiny" => "0.018",
    "Test::More" => "0.99",
    "Test::Most" => 0,
    "Time::Piece" => 0
  },
  "VERSION" => "v0.2.4",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "File::Spec" => 0,
  "Graph" => 0,
  "List::Util" => "1.43",
  "Module::Metadata" => 0,
  "Module::Runtime" => 0,
  "Moo" => "1.001000",
  "Path::Tiny" => "0.018",
  "Ref::Util" => 0,
  "Test::More" => "0.99",
  "Test::Most" => 0,
  "Time::Piece" => 0,
  "Time::Seconds" => 0,
  "Types::Standard" => 0,
  "namespace::autoclean" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
