use v6-alpha;
use Test;

plan 4;

use Test::Builder::Test;

my $pass_test = Test::Builder::Test.new(
        number      => 1,     
        passed      => 1,
        description => 'first test description'
        );
is($pass_test.WHAT, ::Test::Builder::Test::Pass, '... we got a Test::Builder::Test::Pass instance');

my $fail_test = Test::Builder::Test.new(
        number      => 2,     
        passed      => 0,
        description => 'first test description'
        );
is($fail_test.WHAT, ::Test::Builder::Test::Fail, '... we got a Test::Builder::Test::Fail instance');

my $todo_test = Test::Builder::Test.new(
        number      => 3,     
        passed      => 1,
        description => 'first test description',
        todo        => 1,
        reason      => 'this is TODO',         
        );
is($todo_test.WHAT, ::Test::Builder::Test::TODO, '... we got a Test::Builder::Test::TODO instance');

my $skip_test = Test::Builder::Test.new(
        number      => 4,     
        passed      => 1,
        description => 'first test description',
        skip        => 1,
        reason      => 'this is TODO',         
        );
is($skip_test.WHAT, ::Test::Builder::Test::Skip, '... we got a Test::Builder::Test::Skip instance');
