
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.019.
use strict;
use warnings;

use 5.008001;

use ExtUtils::MakeMaker 6.30;

use File::ShareDir::Install;
$File::ShareDir::Install::INCLUDE_DOTFILES = 1;
$File::ShareDir::Install::INCLUDE_DOTDIRS = 1;
install_share dist => "share";


my %WriteMakefileArgs = (
  "ABSTRACT" => "MANIFEST.SKIP Manangement for Modules",
  "AUTHOR" => "Ingy d\x{f6}t Net <ingy\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30",
    "File::ShareDir::Install" => "0.06"
  },
  "DISTNAME" => "Module-Manifest-Skip",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Module::Manifest::Skip",
  "PREREQ_PM" => {
    "Moo" => "0.091013"
  },
  "VERSION" => "0.23",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Moo" => "0.091013"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

{
package
MY;
use File::ShareDir::Install qw(postamble);
}


