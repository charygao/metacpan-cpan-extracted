#!perl

use Test::More;
use Test::Deep;
use Data::Dumper;
use autodie;

use Pg::Explain;

my @tests = @ARGV;
if ( 0 == scalar @tests ) {
    opendir( my $dir, 't/plans' );

    my %uniq = ();
    @tests = sort { $a <=> $b }
        grep { !$uniq{ $_ }++ }
        map  { s/-.*//; $_ }
        grep { /^\d+-(?:expect|plan)$/ } readdir $dir;

    closedir $dir;
}

plan 'tests' => 3 * scalar @tests;

for my $test ( @tests ) {

    print STDERR 'Working on test ' . $test . "\n" if $ENV{ 'DEBUG_TESTS' };

    my $plan_file = 't/plans/' . $test . '-plan';

    my $explain = Pg::Explain->new( 'source_file' => $plan_file );
    isa_ok( $explain, 'Pg::Explain' );

    my $expected = get_expected_from_file( $test );

    my $got = $explain->top_node->get_struct();
    print STDERR Dumper( $got ) if $ENV{ 'DEBUG_TESTS' };

    is( $explain->source_format, 'TEXT', 'Correct format detection' );
    cmp_deeply( $got, $expected, 'Plan no. ' . $test . ' passed as file.', );
}

exit;

sub get_expected_from_file {
    my $test_no = shift;

    my $filename = 't/plans/' . $test_no . '-expect';

    open my $fh, '<', $filename;
    local $/ = undef;
    my $expected_str = <$fh>;
    close $fh;

    my $expected = eval $expected_str;
    die $@ if $@;

    return $expected;
}
