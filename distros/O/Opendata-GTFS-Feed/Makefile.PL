# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.043.
use strict;
use warnings;

use 5.010000;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Parse General Transit Feeds (GTFS)",
  "AUTHOR" => "Erik Carlsson <info\@code301.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Opendata-GTFS-Feed",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010000",
  "NAME" => "Opendata::GTFS::Feed",
  "PREREQ_PM" => {
    "Archive::Extract" => 0,
    "Archive::Zip" => 0,
    "File::BOM" => 0,
    "File::Temp" => 0,
    "Lingua::EN::Inflect" => 0,
    "List::Util" => "1.42",
    "List::UtilsBy" => "0.04",
    "Moose" => "2.1405",
    "Moose::Role" => 0,
    "MooseX::AttributeDocumented" => "0.1003",
    "MooseX::AttributeShortcuts" => "0.028",
    "Path::Tiny" => "0.072",
    "Text::CSV" => 0,
    "Type::Tiny" => "1.000005",
    "Types::Path::Tiny" => "0.005",
    "Types::Standard" => "1.000005",
    "Types::URI" => 0,
    "namespace::autoclean" => "0.22"
  },
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => "0.96",
    "Test::RequiresInternet" => "0.02",
    "Try::Tiny" => "0.24"
  },
  "VERSION" => "0.0202",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Archive::Extract" => 0,
  "Archive::Zip" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::BOM" => 0,
  "File::Spec" => 0,
  "File::Temp" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Lingua::EN::Inflect" => 0,
  "List::Util" => "1.42",
  "List::UtilsBy" => "0.04",
  "Moose" => "2.1405",
  "Moose::Role" => 0,
  "MooseX::AttributeDocumented" => "0.1003",
  "MooseX::AttributeShortcuts" => "0.028",
  "Path::Tiny" => "0.072",
  "Test::More" => "0.96",
  "Test::RequiresInternet" => "0.02",
  "Text::CSV" => 0,
  "Try::Tiny" => "0.24",
  "Type::Tiny" => "1.000005",
  "Types::Path::Tiny" => "0.005",
  "Types::Standard" => "1.000005",
  "Types::URI" => 0,
  "namespace::autoclean" => "0.22"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
