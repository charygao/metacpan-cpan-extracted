# Note: this file has been initially generated by Module::Build::Convert 0.49

use 5.006;
use strict;
use warnings;

use Module::Build;

my $build = Module::Build->new
  (
   module_name => 'Image::DCMTK',
   dist_author => 'q{Robert Haxton <robert.haxton@gmail.com>}',
   dist_version_from => 'lib/Image/DCMTK.pm',
   requires => {
                 'Data::PrintUtils' => 0,
                 'Getopt::CommandLineExports' => 0,
                 'IO::All' => 0,
                 'Test::More' => 0,
                 'XML::Simple' => 0,
                 },
   add_to_cleanup => [
                       'Image-DCMTK-*',
                       ],
   license => 'unknown',
   create_readme => 1,
   create_makefile_pl => 'traditional',
  );

$build->create_build_script;
