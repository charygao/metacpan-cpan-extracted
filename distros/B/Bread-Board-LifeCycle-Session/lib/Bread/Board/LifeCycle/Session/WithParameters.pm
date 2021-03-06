package Bread::Board::LifeCycle::Session::WithParameters;

our $AUTHORITY = 'cpan:GSG';
our $VERSION   = '0.90';

use Moose::Role;
use Module::Runtime ();
use namespace::autoclean;

our $FLUSHER_ROLE = 'Bread::Board::Container::Role::WithSessions';

with 'Bread::Board::LifeCycle::Singleton::WithParameters';

### XXX: Lifecycle consumption happens after service construction,
### so we have pick a method that would get called after
### construction.  The 'get' method is pretty hot, so this should
### be done as fast as possible.

before get => sub {
    my $self = shift;

    # Assume we've already done this if any instance exists
    return if values %{$self->instances};

    Module::Runtime::require_module($FLUSHER_ROLE);

    my @containers = ($self->get_root_container);

    # Traverse the sub containers and apply the WithSessions role
    while (my $container = shift @containers) {
        push @containers, values %{$container->sub_containers};

        Class::MOP::class_of($FLUSHER_ROLE)->apply($container)
            unless $container->meta->does_role($FLUSHER_ROLE);
    }
};

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Bread::Board::LifeCycle::Session::WithParameters

=head1 VERSION

version v0.900.1

=head1 DESCRIPTION

This lifecycle type is a flushable version of L<Bread::Board::LifeCycle::Singleton::WithParameters>.  Like
L<Session|Bread::Board::LifeCycle::Session>, the same L<flush_session_instances|Bread::Board::Container::Role::WithSessions/flush_session_instances>
method is applied to all of its containers.

=head1 NAME

Bread::Board::LifeCycle::Session::WithParameters

=head1 VERSION

version 0.90

=head1 AUTHOR

Brendan Byrd C<< <BBYRD@CPAN.org> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2015 Grant Street Group

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=head1 AUTHOR

Grant Street Group <developers@grantstreet.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2015 - 2020 by Grant Street Group.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut
