#######################################################################
# $Date$
# $Revision$
# $Author$
# ex: set ts=8 sw=4 et
#########################################################################
package WWW::Bebo::API::Users;

use warnings;
use strict;
use Carp;

use version; our $VERSION = qv('0.0.03');

sub get_info { return shift->base->call( 'users.getInfo', @_ ); }

sub get_logged_in_user {
    return shift->base->call( 'users.getLoggedInUser', @_ );
}

sub has_app_permission {
    return shift->base->call( 'users.hasAppPermission', @_ );
}

sub is_app_added {
    return shift->base->call( 'users.isAppAdded', @_ );
}

sub set_status {
    return shift->base->call( 'users.setStatus', @_ );
}

1;    # Magic true value required at end of module
__END__

=head1 NAME

WWW::Bebo::API::Users - Bebo Users

=head1 VERSION

This document describes WWW::Bebo::API::Users version 0.0.03

=head1 SYNOPSIS

    use WWW::Bebo::API;

=head1 DESCRIPTION

Methods for accessing users with L<WWW::Bebo::API>

=head1 SUBROUTINES/METHODS 

=over

=item base

Returns the L<WWW::Bebo::API> base object.

=item new

Constructor.

=item get_info( uids => $uids, fields => $fields )

The users.getInfo method of the Bebo API:

    $response = $client->users->get_info(
        uids => [ 2343, 3435 ],
        fields => 'about_me'
    );
    $response = $client->users->get_info(
        uids => 2343,
        fields => [ qw/about_me quotes/ ]
    );

=item get_logged_in_user

The users.getLoggedInUser method of the Bebo API:

    $uid = $client->users->get_logged_in_user;

=item has_app_permission

The users.hasAppPermission method of the Bebo API:

    $response = $client->users->has_app_permission(
        ext_perm => 'status_update|photo_upload'
    );

=item is_app_added

The users.isAppAdded method of the Bebo API:

    $app_added = $client->users->is_app_added;

=item set_status

The users.setStatus method of the Bebo API:

    $response = $client->users->set_status(
        status => 'status message',
        clear => 1|0,
    );

=back

=head1 DIAGNOSTICS

None.

=head1 CONFIGURATION AND ENVIRONMENT

WWW::Bebo::API::Users requires no configuration files or environment
variables.

=head1 DEPENDENCIES

See L<WWW::Bebo::API>

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-www-bebo-api@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.

=head1 AUTHOR

David Romano  C<< <unobe@cpan.org> >>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2007, David Romano C<< <unobe@cpan.org> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENSE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
