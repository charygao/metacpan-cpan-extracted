## no critic qw(RequirePodSections)    # -*- cperl -*-
# This file is auto-generated by the Perl TeX::Hyphen::Pattern Suite hyphen
# pattern catalog generator. This code generator comes with the
# TeX::Hyphen::Pattern module distribution in the tools/ directory
#
# Do not edit this file directly.

package TeX::Hyphen::Pattern::Quote_rm 0;
use strict;
use warnings;
use 5.014000;
use utf8;

use Moose;

my $pattern_file = q{};
while (<DATA>) {
    $pattern_file .= $_;
}

sub data {
    return $pattern_file;
}

sub version {
    return $TeX::Hyphen::Pattern::Quote_rm::VERSION;
}

1;
## no critic qw(RequirePodAtEnd RequireASCII ProhibitFlagComments)

=encoding utf8

=head1 C<Quote_rm> hyphenation pattern class

=head1 SUBROUTINES/METHODS

=over 4

=item $pattern-E<gt>data();

Returns the pattern data.

=item $pattern-E<gt>version();

Returns the version of the pattern package.

=back

=head1 Copyright

The copyright of the patterns is not covered by the copyright of this package
since this pattern is generated from the source at
L<svn://tug.org/texhyphen/trunk/hyph-utf8/tex/generic/hyph-utf8/patterns/quote/hyph-quote-rm.tex>

The copyright of the source can be found in the DATA section in the source of
this package file.

=cut

__DATA__
\bgroup
\lccode`\’=`\’
\patterns{
2’2
2’.
2b’
2c’
2ch’.
2ch’’
2d’
2f’
2g’
2h’
2j’
2k’
2l’.
2l’’
2m’
2n’
2p’
2q’
2r’
4s’.
4s’’
2sch’
2schs’
2sh’
2st’
4tsch’
4tschs’
2t’.
2t’’
2v’.
2v’’
2w’
2x’
2z’.
2z’’
}
\egroup

