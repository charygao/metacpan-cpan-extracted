
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.015.
use strict;
use warnings;

use 5.012000;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Adding a simple way to send text and html/markdown emails",
  "AUTHOR" => "Kevin Mulholland <moodfarm\@cpan.org>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "App-Basis-Email",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "App::Basis::Email",
  "PREREQ_PM" => {
    "Email::MIME::CreateHTML" => 0,
    "Email::Sender::Simple" => 0,
    "Email::Sender::Transport::SMTP" => 0,
    "Email::Sender::Transport::Sendmail" => 0,
    "HTML::Restrict" => 0,
    "Moo" => 0,
    "Text::Markdown" => 0,
    "Try::Tiny" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Slurp" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.3",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Email::MIME::CreateHTML" => 0,
  "Email::Sender::Simple" => 0,
  "Email::Sender::Transport::SMTP" => 0,
  "Email::Sender::Transport::Sendmail" => 0,
  "File::Slurp" => 0,
  "HTML::Restrict" => 0,
  "Moo" => 0,
  "Test::More" => 0,
  "Text::Markdown" => 0,
  "Try::Tiny" => 0,
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



