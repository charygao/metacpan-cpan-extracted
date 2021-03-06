
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.013.
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "OneTool Main module",
  "AUTHOR" => "Sebastien Thebert <contact\@onetool.pm>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "OneTool-Core",
  "EXE_FILES" => [],
  "LICENSE" => "gpl",
  "NAME" => "OneTool::Core",
  "PREREQ_PM" => {
    "File::Slurp" => 0,
    "FindBin" => 0,
    "JSON" => 0
  },
  "TEST_REQUIRES" => {
    "Test::More" => 0
  },
  "VERSION" => "0.1",
  "test" => {
    "TESTS" => "t/*.t t/OneTool/*.t"
  }
);


my %FallbackPrereqs = (
  "File::Slurp" => 0,
  "FindBin" => 0,
  "JSON" => 0,
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



