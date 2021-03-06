
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.008.
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Library for creating easy email filters",
  "AUTHOR" => "Simon Cozens, Casey West, Ricardo SIGNES <rjbs\@cpan.org>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Email-Filter",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Email::Filter",
  "PREREQ_PM" => {
    "Class::Trigger" => 0,
    "Email::LocalDelivery" => 0,
    "Email::Simple" => 0,
    "IPC::Run" => 0,
    "constant" => 0,
    "strict" => 0
  },
  "TEST_REQUIRES" => {
    "File::Temp" => 0,
    "Test::More" => "0.96",
    "warnings" => 0
  },
  "VERSION" => "1.034",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Class::Trigger" => 0,
  "Email::LocalDelivery" => 0,
  "Email::Simple" => 0,
  "File::Temp" => 0,
  "IPC::Run" => 0,
  "Test::More" => "0.96",
  "constant" => 0,
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



