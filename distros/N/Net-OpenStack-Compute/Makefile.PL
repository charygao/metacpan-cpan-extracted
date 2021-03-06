
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.031.
use strict;
use warnings;

use 5.010000;

use ExtUtils::MakeMaker;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Bindings for the OpenStack Compute API.",
  "AUTHOR" => "Naveed Massjouni <naveedm9\@gmail.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Net-OpenStack-Compute",
  "EXE_FILES" => [
    "bin/oscompute"
  ],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010000",
  "NAME" => "Net::OpenStack::Compute",
  "PREREQ_PM" => {
    "App::Rad" => 0,
    "App::Rad::Plugin::MoreHelp" => 0,
    "Carp" => 0,
    "HTTP::Request" => 0,
    "JSON" => 0,
    "LWP" => 0,
    "Moose" => 0,
    "Moose::Role" => 0,
    "Pod::Select" => 0,
    "Test::Most" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => 0,
    "Test::Most" => 0
  },
  "VERSION" => "1.1200",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "App::Rad" => 0,
  "App::Rad::Plugin::MoreHelp" => 0,
  "Carp" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "HTTP::Request" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "JSON" => 0,
  "LWP" => 0,
  "Moose" => 0,
  "Moose::Role" => 0,
  "Pod::Select" => 0,
  "Test::More" => 0,
  "Test::Most" => 0,
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



