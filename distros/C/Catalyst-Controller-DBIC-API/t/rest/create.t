use strict;
use warnings;

use lib 't/lib';

my $base = 'http://localhost';

use RestTest;
use DBICTest;
use Test::More;
use Test::WWW::Mechanize::Catalyst 'RestTest';
use HTTP::Request::Common;
use JSON::MaybeXS;

my $json = JSON::MaybeXS->new(utf8 => 1);

my $mech = Test::WWW::Mechanize::Catalyst->new;
ok( my $schema = DBICTest->init_schema(), 'got schema' );

my $artist_create_url   = "$base/api/rest/artist";
my $producer_create_url = "$base/api/rest/producer";
my $track_create_url = "$base/api/rest/track";

# test validation when no params sent
{
    my $test_data = $json->encode( { wrong_param => 'value' } );
    my $req = PUT($artist_create_url);
    $req->content_type('text/x-json');
    $req->content_length(
        do { use bytes; length($test_data) }
    );
    $req->content($test_data);
    $mech->request($req);

    cmp_ok( $mech->status, '==', 400,
        'attempt without required params caught' );
    my $response = $json->decode( $mech->content );
    like(
        $response->{messages}->[0],
        qr/No value supplied for name and no default/,
        'correct message returned'
    );
}

# test default value used if default value exists
{
    my $test_data = $json->encode( {} );
    my $req = PUT($producer_create_url);
    $req->content_type('text/x-json');
    $req->content_length(
        do { use bytes; length($test_data) }
    );
    $req->content($test_data);
    $mech->request($req);
    cmp_ok( $mech->status, '==', 200,
        'default value used when not supplied' );
    ok( $schema->resultset('Producer')->find( { name => 'fred' } ),
        'record created with default name' );
}

# test create works as expected when passing required value
{
    my $test_data = $json->encode( { name => 'king luke' } );
    my $req = PUT($producer_create_url);
    $req->content_type('text/x-json');
    $req->content_length(
        do { use bytes; length($test_data) }
    );
    $req->content($test_data);
    $mech->request($req);
    cmp_ok( $mech->status, '==', 200, 'request with valid content okay' );
    my $new_obj =
        $schema->resultset('Producer')->find( { name => 'king luke' } );
    ok( $new_obj, 'record created with specified name' );

    my $response = $json->decode( $mech->content );
    is_deeply(
        $response->{list},
        { $new_obj->get_columns },
        'json for new producer returned'
    );
}

# test bulk create
{
    my $test_data = $json->encode(
        { list => [ { name => 'king nperez' }, { name => 'queen perla' } ] }
    );
    my $req = PUT($producer_create_url);
    $req->content_type('text/x-json');
    $req->content_length(
        do { use bytes; length($test_data) }
    );
    $req->content($test_data);
    $mech->request($req);
    cmp_ok( $mech->status, '==', 200, 'request with valid content okay' );
    my $rs =
        $schema->resultset('Producer')
        ->search( [ { name => 'king nperez' }, { name => 'queen perla' } ] );
    ok( $rs, 'record created with specified name' );

    my $response = $json->decode( $mech->content );
    my $expected =
        [ map { my %foo = $_->get_inflated_columns; \%foo; } $rs->all ];
    is_deeply( $response->{list}, $expected,
        'json for bulk create returned' );
}

# test bulk create with database error
{
    my $test_data = $json->encode({
        list => [
            {
                cd => 2,
                position => 4,
                title => "Foobar",
            },
            {
                cd => 2,
                # set position column to NULL to force error
                position => undef,
                title => "Foobar",
            },
        ]
    });
    #my $req = PUT( $tracks_update_url, Content => $test_data );
    my $req = PUT($track_create_url);
    $req->content_type('text/x-json');
    $req->content_length(
        do { use bytes; length($test_data) }
    );
    $req->content($test_data);
    $mech->request($req);
    cmp_ok( $mech->status, '==', 400, 'bulk request with one invalid object fails' );
    my $rs =
        $schema->resultset('Track')
        ->search( [ { cd => 2 } ] );
    is( $rs->count, 3, 'no records created' );

    my $response = $json->decode( $mech->content );
    is( $response->{success}, JSON::MaybeXS::false,
        'success property returns unquoted false' );
    like(
        $response->{messages}->[0],
        qr/a database error has occured/,
        'correct message returned'
    );
}

done_testing();
