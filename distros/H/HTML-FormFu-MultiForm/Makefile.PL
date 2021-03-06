# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.009.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Handle multi-page/stage forms with FormFu",
  "AUTHOR" => "Carl Franks <cpan\@fireartist.com>, Nigel Metheringham <nigelm\@cpan.org>, Dean Hamstead <dean\@bytefoundry.com.au>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "HTML-FormFu-MultiForm",
  "LICENSE" => "perl",
  "NAME" => "HTML::FormFu::MultiForm",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Clone" => 0,
    "Crypt::CBC" => 0,
    "Crypt::DES" => 0,
    "HTML::FormFu" => 0,
    "HTML::FormFu::Attribute" => 0,
    "HTML::FormFu::ObjectUtil" => 0,
    "HTML::FormFu::QueryType::CGI" => 0,
    "HTML::FormFu::Role::FormAndElementMethods" => 0,
    "HTML::FormFu::Role::FormBlockAndFieldMethods" => 0,
    "HTML::FormFu::Role::NestedHashUtils" => 0,
    "HTML::FormFu::Role::Populate" => 0,
    "List::MoreUtils" => 0,
    "Moose" => 0,
    "MooseX::Attribute::Chained" => 0,
    "Scalar::Util" => 0,
    "Storable" => 0,
    "overload" => 0,
    "strict" => 0
  },
  "TEST_REQUIRES" => {
    "Cwd" => 0,
    "ExtUtils::MakeMaker" => 0,
    "Fatal" => 0,
    "File::Spec" => 0,
    "Test::More" => "0.92",
    "YAML::XS" => 0,
    "warnings" => 0
  },
  "VERSION" => "1.03",
  "test" => {
    "TESTS" => "t/*.t t/multiform-misc/*.t t/multiform-nested-name/*.t t/multiform-no-combine/*.t t/multiform/*.t t/multiform_hidden_name/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Clone" => 0,
  "Crypt::CBC" => 0,
  "Crypt::DES" => 0,
  "Cwd" => 0,
  "ExtUtils::MakeMaker" => 0,
  "Fatal" => 0,
  "File::Spec" => 0,
  "HTML::FormFu" => 0,
  "HTML::FormFu::Attribute" => 0,
  "HTML::FormFu::ObjectUtil" => 0,
  "HTML::FormFu::QueryType::CGI" => 0,
  "HTML::FormFu::Role::FormAndElementMethods" => 0,
  "HTML::FormFu::Role::FormBlockAndFieldMethods" => 0,
  "HTML::FormFu::Role::NestedHashUtils" => 0,
  "HTML::FormFu::Role::Populate" => 0,
  "List::MoreUtils" => 0,
  "Moose" => 0,
  "MooseX::Attribute::Chained" => 0,
  "Scalar::Util" => 0,
  "Storable" => 0,
  "Test::More" => "0.92",
  "YAML::XS" => 0,
  "overload" => 0,
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
