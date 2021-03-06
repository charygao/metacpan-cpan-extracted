package JavaScript::Code::Expression::Op::Multiplication;

use strict;
use vars qw[ $VERSION ];
use base qw[ JavaScript::Code::Expression::Op ];

$VERSION = '0.02';

=head1 NAME

JavaScript::Code::Expression::Op::Multiplication

=head1 METHODS

=head2 $self->precedence( )

=cut

sub precedence { return 20; }

=head2 $self->op( )

=cut

sub op         { return " * "; }

=head1 SEE ALSO

L<JavaScript::Code>

=head1 AUTHOR

Sascha Kiefer, C<esskar@cpan.org>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;

