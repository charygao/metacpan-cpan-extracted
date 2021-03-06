# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.009.
use strict;
use warnings;

use 5.010001;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Run Data::Unixish function on the command-line",
  "AUTHOR" => "perlancar <perlancar\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "App-dux",
  "EXE_FILES" => [
    "script/dux"
  ],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010001",
  "NAME" => "App::dux",
  "PREREQ_PM" => {
    "Data::Unixish" => "1.54",
    "Getopt::Long" => "2.50",
    "Log::ger" => "0.027",
    "Module::Installed::Tiny" => 0,
    "Module::List" => 0,
    "Moo" => 0,
    "Perinci::CmdLine::Lite" => "1.820",
    "Tie::Diamond" => "0.05",
    "Tie::Simple" => 0,
    "experimental" => 0,
    "lib" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => 0
  },
  "VERSION" => "1.540",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Data::Unixish" => "1.54",
  "File::Spec" => 0,
  "Getopt::Long" => "2.50",
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Log::ger" => "0.027",
  "Module::Installed::Tiny" => 0,
  "Module::List" => 0,
  "Moo" => 0,
  "Perinci::CmdLine::Lite" => "1.820",
  "Test::More" => 0,
  "Tie::Diamond" => "0.05",
  "Tie::Simple" => 0,
  "experimental" => 0,
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
