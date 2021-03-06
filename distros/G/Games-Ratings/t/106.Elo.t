use strict;
use warnings;

use Games::Ratings::Chess::FIDE;

use Test::More tests => 3;

## see the following link for the official calculation (player Vladimir Kramnik)
## * http://ratings.fide.com/tournament_report.phtml?event16=42427
## see the following link for performance
## * http://www.chess.co.uk/twic/twic795.html#2

my %expected = (
                rating_change   => '1.9',
                performance     => '2801',
                points_expected => '7.81',
               );
my $player = Games::Ratings::Chess::FIDE->new();
$player->set_rating(2788);
$player->set_coefficient(10);
my @opponent_ratings =   (2662,2657,2641,2696,2708,2810,2749,2723,2790,2720,2712,2739,2675);
my @results          = qw(draw win  win  draw win  win  draw draw loss draw draw draw draw);
foreach my $game ( 0 .. $#results ) {
    $player->add_game( { opponent_rating => $opponent_ratings[$game],
                         result          => $results[$game], });  
}

my %computed;

## test 1: check rating change
$computed{rating_change} = $player->get_rating_change();

## test 2: check performance
$computed{performance} = $player->get_performance();

## test 3: check performance
$computed{points_expected} = $player->get_points_expected();

## run actual tests for all test_items in %expected
foreach my $test_item ( sort keys %expected ) {
    is( $computed{$test_item}, $expected{$test_item}, 
        "$test_item: $computed{$test_item} -> $expected{$test_item}" );
}

