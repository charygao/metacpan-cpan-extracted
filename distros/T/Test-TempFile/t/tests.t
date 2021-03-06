# Tests of Test::TempFile test methods (empty_ok, content_is etc.)
use Test::More 0.96;
use Test2::API qw(intercept);
use Test::Exception;
use strict;
use warnings;

use Test::TempFile;
use Path::Tiny qw(path);

# Everything should be tested in chain context, to ensure we don't forget
# a "return $self". Use code coverage to ensure all functions are checked.

subtest 'Empty file pass' => sub {
    my $t = Test::TempFile->new;

    my $ret;
    my $events = intercept {
        $ret = $t->empty_ok('empty')
          ->exists_ok('exists')
          ->assert(sub { 1 }, 'assert')
          ->content_is('', 'content_is');
    };
    is( @$events, 4, '4 events' );
    ok( $events->[$_]->pass, "event $_ passed" ) for (0..3);

    is( $events->[0]->summary, 'empty' );
    is( $events->[1]->summary, 'exists' );
    is( $events->[2]->summary, 'assert' );
    is( $events->[3]->summary, 'content_is' );

    is( "$ret", "$t", 'content_is returns $self' );
};

subtest 'Empty file fail' => sub {
    my $t = Test::TempFile->new;

    my $ret;
    my $events = intercept {
        $ret = $t->not_empty_ok('not_empty')
            ->not_exists_ok('not_exists')
            ->assert(sub { 0 }, 'assert')
            ->content_is('foo', 'content_is')
            ->content_like(qr/./, 'content_like');
    };
    # We don't care about diag events - these are generated by Test::Builder
    $events = [ grep { !$_->isa('Test2::Event::Diag') } @$events ];

    is( @$events, 5, '5 events' );
    ok( !$events->[$_]->pass, "event $_ failed" ) for (0..4);

    is( $events->[0]->summary, 'not_empty' );
    is( $events->[1]->summary, 'not_exists' );
    is( $events->[2]->summary, 'assert' );
    is( $events->[3]->summary, 'content_is' );
    is( $events->[4]->summary, 'content_like' );

    is( "$ret", "$t", 'content_like returns $self' );
};

subtest 'File with contents' => sub {
    my $t = Test::TempFile->new;
    path($t->path)->spew_utf8("foo");

    my $events = intercept {
        $t->content_is("foo")
          ->content_like(qr/f/)
          ->assert(sub { $_->content =~ /f/ })
          ->not_empty_ok
          ->content_is("bar")
          ->content_like(qr/F/)
          ->assert(sub { $_->content =~ /F/ })
          ->empty_ok;
    };
    $events = [ grep { !$_->isa('Test2::Event::Diag') } @$events ];
    is( @$events, 8, '8 events' );
    ok( $events->[$_]->pass, "event $_ passed" ) for (0..3);
    ok( !$events->[$_]->pass, "event $_ failed" ) for (4..7);
};

subtest 'JSON' => sub {
    my $t = Test::TempFile->new;
    path($t->path)->spew_utf8('{ "a": [1, 2] }');

    my $events = intercept {
        $t->json_is({ a => [1, 2] }, 'json_is')
          ->json_is([]);
    };
    $events = [ grep { !$_->isa('Test2::Event::Diag') } @$events ];
    is( @$events, 2, '2 events' );
    ok( $events->[0]->pass, 'first json_is passed' );
    is( $events->[0]->summary, 'json_is' );
    ok( !$events->[1]->pass, 'second json_is failed' );
};

subtest 'YAML' => sub {
    my $t = Test::TempFile->new;
    path($t->path)->spew_utf8("---\na:\n - 1\n - 2\n");

    my $events = intercept {
        $t->yaml_is({ a => [1, 2] }, 'yaml_is')
          ->yaml_is([]);
    };
    $events = [ grep { !$_->isa('Test2::Event::Diag') } @$events ];
    is( @$events, 2, '2 events' );
    ok( $events->[0]->pass, 'first yaml_is passed' );
    is( $events->[0]->summary, 'yaml_is' );
    ok( !$events->[1]->pass, 'second yaml_is failed' );
};

subtest 'Assert failures' => sub {
    my $t = Test::TempFile->new;

    throws_ok { intercept { $t->assert() } }
        qr/missing coderef/;

    throws_ok { intercept { $t->assert([]) } }
        qr/first argument to assert\(\) must be a code reference/;

    throws_ok { intercept { $t->assert("foo") } }
        qr/first argument to assert\(\) must be a code reference/;

    my $events = intercept { $t->assert(sub { 1 }) };
    is( @$events, 1 );
    ok( $events->[0]->pass );
};

done_testing;
