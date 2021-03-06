
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.029.
use strict;
use warnings;



use ExtUtils::MakeMaker;



my %WriteMakefileArgs = (
  "ABSTRACT" => "[DEPRECATED] Search driver for the (DE) Amazon online catalog.",
  "AUTHOR" => "Renee Baecker <reneeb\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "WWW-Scraper-ISBN-AmazonDE_Driver",
  "EXE_FILES" => [],
  "LICENSE" => "artistic_2",
  "NAME" => "WWW::Scraper::ISBN::AmazonDE_Driver",
  "PREREQ_PM" => {
    "Test::CheckManifest" => "1.22",
    "Test::More" => 0,
    "WWW::Mechanize" => "1.20",
    "WWW::Scraper::ISBN" => "0.24",
    "WWW::Scraper::ISBN::Driver" => "0.17",
    "Web::Scraper" => "0.13"
  },
  "VERSION" => "0.28",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "ExtUtils::MakeMaker" => 0,
  "Test::CheckManifest" => "1.22",
  "Test::More" => 0,
  "WWW::Mechanize" => "1.20",
  "WWW::Scraper::ISBN" => "0.24",
  "WWW::Scraper::ISBN::Driver" => "0.17",
  "Web::Scraper" => "0.13"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



