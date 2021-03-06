use strict;
use warnings;

use FindBin qw($Bin);

use lib "$Bin/lib";

use TestUtils;

use Test::More;

if ($ENV{APP_TESTONTAP_SKIP_TEST_60})
{
	plan skip_all => 'Skipped to work around a problem when run in Travis and git commit message is more than one line long';
}
else
{
	plan tests => 6;
}

my $now = time();
my $now1 = $now+1;
my ($ret, $stdout, $stderr) = TestUtils::xeqsuite([qw(--verbose)], [$now]);

is($ret, 0, "Exited with 0");
like($stderr->[0], qr/^WARNING: No execmap found, using internal default!$/, "default execmap");
like($stderr->[1], qr/^WARNING: Unexpected line during preprocessing: 'Gibberish stderr'$/, "gibberish err");
like($stderr->[2], qr/^WARNING: Unexpected line during preprocessing: 'Gibberish stdout'$/, "gibberish out");
like($stdout->[2], qr/^ok 1 - present in env: TESTONTAP_PREPROCESS_TEST_\Q$now\E$/, "saw preproc var");
like($stdout->[3], qr/^ok 2 - present in argv: \Q$now1\E$/, "saw preproc arg");

done_testing();
