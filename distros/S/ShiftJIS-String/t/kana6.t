
BEGIN { $| = 1; print "1..101\n"; }
END {print "not ok 1\n" unless $loaded;}

use ShiftJIS::String qw(:kana :H2Z :Z2H toupper tolower);

$^W = 1;
$loaded = 1;
print "ok 1\n";

#####

{
  for $ary (
    [ \&kanaZ2H, qw/ EJ@EJBEJEJFEJH   ³ή§³ή¨³ή³ήͺ³ή«  14 / ],
    [ \&kataZ2H, qw/ EJ@EJBEJEJFEJH   ³ή§³ή¨³ή³ήͺ³ή«  14 / ],
    [ \&hiraZ2H, 'EJ@EJBEJEJFEJH',
                 'Eή@EήBEήEήFEήH',  5],
    [ \&kanaZ2H, qw/ €J€J‘€J€J₯€J§   ³ή§³ή¨³ή³ήͺ³ή«   9 / ],
    [ \&hiraZ2H, qw/ €J€J‘€J€J₯€J§   ³ή§³ή¨³ή³ήͺ³ή«   9 / ],
    [ \&kataZ2H, '€J€J‘€J€J₯€J§',
                 '€J€J‘€J€J₯€J§',  0 ],
    [ \&kanaH2Z, qw/ ±ρΏΙΝ ±ρΏΙΝ   0 / ],
    [ \&kanaH2Z, qw/ ΊέΖΑΚ      Rj`n   5 / ],
    [ \&kanaH2Z, qw/ Κί°Ω       p[       3 / ],
    [ \&kanaH2Z, qw/ ΜίΫΈήΧΡΎκ vOΎκ 5 / ],
    [ \&kanaH2Z, qw/ ΛήΐήΈ΅έ    r_NI   5 / ],
    [ \&kanaH2Z, qw/ Άί·ίΈίΉίΊί JKLKNKPKRK 10 / ],
    [ \&kanaH2Z, qw/ ¦ή‘       ¦JB       2 / ],
    [ \&kanaH2Z, qw/ ΄ή‘        GJB       3 / ],
    [ \&kanaH2Z, qw/ A³ή‘B      ABB       2 / ],
    [ \&kataH2Z, qw/ ±ρΏΙΝ ±ρΏΙΝ   0 / ],
    [ \&kataH2Z, qw/ ΊέΖΑΚ      Rj`n   5 / ],
    [ \&kataH2Z, qw/ Κί°Ω       p[       3 / ],
    [ \&hiraH2Z, qw/ ±ρΏΙΝ ±ρΏΙΝ   0 / ],
    [ \&hiraH2Z, qw/ ΊέΖΑΚ      ±ρΙΏΝ   5 / ],
    [ \&hiraH2Z, qw/ Κί°Ω       Ο[ι       3 / ],
    [ \&tolower, qw/  ’€¦ABCD±ρΏΙΝ  ’€¦abcd±ρΏΙΝ   4 / ],
    [ \&tolower, qw/ At@xbgπάάΘ’  At@xbgπάάΘ’ 0 / ],
    [ \&tolower, qw/ Perl_Module    perl_module   2 / ],
    [ \&tolower, qw/ oπg€ oπg€ 0 / ],
  ) {
    $str = $ary->[1];
    print &{ $ary->[0] }($str)  eq $ary->[2]
	? "ok" : "not ok", " ", ++$loaded, "\n";
    print $str eq $ary->[1]
	? "ok" : "not ok", " ", ++$loaded, "\n";
    print &{ $ary->[0] }(\$str) eq $ary->[3]
	? "ok" : "not ok", " ", ++$loaded, "\n";
    print $str eq $ary->[2]
	? "ok" : "not ok", " ", ++$loaded, "\n";
  }
}

