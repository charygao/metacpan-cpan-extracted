
# This file was automatically generated by Dist::Zilla::Plugin::ModuleBuild v5.039.
use strict;
use warnings;

use Module::Build 0.30;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.30"
  },
  "configure_requires" => {
    "ExtUtils::MakeMaker" => 0,
    "Module::Build" => "0.30"
  },
  "dist_abstract" => "Danish postal order number validator",
  "dist_author" => [
    "Jonas B. Nielsen <jonasbn\@cpan.org>"
  ],
  "dist_name" => "Business-DK-PO",
  "dist_version" => "0.08",
  "license" => "artistic_2",
  "module_name" => "Business::DK::PO",
  "recursive_test_files" => 1,
  "requires" => {
    "Carp" => 0,
    "Exporter" => 0,
    "perl" => "5.005_03"
  },
  "test_requires" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Pod::Coverage::TrustPod" => 0,
    "Test::Kwalitee" => "1.21",
    "Test::More" => "0.88",
    "Test::Pod" => "1.41",
    "Test::Pod::Coverage" => "1.08"
  }
);


my %fallback_build_requires = (
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Module::Build" => "0.30",
  "Pod::Coverage::TrustPod" => 0,
  "Test::Kwalitee" => "1.21",
  "Test::More" => "0.88",
  "Test::Pod" => "1.41",
  "Test::Pod::Coverage" => "1.08"
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  delete $module_build_args{test_requires};
  $module_build_args{build_requires} = \%fallback_build_requires;
}

my $build = Module::Build->new(%module_build_args);


$build->create_build_script;
