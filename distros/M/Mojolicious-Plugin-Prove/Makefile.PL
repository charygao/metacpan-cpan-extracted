
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.029.
use strict;
use warnings;



use ExtUtils::MakeMaker;



my %WriteMakefileArgs = (
  "ABSTRACT" => "run test scripts via browser",
  "AUTHOR" => "Renee Baecker <reneeb\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Mojolicious-Plugin-Prove",
  "EXE_FILES" => [],
  "LICENSE" => "artistic_2",
  "NAME" => "Mojolicious::Plugin::Prove",
  "PREREQ_PM" => {
    "App::Prove" => 0,
    "Capture::Tiny" => 0,
    "Cwd" => 0,
    "File::Basename" => 0,
    "File::Find::Rule" => 0,
    "File::Spec" => 0,
    "Mojolicious" => "4.50",
    "Mojolicious::Plugin::PPI" => 0,
    "Test::LongString" => 0
  },
  "VERSION" => "0.08",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "App::Prove" => 0,
  "Capture::Tiny" => 0,
  "Cwd" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Basename" => 0,
  "File::Find::Rule" => 0,
  "File::Spec" => 0,
  "Mojolicious" => "4.50",
  "Mojolicious::Plugin::PPI" => 0,
  "Test::LongString" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



