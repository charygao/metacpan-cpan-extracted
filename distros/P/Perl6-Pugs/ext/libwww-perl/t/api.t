use v6-alpha;
use Test;

=head1 API Test

Tests that the same API gets exported as with the
Perl 5 version of the module.

=cut

my @api = < get getstore getprint mirror head >;
plan 1+@api;

use LWP::Simple; pass "(dummy instead of broken use_ok)";

for @api -> $function {
  ok( eval( "defined &$function" ), "$function is exported" );
};
