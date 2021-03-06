package main;

use strict;
use warnings;

BEGIN {
    eval {
	require Test::More;
	Test::More->import();
	1;
    } or do {
	print "1..0 # skip Test::More required to test pod coverage.\n";
	exit;
    };

    eval {
	require Test::Pod::Coverage;
	Test::Pod::Coverage->VERSION(1.00);
	Test::Pod::Coverage->import();
	1;
    } or do {
	print <<eod;
1..0 # skip Test::Pod::Coverage 1.00 or greater required.
eod
	exit;
    };
}

plan skip_all =>
	'Geo::Coder::Geocoder::US has been retracted, because the underlying web site no longer exists';

{

    local $SIG{__WARN__} = sub {};

    all_pod_coverage_ok ({
	    also_private => [ qr{^[[:upper:]\d_]+$}, ],
	    coverage_class => 'Pod::Coverage::CountParents'
	});
}

1;
