#   $Id: 62-perl-critic.t 51 2014-05-21 19:14:11Z adam $

use strict;
use warnings;
use File::Spec;
use Test::More;
use English qw(-no_match_vars);

if ( not $ENV{TEST_AUTHOR} ) {
    plan( skip_all => 'Author test. Set $ENV{TEST_AUTHOR} to a true value to run.' );
}

eval { require Test::Perl::Critic; };

if ( $EVAL_ERROR ) {
    plan( skip_all => 'Test::Perl::Critic required to criticise code' );
}

my $rcfile = File::Spec->catfile( 't', 'perlcriticrc' );
Test::Perl::Critic->import( -profile => $rcfile );
all_critic_ok();
