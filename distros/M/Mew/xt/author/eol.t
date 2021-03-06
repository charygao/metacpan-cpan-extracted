use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::EOL 0.19

use Test::More 0.88;
use Test::EOL;

my @files = (
    'lib/Mew.pm',
    'lib/ew.pm',
    't/00-compile.t',
    't/01-mew.t',
    't/02-optional.t',
    't/03-maybe.t',
    't/Class1.pm',
    't/Class2.pm',
    't/Class3.pm'
);

eol_unix_ok($_, { trailing_whitespace => 1 }) foreach @files;
done_testing;
