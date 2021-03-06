use strict; use warnings;
BEGIN {
  unless(eval q{ use 5.006; 1}) {
    print "Perl 5.006 or better required\n";
    exit;
  }
}
# This file was automatically generated by Dist::Zilla::Plugin::Author::Plicease::MakeMaker v2.28.
use strict;
use warnings;
use 5.006;
use ExtUtils::MakeMaker 6.64;
require "./inc/mymm.pl";

my %WriteMakefileArgs = (
  "ABSTRACT"           => "Universally Unique Identifiers FFI style",
  "AUTHOR"             => "Graham Ollis <plicease\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.64",
    "FFI::CheckLib"       => "0.05"
  },
  "DISTNAME"         => "UUID-FFI",
  "LICENSE"          => "perl",
  "MIN_PERL_VERSION" => "5.006",
  "NAME"             => "UUID::FFI",
  "PM"               => {
    "lib/UUID/FFI.pm" => "\$(INST_LIB)/UUID/FFI.pm"
  },
  "PREREQ_PM" => {
    "FFI::CheckLib" => "0.06",
    "FFI::Platypus" => "0.56"
  },
  "TEST_REQUIRES" => {
    "Test2::V0" => "0.000060"
  },
  "VERSION" => "0.07",
  "test"    => {
    "TESTS" => "t/*.t"
    }
);

mymm::myWriteMakefile(%WriteMakefileArgs);