#!perl
use 5.20.0;
use strict;
use warnings FATAL => 'all';
use lib 't';
use Mail::BIMI::Pragmas;
use Test::More;
use Mail::BIMI;
use Mail::BIMI::Record;
use Mail::DMARC::PurePerl;
use Net::DNS::Resolver::Mock 1.20200214;

my $bimi = Mail::BIMI->new();

my $resolver = Net::DNS::Resolver::Mock->new;
$resolver->zonefile_read('t/zonefile');
$bimi->resolver($resolver);

my $dmarc = Mail::DMARC::PurePerl->new;
$dmarc->result->result( 'pass' );
$dmarc->result->disposition( 'reject' );
$bimi->dmarc_object( $dmarc->result );

$resolver->die_on( 'default._bimi.gallifreyburning.com', 'TXT', 'Fail' );
$bimi->domain( 'gallifreyburning.com' );
$bimi->selector( 'foobarMISSING' );

my $record = $bimi->record;

is_deeply(
    [ $record->is_valid, $record->error ],
    [ 0, ['DNS query error'] ],
    'Test record validates'
);

my $expected_data = {};

is_deeply( $record->record, $expected_data, 'Parsed data' );

my $expected_url_list = [];
is_deeply( $record->locations->location, $expected_url_list, 'URL list' );

my $result = $bimi->result;
my $auth_results = $result->get_authentication_results;
my $expected_result = 'bimi=none (DNS query error)';
is( $auth_results, $expected_result, 'Auth results correcct' );

done_testing;
