use 5.014;

use strict;
use warnings;

use Test::More;

# POD

=name

Data::Object::String::Func::Le

=abstract

Data-Object String Function (Le) Class

=synopsis

  use Data::Object::String::Func::Le;

  my $func = Data::Object::String::Func::Le->new(@args);

  $func->execute;

=inherits

Data::Object::String::Func

=attributes

arg1(StringLike, req, ro)
arg2(StringLike, req, ro)

=libraries

Data::Object::Library

=description

Data::Object::String::Func::Le is a function object for Data::Object::String.

=cut

# TESTING

use_ok 'Data::Object::String::Func::Le';

ok 1 and done_testing;
