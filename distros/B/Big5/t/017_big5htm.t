# encoding: Big5
# This file is encoded in Big5.
die "This file is not encoded in Big5.\n" if q{あ} ne "\x82\xa0";

use Big5;
print "1..1\n";

# マッチするはずなのにマッチしない（１）
if ("運転免許" =~ /運転/) {
    print qq<ok - 1 "UNTENMENKYO" =~ /UNTEN/\n>;
}
else {
    print qq<not ok - 1 "UNTENMENKYO" =~ /UNTEN/\n>;
}

__END__

Shift-JISテキストを正しく扱う
http://homepage1.nifty.com/nomenclator/perl/shiftjis.htm
