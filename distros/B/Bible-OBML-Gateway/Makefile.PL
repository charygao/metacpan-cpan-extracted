# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.015.
use strict;
use warnings;

use 5.016;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Bible Gateway content conversion to Open Bible Markup Language (OBML)",
  "AUTHOR" => "Gryphon Shafer <gryphon\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Bible-OBML-Gateway",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.016",
  "NAME" => "Bible::OBML::Gateway",
  "PREREQ_PM" => {
    "Bible::OBML" => "1.14",
    "Bible::Reference" => "1.04",
    "Mojo::DOM" => 0,
    "Mojo::File" => 0,
    "Mojo::URL" => 0,
    "Mojo::UserAgent" => 0,
    "Mojo::Util" => 0,
    "exact" => 0,
    "exact::class" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => 0,
    "Test::Most" => 0,
    "constant" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "1.10",
  "test" => {
    "TESTS" => "t/*.t t/Bible/OBML/*.t"
  }
);


my %FallbackPrereqs = (
  "Bible::OBML" => "1.14",
  "Bible::Reference" => "1.04",
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Mojo::DOM" => 0,
  "Mojo::File" => 0,
  "Mojo::URL" => 0,
  "Mojo::UserAgent" => 0,
  "Mojo::Util" => 0,
  "Test::More" => 0,
  "Test::Most" => 0,
  "constant" => 0,
  "exact" => 0,
  "exact::class" => 0,
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
