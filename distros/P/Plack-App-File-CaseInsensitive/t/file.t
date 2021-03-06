use strict;
use Plack::Test;
use Test::More;
use HTTP::Request::Common;
use Plack::App::File::CaseInsensitive;

my $app = Plack::App::File::CaseInsensitive->new(file => 't/Foo');

test_psgi $app, sub {
    my $cb = shift;

    my $res = $cb->(GET "/");
    is $res->code, 200;
    like $res->content, qr/Plack/;

    $res = $cb->(GET "/whatever");
    is $res->content_type, 'text/plain';
    is $res->code, 200;
};

my $app_content_type = Plack::App::File::CaseInsensitive->new(
    file => 't/Foo',
    content_type => 'text/x-changes'
);

test_psgi $app_content_type, sub {
    my $cb = shift;

    my $res = $cb->(GET "/");
    is $res->code, 200;
    like $res->content, qr/Plack/;

    $res = $cb->(GET "/whatever");
    is $res->content_type, 'text/x-changes';
    is $res->code, 200;
};



done_testing;
