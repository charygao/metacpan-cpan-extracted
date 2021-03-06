#!perl

use Test::More;

eval "use Test::Perl::Critic";
if ($@) {
    Test::More::plan(
        skip_all => "Test::Perl::Critic required for testing PBP compliance"
    );
}

my $rcfile = File::Spec->catfile( 't', 'perlcriticrc' );
Test::Perl::Critic->import( -profile => $rcfile );

Test::Perl::Critic::all_critic_ok();
