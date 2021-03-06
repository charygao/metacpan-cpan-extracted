# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.005.
use strict;
use warnings;

use 5.014;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Basis for simple applications",
  "AUTHOR" => "Kevin Mulholland <moodfarm\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "App-Basis",
  "EXE_FILES" => [
    "bin/appbasis"
  ],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.014",
  "NAME" => "App::Basis",
  "PREREQ_PM" => {
    "Digest::MD5" => 0,
    "Exporter" => 0,
    "File::HomeDir" => 0,
    "Getopt::Long" => 0,
    "IPC::Cmd" => 0,
    "List::Util" => 0,
    "Moo" => 0,
    "POSIX" => 0,
    "Path::Tiny" => 0,
    "Try::Tiny" => 0,
    "YAML::Tiny::Color" => 0,
    "YAML::XS" => 0,
    "strict" => 0,
    "utf8::all" => 0,
    "vars" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Test::More" => 0
  },
  "VERSION" => "1.2",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Digest::MD5" => 0,
  "Exporter" => 0,
  "File::HomeDir" => 0,
  "Getopt::Long" => 0,
  "IPC::Cmd" => 0,
  "List::Util" => 0,
  "Moo" => 0,
  "POSIX" => 0,
  "Path::Tiny" => 0,
  "Test::More" => 0,
  "Try::Tiny" => 0,
  "YAML::Tiny::Color" => 0,
  "YAML::XS" => 0,
  "strict" => 0,
  "utf8::all" => 0,
  "vars" => 0,
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
