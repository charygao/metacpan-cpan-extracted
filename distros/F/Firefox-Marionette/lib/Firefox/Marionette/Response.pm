package Firefox::Marionette::Response;

use strict;
use warnings;
use Firefox::Marionette::Exception::NotFound();
use Firefox::Marionette::Exception::NoSuchAlert();
use Firefox::Marionette::Exception::StaleElement();
use Firefox::Marionette::Exception::InsecureCertificate();
use Firefox::Marionette::Exception::Response();

our $VERSION = '0.98';

sub _TYPE_INDEX            { return 0 }
sub _MESSAGE_ID_INDEX      { return 1 }
sub _ERROR_INDEX           { return 2 }
sub _RESULT_INDEX          { return 3 }
sub _DEFAULT_RESPONSE_TYPE { return 1 }

my %_known_exceptions = (
    'stale element reference' => 'Firefox::Marionette::Exception::StaleElement',
    'no such alert'           => 'Firefox::Marionette::Exception::NoSuchAlert',
    'insecure certificate' =>
      'Firefox::Marionette::Exception::InsecureCertificate',
);

sub new {
    my ( $class, $message, $parameters ) = @_;
    my $response;
    if ( ref $message eq 'ARRAY' ) {
        $response = bless {
            type       => $message->[ _TYPE_INDEX() ],
            message_id => $message->[ _MESSAGE_ID_INDEX() ],
            error      => $message->[ _ERROR_INDEX() ],
            result     => $message->[ _RESULT_INDEX() ],
        }, $class;
    }
    else {
        if ( $message->{error} ) {
            my $error;
            if ( ref $message->{error} ) {
                $error = $message->{error};
            }
            else {
                $error = $message;
            }
            if ( !defined $error->{error} ) {
                $error->{error} = q[];
            }
            if ( !defined $error->{message} ) {
                $error->{message} = q[];
            }
            $response = bless {
                type       => _DEFAULT_RESPONSE_TYPE(),
                message_id => undef,
                error      => $error,
                result     => undef,
            }, $class;
        }
        else {
            $response = bless {
                type       => _DEFAULT_RESPONSE_TYPE(),
                message_id => undef,
                error      => undef,
                result     => $message,
            }, $class;
        }
    }
    if ( $response->error() ) {
        if (
            ( $response->error()->{error} eq 'no such element' )
            || ( $response->error()->{message} =~
                /^Unable[ ]to[ ]locate[ ]element/smx )
          )
        {
            Firefox::Marionette::Exception::NotFound->throw( $response,
                $parameters );
        }
        elsif ( my $class = $_known_exceptions{ $response->error()->{error} } )
        {
            $class->throw( $response, $parameters );
        }
        else {
            Firefox::Marionette::Exception::Response->throw($response);
        }
    }
    return $response;
}

sub type {
    my ($self) = @_;
    return $self->{type};
}

sub message_id {
    my ($self) = @_;
    return $self->{message_id};
}

sub error {
    my ($self) = @_;
    return $self->{error};
}

sub result {
    my ($self) = @_;
    return $self->{result};
}

1;    # Magic true value required at end of module
__END__

=head1 NAME

Firefox::Marionette::Response - Represents a Marionette protocol response

=head1 VERSION

Version 0.98

=head1 SYNOPSIS

    use Firefox::Marionette();
    use v5.10;

=head1 DESCRIPTION

This module handles the implementation of a Marionette protocol response.  This should not be used by users of L<Firefox::Marionette|Firefox::Marionette>

=head1 SUBROUTINES/METHODS

=head2 new
 
accepts a reference to an array as a parameter.  The four components of a Marionette Response are below

=over 4

=item * type - This should be type 

=item * message_id - the identifier to allow Marionette to track request / response pairs

=item * error - the value of an error (if the response is an error, an L<exception|Firefox::Marionette::Exception::Response> is thrown)

=item * result - the object that is returned from the browser

=back

This method returns a new L<response|Firefox::Marionette::Response> object.
 
=head2 type

returns the type of the response.

=head2 message_id

returns the message_id of the response.

=head2 error

returns the error of the response or undef.

=head2 result

returns the result value.

=head1 DIAGNOSTICS

None.

=head1 CONFIGURATION AND ENVIRONMENT

Firefox::Marionette::Response requires no configuration files or environment variables.

=head1 DEPENDENCIES

None.

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-firefox-marionette@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.

=head1 AUTHOR

David Dick  C<< <ddick@cpan.org> >>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2019, David Dick C<< <ddick@cpan.org> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic/perlartistic>.

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
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
