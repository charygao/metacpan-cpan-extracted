use strict;
use warnings;

use CSS::Struct::Output::Raw;
use English qw(-no_match_vars);
use Error::Pure::Utils qw(clean);
use Test::More 'tests' => 6;
use Test::NoWarnings;

# Test.
my $obj = CSS::Struct::Output::Raw->new;
$obj->put(
	['s', 'selector'],
	['d', 'attr', 'value'],
	['e'],
);
my $ret = $obj->flush;
my $right_ret = 'selector{attr:value;}';
is($ret, $right_ret);

# Test.
$obj->put(
	['s', 'selector'],
	['d', 'attr', 'value'],
	['e'],
);
$ret = $obj->flush;
is($ret, $right_ret x 2);

# Test.
$obj->put(
	['s', 'selector'],
	['d', 'attr', 'value'],
	['e'],
);
$ret = $obj->flush(1);
is($ret, $right_ret x 3);

# Test.
$obj->put(
	['s', 'selector'],
	['d', 'attr', 'value'],
	['e'],
);
$ret = $obj->flush;
is($ret, $right_ret);

# Test.
SKIP: {
	eval {
		require File::Temp;
	};
	if ($EVAL_ERROR) {
		skip 'File::Temp not installed', 1;
	};
	my $temp_fh = File::Temp::tempfile();
	$obj = CSS::Struct::Output::Raw->new(
		'output_handler' => $temp_fh,
	);
	$obj->put(
		['s', 'selector'],
		['d', 'attr', 'value'],
		['e'],
	);
	$temp_fh->close;
	eval {
		$ret = $obj->flush;
	};
	is($EVAL_ERROR, "Cannot write to output handler.\n");
	clean();
}
