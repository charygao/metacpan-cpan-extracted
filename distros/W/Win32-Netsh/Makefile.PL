use Devel::AssertOS qw[MSWin32];
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.039.
use strict;
use warnings;

use 5.010;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "A family of modules for querying and manipulating the network insterface of a Windows based PC using the netsh utility",
  "AUTHOR" => "Paul Durden <alabamapaul\@gmail.com>",
  "CONFIGURE_REQUIRES" => {
    "Devel::AssertOS" => 0,
    "Devel::CheckOS" => "1.63",
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Win32-Netsh",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010",
  "NAME" => "Win32::Netsh",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Data::Dumper" => 0,
    "Exporter::Easy" => 0,
    "File::Spec" => 0,
    "Readonly" => 0,
    "Win32" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Basename" => 0,
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => "0.88",
    "blib" => "1.01"
  },
  "VERSION" => "0.04",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Data::Dumper" => 0,
  "Exporter::Easy" => 0,
  "File::Basename" => 0,
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Readonly" => 0,
  "Test::More" => "0.88",
  "Win32" => 0,
  "blib" => "1.01",
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
