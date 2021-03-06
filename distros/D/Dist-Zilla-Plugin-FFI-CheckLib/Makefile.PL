use strict; use warnings;
BEGIN {
  unless(eval q{ use 5.006; 1}) {
    print "Perl 5.006 or better required\n";
    exit;
  }
}
# This file was automatically generated by Dist::Zilla::Plugin::Author::Plicease::MakeMaker v2.26.
use strict;
use warnings;
use 5.006;
use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT"           => "FFI::CheckLib alternative to Dist::Zilla::Plugin::CheckLib",
  "AUTHOR"             => "Jon Portnoy <avenj\@cobaltirc.org>, Graham Ollis <plicease\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME"         => "Dist-Zilla-Plugin-FFI-CheckLib",
  "LICENSE"          => "perl",
  "MIN_PERL_VERSION" => "5.006",
  "NAME"             => "Dist::Zilla::Plugin::FFI::CheckLib",
  "PM"               => {
    "lib/Dist/Zilla/Plugin/FFI/CheckLib.pm" => "\$(INST_LIB)/Dist/Zilla/Plugin/FFI/CheckLib.pm"
  },
  "PREREQ_PM" => {
    "Dist::Zilla"                     => "5.00",
    "Dist::Zilla::Role::FileMunger"   => 0,
    "Dist::Zilla::Role::InstallTool"  => 0,
    "Dist::Zilla::Role::PrereqSource" => 0,
    "FFI::CheckLib"                   => "0.11",
    "Moose"                           => 0,
    "namespace::autoclean"            => 0
  },
  "TEST_REQUIRES" => {
    "Path::Tiny" => 0,
    "Test2::V0"  => "0.000060",
    "Test::DZil" => 0
  },
  "VERSION" => "1.01",
  "test"    => {
    "TESTS" => "t/*.t"
    }
);

my %FallbackPrereqs = (
  "Dist::Zilla"                     => "5.00",
  "Dist::Zilla::Role::FileMunger"   => 0,
  "Dist::Zilla::Role::InstallTool"  => 0,
  "Dist::Zilla::Role::PrereqSource" => 0,
  "FFI::CheckLib"                   => "0.11",
  "Moose"                           => 0,
  "Path::Tiny"                      => 0,
  "Test2::V0"                       => "0.000060",
  "Test::DZil"                      => 0,
  "namespace::autoclean"            => 0
);

unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);