use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::EOL 0.19

use Test::More 0.88;
use Test::EOL;

my @files = (
    'lib/DBIx/TableLoader.pm',
    't/00-compile.t',
    't/00-report-prereqs.dd',
    't/00-report-prereqs.t',
    't/lib/TLDBH.pm',
    't/methods.t',
    't/sql.t',
    't/sqlite.t',
    't/subclass.t',
    't/transaction.t',
    't/validate.t'
);

eol_unix_ok($_, { trailing_whitespace => 1 }) foreach @files;
done_testing;
