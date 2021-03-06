# encoding: EUCJP
# This file is encoded in EUC-JP.
die "This file is not encoded in EUC-JP.\n" if q{あ} ne "\xa4\xa2";

use strict;
use EUCJP;
print "1..2\n";

my $__FILE__ = __FILE__;

$_ = 'あ';
if ($_ =~ s/(.)//b) {
    if (length($1) == 1) {
        print qq{ok - 1 \$_='あ'; \$_=~s/(.)//b; length(\$1)==1 $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 1 \$_='あ'; \$_=~s/(.)//b; length(\$1)==1 $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 1 \$_='あ'; \$_=~s/(.)//b; length(\$1)==1 $^X $__FILE__\n};
}

$_ = 'あ';
if ($_ =~ s'(.)''b) {
    if (length($1) == 1) {
        print qq{ok - 2 \$_='あ'; \$_=~s'(.)''b; length(\$1)==1 $^X $__FILE__\n};
    }
    else {
        print qq{not ok - 2 \$_='あ'; \$_=~s'(.)''b; length(\$1)==1 $^X $__FILE__\n};
    }
}
else {
    print qq{not ok - 2 \$_='あ'; \$_=~s'(.)''b; length(\$1)==1 $^X $__FILE__\n};
}

__END__

