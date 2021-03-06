use 5.014;

use strict;
use warnings;

use Test::More;

# POD

=name

Data::Object::Number::Func::Incr

=abstract

Data-Object Number Function (Incr) Class

=synopsis

  use Data::Object::Number::Func::Incr;

  my $func = Data::Object::Number::Func::Incr->new(@args);

  $func->execute;

=inherits

Data::Object::Number::Func

=attributes

arg1(NumberLike, req, ro)
arg2(StringLike, opt, ro)

=libraries

Data::Object::Library

=description

Data::Object::Number::Func::Incr is a function object for Data::Object::Number.

=cut

# TESTING

use_ok 'Data::Object::Number::Func::Incr';

ok 1 and done_testing;
