# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.044.
use strict;
use warnings;

use 5.008;

use ExtUtils::MakeMaker;

use File::ShareDir::Install;
$File::ShareDir::Install::INCLUDE_DOTFILES = 1;
$File::ShareDir::Install::INCLUDE_DOTDIRS = 1;
install_share module => "WebService::Avalara::AvaTax::Service::Tax", "shares\/ServiceTax";


my %WriteMakefileArgs = (
  "ABSTRACT" => "Avalara SOAP interface as compiled Perl methods",
  "AUTHOR" => "Mark Gardner <mjgardner\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::ShareDir::Install" => "0.06"
  },
  "DISTNAME" => "WebService-Avalara-AvaTax",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.008",
  "NAME" => "WebService::Avalara::AvaTax",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Const::Fast" => 0,
    "DateTime" => 0,
    "DateTime::Format::XSD" => 0,
    "English" => 0,
    "File::ShareDir" => "1.00",
    "LWP::Protocol::https" => 0,
    "LWP::UserAgent" => 0,
    "LWPx::UserAgent::Cached" => 0,
    "Log::Report" => 0,
    "Moo" => "1.006000",
    "Moo::Role" => 0,
    "Mozilla::CA" => 0,
    "Package::Stash" => 0,
    "Path::Tiny" => "0.018",
    "Scalar::Util" => 0,
    "Sys::Hostname" => 0,
    "Types::Path::Tiny" => 0,
    "Types::Standard" => 0,
    "Types::URI" => 0,
    "URI" => 0,
    "XML::Compile::Dumper" => 0,
    "XML::Compile::SOAP11" => 0,
    "XML::Compile::SOAP12" => 0,
    "XML::Compile::SOAP::WSS" => 0,
    "XML::Compile::Transport::SOAPHTTP" => 0,
    "XML::Compile::WSDL11" => 0,
    "XML::Compile::WSS" => 0,
    "namespace::clean" => 0,
    "strict" => 0,
    "utf8" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "List::MoreUtils" => 0,
    "List::Util" => "1.33",
    "Test::File::ShareDir::Module" => "1.000000",
    "Test::More" => "0.94",
    "Test::Most" => 0,
    "Test::RequiresInternet" => 0,
    "XML::Compile::Tester" => 0,
    "XML::Compile::Util" => 0,
    "blib" => "1.01"
  },
  "VERSION" => "0.020",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Const::Fast" => 0,
  "DateTime" => 0,
  "DateTime::Format::XSD" => 0,
  "English" => 0,
  "File::ShareDir" => "1.00",
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "LWP::Protocol::https" => 0,
  "LWP::UserAgent" => 0,
  "LWPx::UserAgent::Cached" => 0,
  "List::MoreUtils" => 0,
  "List::Util" => "1.33",
  "Log::Report" => 0,
  "Moo" => "1.006000",
  "Moo::Role" => 0,
  "Mozilla::CA" => 0,
  "Package::Stash" => 0,
  "Path::Tiny" => "0.018",
  "Scalar::Util" => 0,
  "Sys::Hostname" => 0,
  "Test::File::ShareDir::Module" => "1.000000",
  "Test::More" => "0.94",
  "Test::Most" => 0,
  "Test::RequiresInternet" => 0,
  "Types::Path::Tiny" => 0,
  "Types::Standard" => 0,
  "Types::URI" => 0,
  "URI" => 0,
  "XML::Compile::Dumper" => 0,
  "XML::Compile::SOAP11" => 0,
  "XML::Compile::SOAP12" => 0,
  "XML::Compile::SOAP::WSS" => 0,
  "XML::Compile::Tester" => 0,
  "XML::Compile::Transport::SOAPHTTP" => 0,
  "XML::Compile::Util" => 0,
  "XML::Compile::WSDL11" => 0,
  "XML::Compile::WSS" => 0,
  "blib" => "1.01",
  "namespace::clean" => 0,
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
