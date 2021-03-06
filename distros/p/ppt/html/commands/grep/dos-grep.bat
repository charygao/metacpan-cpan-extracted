@perl -w -S -x %0 %1 %2 %3 %4 %5 %6 %7 %8 %9
@goto endofperl
#!perl
use Getopt::Std;
my %opt;
getopts('iVcle:',\%opt);
my $pat = $opt{'e'} || shift;
# warn "Matching /$pat/\n";
my @args = splice(@ARGV,0);
foreach my $arg (@args)
 {
  push(@ARGV,glob($arg));
 }
my $count = 0;
while (<>)
 {
  if (($opt{i})? /$pat/io : /$pat/o)
   {
    $count++;
    print "$ARGV:$.:$_" unless ($opt{'c'} || $opt{'l'});
   } 
  if (eof)
   {
    printf("%5d $ARGV\n",$count) if ($opt{'V'} || $opt{'c'} && $count);
    print "$ARGV\n" if $opt{'l'};
    $count = 0;
    $. = 0;
   }
 }
__END__
:endofperl
