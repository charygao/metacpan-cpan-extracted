use strict;
use warnings;
use Test::More;

use_ok 'Data::Object::Array';
# deprecated
# can_ok 'Data::Object::Array', 'exists';

use Scalar::Util 'refaddr';

subtest 'test the exists method' => sub {
  my $array = Data::Object::Array->new([1 .. 5]);

  my @argument = (5);
  my $exists   = $array->exists(@argument);

  isnt refaddr($array), refaddr($exists);
  is $exists, 0;

  isa_ok $array,  'Data::Object::Array';
  isa_ok $exists, 'Data::Object::Number';
};

ok 1 and done_testing;
