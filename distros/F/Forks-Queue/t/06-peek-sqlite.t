use strict;
use warnings;
use Test::More;
use lib '.';   # 5.26 compat
require "t/exercises.tt";

PREP('SQLite');
my $qfile = "q6s-$$";
my $TEMP = TEMP_DIR();
unlink "$TEMP/$qfile";

ok(! -f "$TEMP/$qfile", 'queue file does not exist yet');
my $q4 = Forks::Queue->new( impl => 'SQLite', db_file => "$TEMP/$qfile",
                            style => 'fifo' );
$q4->clear;
exercise_peek($q4);
undef $q4;

done_testing;
