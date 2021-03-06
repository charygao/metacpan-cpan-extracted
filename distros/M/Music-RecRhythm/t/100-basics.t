#!perl
#
# Music::RecRhythm basics (but no recursion)

use Test::Most;    # plan is down at bottom
my $deeply = \&eq_or_diff;

use Music::RecRhythm;

is( Music::RecRhythm->validate_set,      0, 'no set at all' );
is( Music::RecRhythm->validate_set("x"), 0, 'not array ref' );
is( Music::RecRhythm->validate_set( [] ), 0, 'empty set' );
is( Music::RecRhythm->validate_set( [ 1, 0, -8 ] ),
    0, 'non-positive set member' );
is( Music::RecRhythm->validate_set( [ 1, 2 ] ), 1, 'ok set' );

throws_ok(
    sub { Music::RecRhythm->new },
    qr/need a set of positive integers/,
    'no set set'
);
throws_ok(
    sub { Music::RecRhythm->new( set => "the cat god" ) },
    qr/need a set of positive integers/,
    'set not set'
);

my $x = Music::RecRhythm->new( set => [ 1, 7 ], is_silent => 1 );
is( $x->is_silent, 1, 'silent on' );
$x->is_silent(0);
is( $x->is_silent, 0, 'silent off' );

is( $x->count, 2, 'count of set elements' );
is( $x->sum,   8, 'sum of set elements' );

my $y;
lives_ok( sub { $y = $x->rebuild },
    'assuming MooX::Rebuild does its thing...' );
if ( defined $y ) {
    is( $y->is_silent, 1, 'silent on due to rebuild' );
}

# do next and prev linkages mostly kinda sorta work?
my $uno = Music::RecRhythm->new( set => [ 1, 1 ], is_silent => 1 );
my $dos = Music::RecRhythm->new( set => [ 2, 2, 2 ], is_silent => 0 );

$uno->next($dos);

is( $uno->next, $dos );
is( $uno->prev, undef );
is( $dos->prev, $uno );

# typically this would instead be some other object or MIDI track that
# events are put onto
$dos->extra("foo");
is( $dos->extra, "foo" );

plan tests => 17;
