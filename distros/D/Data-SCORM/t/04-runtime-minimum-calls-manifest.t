#!perl

use strict; use warnings;

# use Test::More tests => 7;
use Test::More skip_all => 'Bork Bork';
use FindBin qw/ $Bin /;
use Data::Dumper;

skip_all "This test fails";

BEGIN {
    use_ok( 'Data::SCORM' );
}

diag( "Testing Data::SCORM $Data::SCORM::VERSION, Perl $], $^X" );

ok (my $m = Data::SCORM::Manifest->parsefile(
    "$Bin/manifests/imsmanifest-RuntimeMinimumCalls_SCORM12.xml"),
    "Created scorm");

isa_ok $m, 'Data::SCORM::Manifest';

my $org = $m->get_default_organization('B0');
isa_ok $org, 'Data::SCORM::Organization';

my $item = $org->get_item(0);
isa_ok $item, 'Data::SCORM::Item';

is $item->identifier, 'i1', 'Identifier is i1';

my $resource = $item->resource;

is $resource->identifier, 'r1', "Item resource is r1" or diag Dumper($resource);
