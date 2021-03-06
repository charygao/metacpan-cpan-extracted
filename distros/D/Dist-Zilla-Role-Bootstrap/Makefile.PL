# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.008.
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Shared logic for bootstrap things.",
  "AUTHOR" => "Kent Fredric <kentnl\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Dist-Zilla-Role-Bootstrap",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.006",
  "NAME" => "Dist::Zilla::Role::Bootstrap",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Dist::Zilla::Role::Plugin" => 0,
    "List::UtilsBy" => 0,
    "Moose::Role" => 0,
    "Path::Tiny" => 0,
    "lib" => 0,
    "strict" => 0,
    "version" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Dist::Zilla::Chrome::Test" => 0,
    "Dist::Zilla::Dist::Builder" => 0,
    "Dist::Zilla::MVP::Assembler::Zilla" => 0,
    "Dist::Zilla::MVP::Section" => 0,
    "ExtUtils::MakeMaker" => 0,
    "File::Copy::Recursive" => 0,
    "File::Spec" => 0,
    "FindBin" => 0,
    "Moose" => 0,
    "Test::More" => 0
  },
  "VERSION" => "1.001004",
  "test" => {
    "TESTS" => "t/*.t t/00-compile/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Dist::Zilla::Chrome::Test" => 0,
  "Dist::Zilla::Dist::Builder" => 0,
  "Dist::Zilla::MVP::Assembler::Zilla" => 0,
  "Dist::Zilla::MVP::Section" => 0,
  "Dist::Zilla::Role::Plugin" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Copy::Recursive" => 0,
  "File::Spec" => 0,
  "FindBin" => 0,
  "List::UtilsBy" => 0,
  "Moose" => 0,
  "Moose::Role" => 0,
  "Path::Tiny" => 0,
  "Test::More" => 0,
  "lib" => 0,
  "strict" => 0,
  "version" => 0,
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
