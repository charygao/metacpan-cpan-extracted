use strict;
use warnings;
use FindBin qw($RealBin);
use Test::More;
use FASTX::Reader;
my $seq_file = "$RealBin/../data/comments.fasta";

# TEST: Retrieves sequence COMMENTS from a FASTA file

# Check required input file
if (! -e $seq_file) {
  print STDERR "ERROR TESTING: $seq_file not found\n";
  exit 0;
}

my $data = FASTX::Reader->new({ filename => "$seq_file" });

while (my $seq = $data->getRead() ) {
	my $comment = $seq->{comment};
	ok( length( $comment ) > 0, "[FASTA COMMENT] comment found: $comment");
	my (undef, $len) = split /=/, $comment;

	die "Comment in <$seq> is malformed: expecting len=INT but <$comment> found.\n" unless ($len > 0);
	ok( $len = length($seq->{seq}), "[FASTA COMMENT] Comment parsed: $len bp in comment matches sequence length");
}

done_testing();
