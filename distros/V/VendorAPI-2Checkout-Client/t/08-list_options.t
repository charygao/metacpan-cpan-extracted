#!perl -T

use strict;
use warnings;

use lib 't';

use Test::More ;
use FormatTests::Factory;

BEGIN { use_ok( 'VendorAPI::2Checkout::Client' ) || print "Bail out!\n"; }

sub test_list_options {
    my $tco = shift;
    my $format_tests = shift;

    my $r = $tco->list_options();
    if (defined $ENV{VAPI_HAS_OPTIONS} && $ENV{VAPI_HAS_OPTIONS} > 0 ) {
       $format_tests->has_records($r, 'options');
    }
    else {
       $format_tests->has_none($r);
    }
}

SKIP: {
  foreach my $moosage ( 0..1  ) {
    foreach my $format ( 'XML', 'JSON'  ) {
       skip "VAPI_2CO_UID && VAPI_2CO_PWD not set in environment" , 3 unless $ENV{VAPI_2CO_UID} && $ENV{VAPI_2CO_PWD};
       my $tco = VendorAPI::2Checkout::Client->get_client( $ENV{VAPI_2CO_UID}, $ENV{VAPI_2CO_PWD}, $format, $moosage );
       my $format_tests = FormatTests::Factory->get_format_tests($format);
       ok(defined $tco, "get_client: got object");
       test_list_options($tco, $format_tests);
    }
  }
}  # SKIP

done_testing();
