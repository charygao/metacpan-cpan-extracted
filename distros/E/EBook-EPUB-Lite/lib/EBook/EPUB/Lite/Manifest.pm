# Copyright (c) 2009, 2010 Oleksandr Tymoshenko <gonzo@bluezbox.com>
# All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.

# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
package EBook::EPUB::Lite::Manifest;

use Moo;
use Types::Standard qw/ArrayRef Object/;
use EBook::EPUB::Lite::Manifest::Item;

has items => (
    is         => 'ro',
    isa        => ArrayRef[Object],
    default    => sub { [] },
);

sub all_items {
    my $self = shift;
    return @{$self->items};
}

sub encode
{
    my ($self, $writer) = @_;
    $writer->startTag("manifest");
    foreach my $item (@{$self->items()}) {
        $item->encode($writer);
    }
    $writer->endTag("manifest");
}

sub add_item
{
    my ($self, @args) = @_;
    my $item = EBook::EPUB::Lite::Manifest::Item->new(@args);
    push @{$self->items()}, $item;
}

1;

__END__

=head1 NAME

EBook::EPUB::Lite::Manifest

=head1 SYNOPSIS

Class that represents B<manifest> element of OPF document


=head1 DESCRIPTION

The required B<manifest> provides a list of all the files that are part of
the publication (e.g. Content Documents, style sheets, image files, any
embedded font files, any included schemas).

=head1 SUBROUTINES/METHODS

=over 4

=item add_item(%opts)

Add refrence to an OPS Content Document that is a part of publication. %opts is
an anonymous hash, for possible key values see L<EBook::EPUB::Lite::Manifest::Item>

=item all_items()

Returns array of EBook::EPUB::Lite::Manifest::Item objects, current content of B<manifest> element

=item encode($xmlwriter)

Encode object to XML form using XML::Writer instance

=item new()

Create new object

=back

=head1 AUTHOR

Oleksandr Tymoshenko, E<lt>gonzo@bluezbox.comE<gt>

=head1 BUGS

Please report any bugs or feature requests to  E<lt>gonzo@bluezbox.comE<gt>

=head1 LICENSE AND COPYRIGHT

Copyright 2009, 2010 Oleksandr Tymoshenko.

L<http://bluezbox.com>

This module is free software; you can redistribute it and/or
modify it under the terms of the BSD license. See the F<LICENSE> file
included with this distribution.
