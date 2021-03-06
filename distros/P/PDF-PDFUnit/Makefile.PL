
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.020.
use strict;
use warnings;

use 5.010;

use ExtUtils::MakeMaker ;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Perl interface to the Java PDFUnit testing framework",
  "AUTHOR" => "Axel Miesen <mail\@am42.de>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "PDF-PDFUnit",
  "EXE_FILES" => [
    "bin/pdfunit-perl.pl",
    "bin/pdfunit-outfox.pl"
  ],
  "LICENSE" => "perl",
  "NAME" => "PDF::PDFUnit",
  "PREREQ_PM" => {
    "Inline::Java" => "0.58",
    "Test::Exception" => 0
  },
  "VERSION" => "0.17",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Inline::Java" => "0.58",
  "Test::Exception" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



