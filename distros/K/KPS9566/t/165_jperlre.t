# encoding: KPS9566
use KPS9566;
print "1..1\n";

my $__FILE__ = __FILE__;

if ('-' =~ /(\d)/) {
    print "not ok - 1 $^X $__FILE__ not ('-' =~ /\\d/).\n";
}
else {
    print "ok - 1 $^X $__FILE__ not ('-' =~ /\\d/).\n";
}

__END__

