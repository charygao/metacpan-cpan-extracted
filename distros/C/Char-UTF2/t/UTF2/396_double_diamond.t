# encoding: UTF2
# This file is encoded in UTF-2.
die "This file is not encoded in UTF-2.\n" if q{あ} ne "\xe3\x81\x82";

use UTF2;

print "1..1\n";
if ($] < 5.022) {
    for my $tno (1..1) {
        print qq{ok - $tno SKIP $^X @{[__FILE__]}\n};
    }
    exit;
}

eval q{ undef @ARGV; close STDIN; <<>> };
if (not $@) {
    print qq{ok - 1 <<>> $^X @{[__FILE__]}\n};
}
else {
    print qq{not ok - 1 <<>> $^X @{[__FILE__]}\n};
}

__END__
