#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

use MVC::Neaf;

my $capture;
my $file = __FILE__;

get '/foo' => sub {
    $capture = shift;
    +{-content => 42};
}, path_info_regex => '.*';

neaf->run_test( '/foo/bar' );

like $capture->endpoint_origin, qr/^$file line (\d+)$/, "Origin in this file";
note $capture->endpoint_origin;

done_testing;
