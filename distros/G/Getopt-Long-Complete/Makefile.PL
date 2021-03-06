# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.014.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "A drop-in replacement for Getopt::Long, with shell tab completion",
  "AUTHOR" => "perlancar <perlancar\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Getopt-Long-Complete",
  "EXE_FILES" => [
    "script/demo-getopt-long-complete"
  ],
  "LICENSE" => "perl",
  "NAME" => "Getopt::Long::Complete",
  "PREREQ_PM" => {
    "Complete::Bash" => "0.333",
    "Complete::Fish" => 0,
    "Complete::Getopt::Long" => "0.479",
    "Complete::Tcsh" => 0,
    "Complete::Util" => "0.608",
    "Complete::Zsh" => 0,
    "Exporter" => "5.57",
    "Getopt::Long" => "2.50",
    "Log::ger" => "0.037",
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => "0.98"
  },
  "VERSION" => "0.315",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Complete::Bash" => "0.333",
  "Complete::Fish" => 0,
  "Complete::Getopt::Long" => "0.479",
  "Complete::Tcsh" => 0,
  "Complete::Util" => "0.608",
  "Complete::Zsh" => 0,
  "Exporter" => "5.57",
  "File::Spec" => 0,
  "Getopt::Long" => "2.50",
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Log::ger" => "0.037",
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
