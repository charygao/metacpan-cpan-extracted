# encoding: Greek
# This file is encoded in Greek.
die "This file is not encoded in Greek.\n" if q{あ} ne "\x82\xa0";

use Greek;
print "1..1\n";

my $__FILE__ = __FILE__;

if ('あいう' =~ /(あい?う)/) {
    if ("$1" eq "あいう") {
        print "ok - 1 $^X $__FILE__ ('あいう' =~ /あい?う/).\n";
    }
    else {
        print "not ok - 1 $^X $__FILE__ ('あいう' =~ /あい?う/).\n";
    }
}
else {
    print "not ok - 1 $^X $__FILE__ ('あいう' =~ /あい?う/).\n";
}

__END__
