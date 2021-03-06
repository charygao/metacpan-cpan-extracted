#!perl -wT
use strict;
use Test::More;

plan skip_all => "Test::Pod::Coverage 1.06 required for testing POD coverage"
    unless eval "use Test::Pod::Coverage 1.06; 1";

all_pod_coverage_ok({
    also_private => [qw(^constant$ ^connect ^disconnect ^xlate$ ^LOG_ can_load silent_eval _xs$)]
});
