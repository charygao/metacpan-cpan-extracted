use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.15

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'bin/csv2chart',
    'lib/App/CSV2Chart.pm',
    'lib/App/CSV2Chart/API/ToXLSX.pm',
    'lib/App/CSV2Chart/Command/svg.pm',
    'lib/App/CSV2Chart/Command/xlsx.pm',
    't/00-compile.t'
);

notabs_ok($_) foreach @files;
done_testing;
