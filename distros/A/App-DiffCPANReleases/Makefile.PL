# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.009.
use strict;
use warnings;

use 5.010001;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Diff contents of two CPAN releases",
  "AUTHOR" => "perlancar <perlancar\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "App-DiffCPANReleases",
  "EXE_FILES" => [
    "script/diff-cpan-releases"
  ],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010001",
  "NAME" => "App::DiffCPANReleases",
  "PREREQ_PM" => {
    "App::DiffTarballs" => 0,
    "App::cpm::Resolver::MetaCPAN" => 0,
    "Data::Sah::Compiler::perl::TH::str" => 0,
    "File::Util::Tempdir" => 0,
    "HTTP::Tiny" => 0,
    "Log::ger" => "0.023",
    "Perinci::CmdLine::Any" => 0,
    "Perinci::CmdLine::Base" => "1.76",
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.001",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "App::DiffTarballs" => 0,
  "App::cpm::Resolver::MetaCPAN" => 0,
  "Data::Sah::Compiler::perl::TH::str" => 0,
  "File::Spec" => 0,
  "File::Util::Tempdir" => 0,
  "HTTP::Tiny" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Log::ger" => "0.023",
  "Perinci::CmdLine::Any" => 0,
  "Perinci::CmdLine::Base" => "1.76",
  "Test::More" => 0,
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
