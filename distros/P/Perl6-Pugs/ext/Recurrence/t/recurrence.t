use v6-alpha;
use Test;

plan 41;

use Recurrence; pass "(dummy instead of broken use_ok)";

my $universe = Recurrence.new( 
    closure_next =>     sub ( $x is copy ) { return -Inf if $_ == -Inf; Inf if $_ ==  Inf; return $x + 1 },
    closure_previous => sub ( $x is copy ) { return  Inf if $_ ==  Inf; return -Inf if $_ == -Inf; return $x - 1 },
    :is_universe(1) );

isa_ok( $universe, 'Recurrence', 
    'created a Recurrence' );

is( $universe.start, -Inf, "start" );
is( $universe.end  ,  Inf, "end" );

is( $universe.stringify, '-Inf..Inf', 'stringify' );

is( $universe.next( 10 ), 11, 'next' );
is( $universe.previous( 10 ), 9, 'previous' );

is( $universe.intersects( $universe ), Bool::True, 'intersects with self' );

my $even_numbers = Recurrence.new( 
    closure_next =>     sub { return -Inf if $_ == -Inf; Inf if $_ ==  Inf; return 2 * int( $_ / 2 ) + 2 },
    closure_previous => sub { return  Inf if $_ ==  Inf; return -Inf if $_ == -Inf; return 2 * int( ( $_ - 2 ) / 2 ) },
    universe => $universe );
is( $even_numbers.next( 10 ), 12, 'next even' );
is( $even_numbers.previous( 10 ), 8, 'previous even' );

is( $even_numbers.closest( 10.0 ), 10, 'closest even' );
is( $even_numbers.closest( 10.2 ), 10, 'closest even' );
is( $even_numbers.closest( 11.8 ), 12, 'closest even' );

is( $even_numbers.current( 10.0 ), 10, 'current even' );
is( $even_numbers.current( 11.8 ), 10, 'current even' );

{
    # equal()
    is( $even_numbers.equal( $even_numbers ), Bool::True, 'equal self' );
    my $set1 = $even_numbers.union( $universe );
    is( $universe.equal( $set1 ), Bool::True, 'equal from union' );
    $set1 = $even_numbers.intersection( $universe );
    is( $even_numbers.equal( $set1 ), Bool::True, 'equal from intersection' );
    is( $even_numbers.equal( $universe ), Bool::False, 'not equal' );
    $set1 = $even_numbers.complement;
    is( $even_numbers.equal( $set1.complement ), Bool::True, 'equal from complement' );
}

# Test - generate complement using closures + universe
my $odd_numbers = $even_numbers.complement;
is( $odd_numbers.next( 10 ), 11, 'odd even' );
is( $odd_numbers.previous( 10 ), 9, 'odd even' );

{
    my $set = $universe.complement;
    is( $set.start,  Inf, "start empty set" );
    is( $set.end  , -Inf, "end" );
}
{
    # 0 .. Inf
    my $span1 = Recurrence.new( 
        closure_next =>        sub { $_ >= 0 ?? $_ + 1 !!    0 },
        closure_previous =>    sub { $_ > 0 ??  $_ - 1 !! -Inf },
        complement_next =>     sub { $_ < 1 ??  $_ + 1 !!  Inf },
        complement_previous => sub { $_ < 0 ??  $_ - 1 !!   -1 },
        universe => $universe );
    
    is( $span1.start,    0, "start" );
    is( $span1.end  ,  Inf, "end" );

    # -Inf .. 10
    my $span3 = Recurrence.new( 
        closure_next =>         sub { $_ < 10 ??  $_ + 1 !!  Inf },
        closure_previous =>     sub { $_ < 11 ??  $_ - 1 !!   10 },
        complement_next =>      sub { $_ >= 10 ?? $_ + 1 !!   11 },
        complement_previous =>  sub { $_ > 11 ??  $_ - 1 !! -Inf },
        universe => $universe );
    
    is( $span3.start, -Inf, "start" );
    is( $span3.end  ,   10, "end" );

    is( $span1.intersects( $span3 ), Bool::True, 'intersects' );

    {
        my $span2 = $span1.complement;
        is( $span2.start, -Inf, "start" );
        is( $span2.end  ,   -1, "end" );
    }
    {
        my $span4 = $span3.complement;
        is( $span4.start,   11, "start" );
        is( $span4.end  ,  Inf, "end" );
        # is( $span4.stringify, '11,12,13..Inf', "stringify" );
    }
    {
        my $span5 = $span1.intersection( $span3 );
        is( $span5.start,  0, "start" );
        is( $span5.end  , 10, "end" );
        # is( $span5.stringify, '0,1,2..8,9,10', "stringify" );
    }
    {
        my $span5 = $span1.difference( $span3 );
        is( $span5.start,  11, "start" );
        is( $span5.end  , Inf, "end" );
    }
    {
        my $span5 = $span3.difference( $span1 );
        is( $span5.start, -Inf, "start" );
        is( $span5.end  ,   -1, "end" );
    }
    {
        my $span5 = $span3.union( $span1 );
        is( $span5.start, -Inf, "start" );
        is( $span5.end  ,  Inf, "end" );
    }
}


=begin later

is( $span.intersects( $span2 ), Bool::True, 'intersects' );

is( $span.intersects( $span3 ), Bool::False, 'doesn\'t intersect' );

is( $span.intersection( $span2 ).stringify, '[2,3]', 'intersection' );

is( $span.union( $span2 ).stringify, '[1,4]', 'union' );

=cut
