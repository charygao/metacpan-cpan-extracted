
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.013.
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Implement (something similar to) the Ardupilot protocol",
  "AUTHOR" => "Timm Murray <tmurray\@wumpus-cave.net>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "UAV-Pilot-ArdupilotProtocol",
  "EXE_FILES" => [],
  "LICENSE" => "bsd",
  "NAME" => "UAV::Pilot::ArdupilotProtocol",
  "PREREQ_PM" => {},
  "TEST_REQUIRES" => {},
  "VERSION" => "0.001",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = ();


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



