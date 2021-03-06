
use Test::More qw(no_plan);

use Text::vFile::Base;

# Parallels 03_multi - but will pass the data as a string to parser
open DAT, "t/03_multi.dat";
undef $/;
my $dat=<DAT>;

my $vfile=Text::vFile::Base->loader( source_text => $dat );

use Data::Dumper;
$Data::Dumper::Indent=1;

my $count=0;
while (my $card = $vfile->next) {
	$count++;
    ok ( exists $card->{'ADR'}, "ADR loaded");
    is ( scalar( @{$card->{'ADR'}}), 3, "3 addresses loaded");
    ok ( exists $card->{'PHOTO'}, "PHOTO loaded");
    ok ( exists $card->{'VERSION'}, "VERSION loaded");
}

is ( $count, 6, "six cards loaded");
