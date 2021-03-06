package AddressBook;

use strict;
use warnings;

our $VERSION = '0.01';

use base 'GENAddressBook';


#-----------------------------------------------------------------
# $self->do_main(  )
#-----------------------------------------------------------------
# This method inherited from GENAddressBook

#-----------------------------------------------------------------
# $self->site_links(  )
#-----------------------------------------------------------------
# This method inherited from GENAddressBook


#-----------------------------------------------------------------
# $self->init( $r )
#-----------------------------------------------------------------
# This method inherited from GENAddressBook

1;

=head1 NAME

AddressBook - the base module of this web app

=head1 SYNOPSIS

This package is meant to be used in a stand alone server/CGI script or the
Perl block of an httpd.conf file.

Stand Alone Server or CGI script:

    use AddressBook;

    my $cgi = Gantry::Engine::CGI->new( {
        config => {
            #...
        },
        locations => {
            '/' => 'AddressBook',
            #...
        },
    } );

httpd.conf:

    <Perl>
        # ...
        use AddressBook;
    </Perl>

If all went well, one of these was correctly written during app generation.

=head1 DESCRIPTION

This module was originally generated by Bigtop.  But feel free to edit it.
You might even want to describe the table this module controls here.

=head1 METHODS

=over 4

=item get_orm_helper


=back


=head1 METHODS INHERITED FROM GENAddressBook

=over 4

=item namespace

=item init

=item do_main

=item site_links

=item schema_base_class


=back


=head1 SEE ALSO

    Gantry
    GENAddressBook
    AddressBook::Family
    AddressBook::Child

=head1 AUTHOR

Phil Crow, E<lt>phil@localdomainE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 Phil Crow

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.6 or,
at your option, any later version of Perl 5 you may have available.

=cut
