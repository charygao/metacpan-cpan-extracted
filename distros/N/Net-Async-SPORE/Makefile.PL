
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.020.
use strict;
use warnings;

use 5.010001;

use ExtUtils::MakeMaker 6.48;



my %WriteMakefileArgs = (
  "ABSTRACT" => "IO::Async support for SPORE REST definitions",
  "AUTHOR" => "Tom Molesworth <cpan\@perlsite.co.uk>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.48"
  },
  "DISTNAME" => "Net-Async-SPORE",
  "EXE_FILES" => [
    "bin/spore"
  ],
  "LICENSE" => "perl",
  "NAME" => "Net::Async::SPORE",
  "PREREQ_PM" => {
    "File::Spec" => 0,
    "Future" => "0.29",
    "JSON::MaybeXS" => 0,
    "Net::Async::HTTP" => "0.35",
    "URI" => 0,
    "URI::Escape" => 0,
    "URI::QueryParam" => 0,
    "curry" => 0,
    "parent" => 0
  },
  "TEST_REQUIRES" => {
    "Dir::Self" => 0,
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::CheckDeps" => "0.010",
    "Test::Fatal" => "0.010",
    "Test::More" => "0.98"
  },
  "VERSION" => "0.003",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Dir::Self" => 0,
  "File::Spec" => 0,
  "Future" => "0.29",
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "JSON::MaybeXS" => 0,
  "Net::Async::HTTP" => "0.35",
  "Test::CheckDeps" => "0.010",
  "Test::Fatal" => "0.010",
  "Test::More" => "0.98",
  "URI" => 0,
  "URI::Escape" => 0,
  "URI::QueryParam" => 0,
  "curry" => 0,
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



