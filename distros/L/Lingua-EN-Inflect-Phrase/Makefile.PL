# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.010.
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Inflect short English Phrases",
  "AUTHOR" => "Rafael Kitover <rkitover\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Lingua-EN-Inflect-Phrase",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.006",
  "NAME" => "Lingua::EN::Inflect::Phrase",
  "PREREQ_PM" => {
    "Exporter" => 0,
    "Lingua::EN::FindNumber" => 0,
    "Lingua::EN::Inflect" => 0,
    "Lingua::EN::Inflect::Number" => 0,
    "Lingua::EN::Number::IsOrdinal" => 0,
    "Lingua::EN::Tagger" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => 0,
    "Test::NoWarnings" => 0,
    "lib" => 0
  },
  "VERSION" => "0.20",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Exporter" => 0,
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Lingua::EN::FindNumber" => 0,
  "Lingua::EN::Inflect" => 0,
  "Lingua::EN::Inflect::Number" => 0,
  "Lingua::EN::Number::IsOrdinal" => 0,
  "Lingua::EN::Tagger" => 0,
  "Test::More" => 0,
  "Test::NoWarnings" => 0,
  "lib" => 0,
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
