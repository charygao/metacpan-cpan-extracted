# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.047.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Dancer::Plugin::MemcachedFast - Cache things using Cache::Memcached::Fast",
  "AUTHOR" => "Marco Fontani <MFONTANI\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Dancer-Plugin-MemcachedFast",
  "LICENSE" => "perl",
  "NAME" => "Dancer::Plugin::MemcachedFast",
  "PREREQ_PM" => {
    "Cache::Memcached::Fast" => 0,
    "Dancer" => "1.2000",
    "Dancer::Plugin" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Dancer" => "1.2000",
    "Dancer::Test" => 0,
    "Test::More" => 0,
    "lib" => 0
  },
  "VERSION" => "0.161360",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Cache::Memcached::Fast" => 0,
  "Dancer" => "1.2000",
  "Dancer::Plugin" => 0,
  "Dancer::Test" => 0,
  "Test::More" => 0,
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
