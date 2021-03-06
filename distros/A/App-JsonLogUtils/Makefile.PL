# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.012.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Command line utilities for dealing with JSON-formatted log files",
  "AUTHOR" => "Jeff Ober <sysread\@fastmail.fm>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "App-JsonLogUtils",
  "EXE_FILES" => [
    "bin/jcols",
    "bin/jcut",
    "bin/jgrep",
    "bin/jshell"
  ],
  "LICENSE" => "perl",
  "NAME" => "App::JsonLogUtils",
  "PREREQ_PM" => {
    "Fcntl" => 0,
    "Getopt::Long" => 0,
    "Iterator::Simple" => 0,
    "JSON::XS" => 0,
    "List::Util" => 0,
    "Pod::Usage" => 0,
    "Term::ReadLine" => 0,
    "Term::SimpleColor" => 0,
    "Time::HiRes" => 0,
    "parent" => 0
  },
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "JSON::XS" => 0,
    "Test2::V0" => 0,
    "Test::More" => 0,
    "Test::Pod" => 0
  },
  "VERSION" => "0.03",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "ExtUtils::MakeMaker" => 0,
  "Fcntl" => 0,
  "File::Spec" => 0,
  "Getopt::Long" => 0,
  "Iterator::Simple" => 0,
  "JSON::XS" => 0,
  "List::Util" => 0,
  "Pod::Usage" => 0,
  "Term::ReadLine" => 0,
  "Term::SimpleColor" => 0,
  "Test2::V0" => 0,
  "Test::More" => 0,
  "Test::Pod" => 0,
  "Time::HiRes" => 0,
  "parent" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
