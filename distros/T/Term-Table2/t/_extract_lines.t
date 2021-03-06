#!/usr/bin/env perl

use v5.14;
use warnings FATAL => qw(all);

package Term::Table2;

use Test2::V0 -target => 'Term::Table2';

my $table = bless(
  {
    ':number_of_columns' => 2,
    'column_width'       => [1, 1],
  },
  $CLASS,
);

is($table->_extract_lines(['', 'x'], [SPLIT, SPLIT]), [['', 'x']], 'There is some content');
is($table->_extract_lines(['', ''],  [SPLIT, SPLIT]), [['', '']],  'All fields are empty');
is($table->_extract_lines([],        [SPLIT, SPLIT]), [],          'Empty row');

done_testing();