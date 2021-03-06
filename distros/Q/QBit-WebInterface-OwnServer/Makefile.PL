# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.010.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "WebInterface with own HTTP server",
  "AUTHOR" => "Sergei Svistunov <sergei-svistunov\@yandex.ru>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "QBit-WebInterface-OwnServer",
  "EXE_FILES" => [
    "bin/qbit_start"
  ],
  "LICENSE" => "gpl",
  "NAME" => "QBit::WebInterface::OwnServer",
  "PREREQ_PM" => {
    "Exception" => 0,
    "Getopt::Long" => 0,
    "IO::Socket" => 0,
    "MIME::Types" => 0,
    "Pod::Usage" => 0,
    "QBit::WebInterface" => 0,
    "QBit::WebInterface::Request" => 0,
    "QBit::WebInterface::Response" => 0,
    "base" => 0,
    "lib" => 0,
    "qbit" => 0
  },
  "TEST_REQUIRES" => {
    "FindBin" => 0,
    "QBit::Application" => 0,
    "QBit::WebInterface::Controller" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.008",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Exception" => 0,
  "FindBin" => 0,
  "Getopt::Long" => 0,
  "IO::Socket" => 0,
  "MIME::Types" => 0,
  "Pod::Usage" => 0,
  "QBit::Application" => 0,
  "QBit::WebInterface" => 0,
  "QBit::WebInterface::Controller" => 0,
  "QBit::WebInterface::Request" => 0,
  "QBit::WebInterface::Response" => 0,
  "Test::More" => 0,
  "base" => 0,
  "lib" => 0,
  "qbit" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
