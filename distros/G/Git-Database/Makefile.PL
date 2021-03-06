# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.008.
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Provide access to the Git object database",
  "AUTHOR" => "Philippe Bruhat (BooK) <book\@cpan.org>",
  "BUILD_REQUIRES" => {
    "Pod::Coverage::TrustPod" => 0,
    "Test::CPAN::Meta" => 0,
    "Test::Pod" => 0,
    "Test::Pod::Coverage" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Git-Database",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.006",
  "NAME" => "Git::Database",
  "PREREQ_PM" => {
    "Cwd" => 0,
    "DateTime" => 0,
    "Digest::SHA" => 0,
    "Encode" => 0,
    "File::Spec" => 0,
    "File::pushd" => 0,
    "Git::Raw" => 0,
    "Git::Sub" => 0,
    "Git::Version::Compare" => 0,
    "Git::Wrapper" => 0,
    "IO::Select" => 0,
    "Module::Runtime" => 0,
    "Moo" => 0,
    "Moo::Object" => 0,
    "Moo::Role" => 0,
    "Path::Class" => 0,
    "Sub::Quote" => 0,
    "namespace::clean" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Data::Dumper" => 0,
    "ExtUtils::MakeMaker" => 0,
    "File::Basename" => 0,
    "File::Spec" => 0,
    "File::Temp" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => "0.88",
    "Test::Requires::Git" => "1.005",
    "lib" => 0
  },
  "VERSION" => "0.012",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Cwd" => 0,
  "Data::Dumper" => 0,
  "DateTime" => 0,
  "Digest::SHA" => 0,
  "Encode" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Basename" => 0,
  "File::Spec" => 0,
  "File::Temp" => 0,
  "File::pushd" => 0,
  "Git::Raw" => 0,
  "Git::Sub" => 0,
  "Git::Version::Compare" => 0,
  "Git::Wrapper" => 0,
  "IO::Handle" => 0,
  "IO::Select" => 0,
  "IPC::Open3" => 0,
  "Module::Runtime" => 0,
  "Moo" => 0,
  "Moo::Object" => 0,
  "Moo::Role" => 0,
  "Path::Class" => 0,
  "Pod::Coverage::TrustPod" => 0,
  "Sub::Quote" => 0,
  "Test::CPAN::Meta" => 0,
  "Test::More" => "0.88",
  "Test::Pod" => 0,
  "Test::Pod::Coverage" => 0,
  "Test::Requires::Git" => "1.005",
  "lib" => 0,
  "namespace::clean" => 0,
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
