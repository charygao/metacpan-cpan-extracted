use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.15

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/Test/Data/Split.pm',
    'lib/Test/Data/Split/Backend/Hash.pm',
    'lib/Test/Data/Split/Backend/ValidateHash.pm',
    't/00-compile.t',
    't/lib/DataSplitHashTest.pm',
    't/lib/DataSplitValidateHashTest1.pm',
    't/lib/DataSplitValidateHashTest2.pm',
    't/run.t',
    't/validate-hash-1.t',
    't/validate-hash-2.t'
);

notabs_ok($_) foreach @files;
done_testing;
