# -*- Mode: CPerl -*-
use Test::More; #tests=>23;
use DDC::PP;

##-- CQAnd: perl only
my $qa = DDC::PP::CQTokExact->new('','a');
my $qb = DDC::PP::CQTokExact->new('','b');
my $qc = DDC::PP::CQTokExact->new('','c');
my $qand = DDC::PP::CQAnd->new($qa,$qb);
ok($qa && $qb && $qc, "CQAnd:args");
ok($qand, "CQAnd:obj");
is($qand->toString, q((@a && @b)), "CQAnd:str");
$qand->setDtr2($qc);
is($qand->toString, q((@a && @c)), "CQAnd:setDtr2:str");

##-- CQOr: parsed
my $qor = DDC::PP->parse('a || b');
ok($qor, "CQOr:parse");
is($qor->getDtr1->toString, "a", "CQOr:dtr1:str");
is($qor->getDtr2->toString, "b", "CQOr:dtr2:str");

##-- CQSeq
my $qseq = DDC::PP->parse('"@foo #2 @bar #=1 @{baz,bonk}"');
my $items = $qseq->getItems;
my $ops   = $qseq->getDistOps;
ok($qseq, "CQSeq:parse");
ok($items && UNIVERSAL::isa($items,'ARRAY') && @$items == 3, "CQSeq:items");
ok($ops   && UNIVERSAL::isa($ops,'ARRAY') && join(' ',@$ops) eq '< =', "CQSeq:ops");
$_ = '=' foreach (@$ops);
$qseq->setDistOps($ops);
ok(!(grep {$_ ne '='} @{$qseq->getDistOps||[]}), "CQSeq:ops:set");

##-- CQSet
my $qset = DDC::PP->parse('@{blip,blop}');
my $vals = $qset->getValues;
ok($qset, "CQSet:parse");
is(join(' ', sort @{$vals||[]}), 'blip blop', "CQSet:vals");
$vals = [qw(a b c)];
$qset->setValues($vals);
is(join(' ', sort @{$qset->getValues||[]}), 'a b c', "CQSet:vals:set");

##-- CQRegex
my $qre = DDC::PP->parse('/flip\.flop/');
ok($qre, "CQRegex:parse");
is($qre->getValue, "flip\\.flop", "CQRegex:value");

##-- CQRegex: mantis #47973
my $restr = 'slash\/escape';
$qre = DDC::PP->parse( "/$restr/" );
is($qre->getValue, $restr, 'CQRegex:slash-escape:value' );
is($qre->toString, "/$restr/", 'CQRegex:slash-escape:toString' );


##-- expanders
my $qx = DDC::PP->parse('foo |bar|baz');
ok($qx, "expanders:parse");
is(join(' ',@{$qx->getExpanders||[]}), 'bar baz', "expanders:chain");

##-- WITH aliases
my $qwith = DDC::PP->parse('foo &= bar');
ok($qwith && $qwith->isa('DDC::PP::CQWith'), "with:&=");

my $qwithor = DDC::PP->parse('foo |= bar');
ok($qwithor && $qwithor->isa('DDC::PP::CQWithor'), "withor:|=");

my $qwithout = DDC::PP->parse('foo != bar');
ok($qwithout && $qwithout->isa('DDC::PP::CQWithout'), "without:!=");

##-- CQAndImplicit
my $qandi = DDC::PP->parse('foo bar');
ok($qandi && $qandi->isa('DDC::PP::CQAndImplicit'), "implicit-and:isa");
ok($qandi && $qandi->isa('DDC::PP::CQAnd'),         "implicit-and:isa(and)");

print "\n";
done_testing();
