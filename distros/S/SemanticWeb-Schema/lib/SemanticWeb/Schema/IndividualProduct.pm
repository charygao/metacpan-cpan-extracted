use utf8;

package SemanticWeb::Schema::IndividualProduct;

# ABSTRACT: A single, identifiable product instance (e

use Moo;

extends qw/ SemanticWeb::Schema::Product /;


use MooX::JSON_LD 'IndividualProduct';
use Ref::Util qw/ is_plain_hashref /;
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v9.0.0';


has serial_number => (
    is        => 'rw',
    predicate => '_has_serial_number',
    json_ld   => 'serialNumber',
);





1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SemanticWeb::Schema::IndividualProduct - A single, identifiable product instance (e

=head1 VERSION

version v9.0.0

=head1 DESCRIPTION

A single, identifiable product instance (e.g. a laptop with a particular
serial number).

=head1 ATTRIBUTES

=head2 C<serial_number>

C<serialNumber>

The serial number or any alphanumeric identifier of a particular product.
When attached to an offer, it is a shortcut for the serial number of the
product included in the offer.

A serial_number should be one of the following types:

=over

=item C<Str>

=back

=head2 C<_has_serial_number>

A predicate for the L</serial_number> attribute.

=head1 SEE ALSO

L<SemanticWeb::Schema::Product>

=head1 SOURCE

The development version is on github at L<https://github.com/robrwo/SemanticWeb-Schema>
and may be cloned from L<git://github.com/robrwo/SemanticWeb-Schema.git>

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
L<https://github.com/robrwo/SemanticWeb-Schema/issues>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Robert Rothenberg <rrwo@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018-2020 by Robert Rothenberg.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
