# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.015.
use strict;
use warnings;

use 5.010000;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "A lightweight StatsD client that supports multimetric packets",
  "AUTHOR" => "Robert Rothenberg <rrwo\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Net-Statsd-Lite",
  "LICENSE" => "artistic_2",
  "MIN_PERL_VERSION" => "5.010000",
  "NAME" => "Net::Statsd::Lite",
  "PREREQ_PM" => {
    "Devel::StrictMode" => 0,
    "IO::Socket" => "1.18",
    "Moo" => "1.000000",
    "MooX::TypeTiny" => 0,
    "Scalar::Util" => 0,
    "Sub::Quote" => 0,
    "Sub::Util" => "1.40",
    "Types::Standard" => 0,
    "namespace::autoclean" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Carp" => 0,
    "File::Spec" => 0,
    "IO::Select" => 0,
    "Module::Metadata" => 0,
    "Net::EmptyPort" => 0,
    "Socket" => 0,
    "Test::More" => 0,
    "Test::Roo" => 0,
    "Test::Roo::DataDriven" => 0,
    "Test::Roo::Role" => 0,
    "Test::TCP" => "2.22",
    "curry" => 0,
    "if" => 0,
    "lib" => 0,
    "utf8" => 0
  },
  "VERSION" => "v0.4.10",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Devel::StrictMode" => 0,
  "File::Spec" => 0,
  "IO::Select" => 0,
  "IO::Socket" => "1.18",
  "Module::Metadata" => 0,
  "Moo" => "1.000000",
  "MooX::TypeTiny" => 0,
  "Net::EmptyPort" => 0,
  "Scalar::Util" => 0,
  "Socket" => 0,
  "Sub::Quote" => 0,
  "Sub::Util" => "1.40",
  "Test::More" => 0,
  "Test::Roo" => 0,
  "Test::Roo::DataDriven" => 0,
  "Test::Roo::Role" => 0,
  "Test::TCP" => "2.22",
  "Types::Standard" => 0,
  "curry" => 0,
  "if" => 0,
  "lib" => 0,
  "namespace::autoclean" => 0,
  "strict" => 0,
  "utf8" => 0,
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
