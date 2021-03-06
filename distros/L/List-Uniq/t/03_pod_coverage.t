#
# $Id: 03_pod_coverage.t 4496 2010-06-18 15:19:43Z james $
#

use strict;
use warnings;

use Test::More;
eval "use Test::Pod::Coverage 1.00";
plan skip_all => "Test::Pod::Coverage 1.00 required for testing POD coverage" if $@;
all_pod_coverage_ok(
    {
        also_private => [ qr/^_\w+/, ]
    },
'all modules have POD covered');

#
# EOF
