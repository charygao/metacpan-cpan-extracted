# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.014.
use strict;
use warnings;

use 5.010001;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Complete command-line argument using Rinci metadata",
  "AUTHOR" => "perlancar <perlancar\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Perinci-Sub-Complete",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010001",
  "NAME" => "Perinci::Sub::Complete",
  "PREREQ_PM" => {
    "Complete::Common" => "0.22",
    "Complete::Getopt::Long" => "0.479",
    "Complete::Sah" => "0.005",
    "Complete::Util" => "0.608",
    "Data::Sah::Normalize" => 0,
    "Exporter" => "5.57",
    "Log::ger" => "0.037",
    "Module::Installed::Tiny" => "0.004",
    "Perinci::Sub::GetArgs::Argv" => "0.842",
    "Perinci::Sub::Util" => "0.46",
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Complete::Bash" => "0.333",
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Monkey::Patch::Action" => "0.060",
    "Perinci::Examples" => "0.819",
    "Perinci::Sub::Normalize" => "0.19",
    "Sah::SchemaR::negint" => 0,
    "Sah::SchemaR::posint" => 0,
    "Test::More" => "0.98"
  },
  "VERSION" => "0.943",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Complete::Bash" => "0.333",
  "Complete::Common" => "0.22",
  "Complete::Getopt::Long" => "0.479",
  "Complete::Sah" => "0.005",
  "Complete::Util" => "0.608",
  "Data::Sah::Normalize" => 0,
  "Exporter" => "5.57",
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Log::ger" => "0.037",
  "Module::Installed::Tiny" => "0.004",
  "Monkey::Patch::Action" => "0.060",
  "Perinci::Examples" => "0.819",
  "Perinci::Sub::GetArgs::Argv" => "0.842",
  "Perinci::Sub::Normalize" => "0.19",
  "Perinci::Sub::Util" => "0.46",
  "Sah::SchemaR::negint" => 0,
  "Sah::SchemaR::posint" => 0,
  "Test::More" => "0.98",
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
