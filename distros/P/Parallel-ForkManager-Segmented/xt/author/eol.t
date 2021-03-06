use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::EOL 0.19

use Test::More 0.88;
use Test::EOL;

my @files = (
    'lib/Parallel/ForkManager/Segmented.pm',
    't/00-compile.t',
    't/avoid-callback-on-empty-input.t',
    't/system-test--process-batch.t',
    't/system-test--stream-cb.t',
    't/system-test-1--without-arefs.t',
    't/system-test-1.t'
);

eol_unix_ok($_, { trailing_whitespace => 1 }) foreach @files;
done_testing;
