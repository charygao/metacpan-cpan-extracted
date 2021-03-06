# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.014.
use strict;
use warnings;



use ExtUtils::MakeMaker;

use File::ShareDir::Install;
$File::ShareDir::Install::INCLUDE_DOTFILES = 1;
$File::ShareDir::Install::INCLUDE_DOTDIRS = 1;
install_share module => "LaTeX::Recode", "shares";


my %WriteMakefileArgs = (
  "ABSTRACT" => "Encode/Decode chars to/from UTF-8/macros in LaTeX",
  "AUTHOR" => "Alberto Simoes <ambs\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::ShareDir::Install" => "0.06"
  },
  "DISTNAME" => "LaTeX-Recode",
  "LICENSE" => "perl",
  "NAME" => "LaTeX::Recode",
  "PREREQ_PM" => {
    "Encode" => 0,
    "Exporter" => 0,
    "File::ShareDir" => 0,
    "File::Slurp" => 0,
    "File::Spec" => 0,
    "List::Util" => 0,
    "Unicode::Normalize" => 0,
    "XML::LibXML::Simple" => 0,
    "autovivification" => 0,
    "parent" => 0,
    "re" => 0,
    "strict" => 0,
    "utf8" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.05",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Encode" => 0,
  "Exporter" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::ShareDir" => 0,
  "File::Slurp" => 0,
  "File::Spec" => 0,
  "List::Util" => 0,
  "Test::More" => 0,
  "Unicode::Normalize" => 0,
  "XML::LibXML::Simple" => 0,
  "autovivification" => 0,
  "parent" => 0,
  "re" => 0,
  "strict" => 0,
  "utf8" => 0,
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

{
package
MY;
use File::ShareDir::Install qw(postamble);
}
