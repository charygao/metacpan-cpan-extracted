# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.043.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "This module provides an interface to an RCON (remote console) server. RCON is typically implemented by game servers to allow servers admins to control their game servers without direct access to the machine the server is running on. This module is based on the spec detailed here, https://developer.valvesoftware.com/wiki/Source_RCON_Protocol",
  "AUTHOR" => "Chris Handwerker <chris.handwerker\@gmail.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Net-RCON",
  "LICENSE" => "perl",
  "NAME" => "Net::RCON",
  "PREREQ_PM" => {
    "IO::Socket::INET" => "1.18"
  },
  "TEST_REQUIRES" => {
    "Test::More" => 0
  },
  "VERSION" => "1.0",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "IO::Socket::INET" => "1.18",
  "Test::More" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
