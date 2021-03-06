
# This file was automatically generated by Dist::Zilla::Plugin::ModuleBuild v6.012.
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
  "dist_abstract" => "retrieve module information from a file",
  "dist_author" => [
    "Jonas B. <jonasbn\@cpan.org>"
  ],
  "dist_name" => "Module-Info-File",
  "dist_version" => "1.01",
  "license" => "artistic_2",
  "module_name" => "Module::Info::File",
  "recursive_test_files" => 1,
  "requires" => {
    "Carp" => 0,
    "Data::Dumper" => 0,
    "File::Basename" => 0,
    "Module::Info" => "0.20",
    "Module::Metadata" => 0,
    "Try::Tiny" => 0,
    "perl" => "5.006"
  },
  "test_requires" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => 0
  }
);


my %fallback_build_requires = (
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Module::Build" => "0.30",
  "Test::More" => 0
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  delete $module_build_args{test_requires};
  $module_build_args{build_requires} = \%fallback_build_requires;
}

my $build = Module::Build->new(%module_build_args);


$build->create_build_script;
