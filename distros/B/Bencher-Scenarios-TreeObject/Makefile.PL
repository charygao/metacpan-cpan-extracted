# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.008.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Scenarios to benchmark Tree-Object & Tree-ObjectXS",
  "AUTHOR" => "perlancar <perlancar\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Bencher-Scenarios-TreeObject",
  "LICENSE" => "perl",
  "NAME" => "Bencher::Scenarios::TreeObject",
  "PREREQ_PM" => {
    "Tree::Create::Size" => 0,
    "Tree::Object::Array" => 0,
    "Tree::Object::Array::Glob" => 0,
    "Tree::Object::Hash" => 0,
    "Tree::Object::Hash::ChildrenAsList" => 0,
    "Tree::Object::InsideOut" => 0,
    "Tree::ObjectXS::Array" => 0,
    "Tree::ObjectXS::Hash" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Bencher::Backend" => "1.034",
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.05",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Bencher::Backend" => "1.034",
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Test::More" => 0,
  "Tree::Create::Size" => 0,
  "Tree::Object::Array" => 0,
  "Tree::Object::Array::Glob" => 0,
  "Tree::Object::Hash" => 0,
  "Tree::Object::Hash::ChildrenAsList" => 0,
  "Tree::Object::InsideOut" => 0,
  "Tree::ObjectXS::Array" => 0,
  "Tree::ObjectXS::Hash" => 0,
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
