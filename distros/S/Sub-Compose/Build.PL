use Module::Build;

use strict;

my $build = Module::Build->new(
    module_name => 'Sub::Compose',
    license => 'perl',
    requires => {
        'Carp'                 => '0.01',
        'Data::Dump::Streamer' => '0.01',
        'Sub::Name'            => '0.01',
    },
    optional => {
    },
    build_requires => {
        'Test::More'      => '0.47',
    },
    create_makefile_pl => 'traditional',
    recursive_test_files => 1,
    add_to_cleanup => [
        'META.yml', '*.bak', '*.gz', 'Makefile.PL',
    ],
);

$build->create_build_script;
