#######################################################################
# $Date: 2007-06-28 13:05:21 -0700 (Thu, 28 Jun 2007) $
# $Revision: 120 $
# $Author: david.romano $
# ex: set ts=8 sw=4 et
#########################################################################
use Test::More;
use WWW::Bebo::API;
use strict;
use warnings;

BEGIN {
    if ( 3 != grep { defined }
        @ENV{qw/WBA_API_KEY_TEST WBA_SECRET_TEST WBA_SESSION_KEY_TEST/} )
    {
        plan skip_all => 'Live tests require API key, secret, and session';
    }
    plan tests => 4;
}

my $api = WWW::Bebo::API->new( app_path => 'test' );

my $uid  = $api->users->get_logged_in_user;
my $time = time();

is keys %{ $api->fql->query( query => <<"")->[0] }, 3, 'fql has info';
SELECT name,status,about_me FROM user WHERE uid=$uid

my $empty;
my $empty_query = <<"";
SELECT pid FROM photo
WHERE aid=$time
    AND owner IN (SELECT uid FROM user WHERE uid=$uid)

$empty = $api->fql->query( query => $empty_query );
ok !$empty, 'empty result is empty';

$api->parse(0);
$empty = $api->fql->query( query => $empty_query );
is $empty, '{}', 'empty result w/o parse ok';

$api->format('XML');
$empty = $api->fql->query( query => $empty_query );
is $empty, <<"", 'empty result w/o parse and w/XML ok';
<?xml version="1.0" encoding="UTF-8"?>
<fql_query_response xmlns="http://api.bebo.com/1.0/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" list="true"/>

# end
