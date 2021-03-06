
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.019.
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "monitor a directory tree in a non-blocking way",
  "AUTHOR" => "Jonathan Rockway <jrockway\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "AnyEvent-Inotify-Simple",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "AnyEvent::Inotify::Simple",
  "PREREQ_PM" => {
    "AnyEvent" => 0,
    "File::Next" => 0,
    "Linux::Inotify2" => 0,
    "Moose" => 0,
    "MooseX::FileAttribute" => 0,
    "MooseX::Types::Path::Class" => 0
  },
  "TEST_REQUIRES" => {
    "Directory::Scratch" => 0,
    "EV" => 0,
    "MooseX::Declare" => 0,
    "Test::Exception" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.03",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "AnyEvent" => 0,
  "Directory::Scratch" => 0,
  "EV" => 0,
  "File::Next" => 0,
  "Linux::Inotify2" => 0,
  "Moose" => 0,
  "MooseX::Declare" => 0,
  "MooseX::FileAttribute" => 0,
  "MooseX::Types::Path::Class" => 0,
  "Test::Exception" => 0,
  "Test::More" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



