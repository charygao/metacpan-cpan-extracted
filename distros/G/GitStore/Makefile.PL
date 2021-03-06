
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.031.
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Git as versioned data store in Perl",
  "AUTHOR" => "Fayland Lam <fayland\@gmail.com>, Yanick Champoux <yanick\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "GitStore",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.006",
  "NAME" => "GitStore",
  "PREREQ_PM" => {
    "Carp" => 0,
    "DateTime" => 0,
    "Git::PurePerl" => 0,
    "List::Util" => 0,
    "Moose" => 0,
    "Moose::Role" => 0,
    "Moose::Util::TypeConstraints" => 0,
    "Path::Class" => 0,
    "Path::Tiny" => 0,
    "Storable" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Exporter" => 0,
    "File::Spec" => 0,
    "FindBin" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => "0.88",
    "lib" => 0,
    "parent" => 0
  },
  "VERSION" => "0.17",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "DateTime" => 0,
  "Exporter" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "FindBin" => 0,
  "Git::PurePerl" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "List::Util" => 0,
  "Moose" => 0,
  "Moose::Role" => 0,
  "Moose::Util::TypeConstraints" => 0,
  "Path::Class" => 0,
  "Path::Tiny" => 0,
  "Storable" => 0,
  "Test::More" => "0.88",
  "lib" => 0,
  "parent" => 0,
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



