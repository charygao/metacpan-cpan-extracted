
BEGIN { $| = 1; print "1..53\n"; }
END {print "not ok 1\n" unless $loaded;}

use ShiftJIS::String qw(:kana :H2Z :Z2H toupper tolower);

$^W = 1;
$loaded = 1;
print "ok 1\n";

#####

{
  my $wiwewakake = 'îďěŠŻAETURS';

  foreach $ary (
    [ \&kataH2Z,  'îďěŠŻAETURS',    0 ],
    [ \&kanaH2Z,  'îďěŠŻAETURS',    0 ],
    [ \&hiraH2Z,  'îďěŠŻAETURS',    0 ],
    [ \&kataZ2H,  'îďěŠŻąłŢ˛´ÜśšłTURS',           8 ],
    [ \&kanaZ2H,  '˛´ÜśšąłŢ˛´ÜśšłTURS',               13 ],
    [ \&hiraZ2H,  '˛´ÜśšAETURS',         5 ],
    [ \&hiXka,    'JP ¤JîďěŠŻ¤RSTU', 17 ],
    [ \&hi2ka,    'JPAERSRS',    7 ],
    [ \&ka2hi,    'îďěŠŻ ¤JîďěŠŻ¤TUTU', 10 ],
    [ \&spaceH2Z, 'îďěŠŻAETURS',    0 ],
    [ \&spaceZ2H, 'îďěŠŻAETURS',    0 ],
    [ \&toupper,  'îďěŠŻAETURS',    0 ],
    [ \&tolower,  'îďěŠŻAETURS',    0 ],
  ) {
    $str = $wiwewakake;
    print &{ $ary->[0] }($str) eq $ary->[1]
	? "ok" : "not ok", " ", ++$loaded, "\n";
    print $str eq $wiwewakake
	? "ok" : "not ok", " ", ++$loaded, "\n";
    print &{ $ary->[0] }(\$str) eq $ary->[2]
	? "ok" : "not ok", " ", ++$loaded, "\n";
    print $str eq $ary->[1]
	? "ok" : "not ok", " ", ++$loaded, "\n";
  }
}
