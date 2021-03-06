#!/usr/local/bin/perl -w
use strict;
use Module::Build;

my $build = Module::Build->new(
    module_name => 'Nagios::Cmd',
    dist_version => 0.05,
    license => 'gpl',
    requires => {
        perl => '5.6.0'
    },
    build_requires => {
        'Test::More' => 0,
        'File::Temp' => 0
    }
);

$build->create_build_script();
