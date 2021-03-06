# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.009.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Export the current directory over HTTPS",
  "AUTHOR" => "perlancar <perlancar\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "App-HTTPSThis",
  "EXE_FILES" => [
    "script/https_this"
  ],
  "LICENSE" => "perl",
  "NAME" => "App::HTTPSThis",
  "PREREQ_PM" => {
    "AppLib::CreateSelfSignedSSLCert" => 0,
    "File::Temp" => 0,
    "File::chdir" => 0,
    "Getopt::Long" => 0,
    "Plack::App::Directory" => 0,
    "Plack::Runner" => 0,
    "Pod::Usage" => 0,
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
  "AppLib::CreateSelfSignedSSLCert" => 0,
  "File::Spec" => 0,
  "File::Temp" => 0,
  "File::chdir" => 0,
  "Getopt::Long" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Plack::App::Directory" => 0,
  "Plack::Runner" => 0,
  "Pod::Usage" => 0,
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
