#!perl
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;
use Message::Match;
use Message::Transform;
use Data::Dumper;

BEGIN {
    use_ok('Message::SmartMerge') || print "Bail out!\n";
    use_ok('Message::SmartMerge::Test') || print "Bail out!\n";
}
*test = *Message::SmartMerge::Test::get_global_message;

ok my $merge = Message::SmartMerge->new(), 'constructor worked';

ok $merge->config({
    merge_instance => 'a',
});

#Let's do a pass-through to seed the instance; this is a common use-case
#It should pass right through
ok $merge->message({x => 'y', a => 'b', toggle => 't1', something => 'else', this => 'other'});
{   my $ret = test();
    ok$ret->{x} eq 'y', 'match correctly passed through';
    ok $ret->{toggle} eq 't1', 'toggle value correctly passed through';
    ok $ret->{a} eq 'b', 'instance variable correctly passed through';
    ok $ret->{this} eq 'other', 'thing to be transformed correctly did not transform';
}

#add a simple merge
ok $merge->add_merge({
    match => {x => 'y'},
    transform => {this => 'that'},
    toggle_fields => ['toggle'],
    merge_id => 'm1',
});
#in english, this will match any messages with x => 'y', will never
#expire (no expire field), will run the transform this => 'that',
#and the instance of the message is defined by whatever is in the 'a'
#field.  It will clear itself automatically if the value in the 'toggle'
#field changes from the value it had when the merge arrived.
#If a specific message instance has yet to be seen, and the matching merge is
#present, the value of the field referenced in 'toggle_fields' is captured
#at that point.

#since a matching instance existed per-merge, it should have fired immediately
{   my $ret = test();
    ok $ret->{x} eq 'y', 'match correctly passed through';
    ok $ret->{toggle} eq 't1', 'toggle value correctly passed through';
    ok $ret->{a} eq 'b', 'instance variable correctly passed through';
    ok $ret->{this} eq 'that', 'transform correctly ran';
    ok $ret->{something} eq 'else', 'previously seen stray passed through';
}

#Now hit the merge
ok $merge->message({x => 'y', a => 'b', toggle => 't1', this => 'nope'});
{   my $ret = test();
    ok $ret->{x} eq 'y', 'match passed through';
    ok $ret->{this} eq 'that', 'transformed correctly again';
    ok ((not defined $ret->{something}),'previous innocent bystandard correctly not passed');
}

#hit the toggle and make sure the merge is removed
ok $merge->message({x => 'y', a => 'b', toggle => 't2', this => 'new'});
{   my $ret = test();
    ok $ret->{x} eq 'y', 'match passed through';
    ok $ret->{this} eq 'new', 'transform did not fire; most recent value correctly passed';
    ok $ret->{toggle} eq 't2', 'new toggle value correctly passed through';
}

#and double-check we're back on pass-through
ok $merge->message({x => 'y', a => 'b', something => 'else'});
{   my $ret = test();
    ok $ret->{x} eq 'y', 'match passed after merge deallocation';
    ok $ret->{something} eq 'else', 'innocent bystandard STILL unmolested';
    ok ((not defined $ret->{this}), 'the transform correctly did not run');
}

done_testing();


