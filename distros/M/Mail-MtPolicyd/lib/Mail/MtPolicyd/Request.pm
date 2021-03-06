package Mail::MtPolicyd::Request;

use Moose;
use namespace::autoclean;

use Mail::MtPolicyd::Plugin::Result;

our $VERSION = '2.05'; # VERSION
# ABSTRACT: the request object


has 'attributes' => (
	is => 'ro', isa => 'HashRef', required => 1,
	traits => [ 'Hash' ],
	handles => { 'attr' => 'get' },
);


# gets attached later
has 'session' => ( is => 'rw', isa => 'Maybe[HashRef]' );


has 'server' => (
	is => 'ro', isa => 'Net::Server', required => 1,
	handles => {
		'log' => 'log',
	}
);


has 'type' => (
	is => 'ro',
	isa => 'Str',
	lazy => 1,
	default => sub {
		my $self = shift;
		return( $self->attr('request') );
	}
);


has 'use_caching' => ( is => 'rw', isa => 'Bool', default => 1 );


sub dump_attr {
	my $self = shift;
	my $attr = $self->attributes;
	return( join(', ', map { $_.'='.$attr->{$_} } keys %$attr ) );
}


sub get {
  my ( $self, $value ) = @_;
  my ($scope, $name);

  if( ! defined $value || $value eq '' ) { return; }

  my @params = split(':', $value, 2);
  if( scalar(@params) == 2 ) {
    ( $scope, $name ) = @params;
  } elsif( scalar(@params) == 1) {
    ( $scope, $name ) = ( 'request', @params );
  }

  if( $scope eq 'session' || $scope eq 's' ) {
    if( ! defined $self->session ) {
      return;
    }
    return $self->session->{$name};
  } elsif( $scope eq 'request' || $scope eq 'r' ) {
    return $self->attr( $name );
  }

  die("unknown scope $scope while retrieving variable for $value");

  return;
}


sub new_from_fh {
	my ( $class, $fh ) = ( shift, shift );
	my $attr = {};
	my $complete = 0;
	my $line;
	while( defined( $line = $fh->getline ) ) {
		$line =~ s/\r?\n$//;
		if( $line eq '') { $complete = 1 ; last; }
		my ( $name, $value ) = split('=', $line, 2);
		if( ! defined $value ) {
			die('error parsing request');
		}
		$attr->{$name} = $value;
	}
	if( $fh->error ) {
		die('while reading request: '.$fh->error);
	}
	if( ! defined $line && ! $complete ) {
		die('connection closed by peer');
	}
	if( ! $complete ) {
		die('could not parse request');
	}
	my $obj = $class->new(
		'attributes' => $attr,
		@_
	);
	return $obj;
}


sub do_cached {
	my ( $self, $key, $call ) = @_;
	my $session = $self->session;

	# we cant cache a result without session
	if( ! defined $session || ! $self->use_caching ) {
		return( $call->() );
	}
	if( ! defined $session->{$key} ) {
		$session->{$key} = [ $call->() ];
	}
	return( @{$session->{$key}} );
}


sub is_already_done {
	my ( $self, $key ) = @_;
	my $session = $self->session;

	# we cant cache a result without session
	if( ! defined $session || ! $self->use_caching ) {
		return 0;
	}
	if( defined $session->{$key} ) {
		return(1);
	}
	$session->{$key} = 1;
	return 0;
}


sub is_attr_defined {
    my ( $self, @fields ) = @_;
    my $a = $self->attributes;

    foreach my $field ( @fields ) {
        if( ! defined $a->{$field}
                || $a->{$field} eq ''
                || $a->{$field} =~ /^\s+$/ ) {
            return 0;
        }
    }

    return 1;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Mail::MtPolicyd::Request - the request object

=head1 VERSION

version 2.05

=head1 ATTRIBUTES

=head2 attributes

Contains an HashRef with all attributes of the request.

To retrieve a single attribute the attr method could be used:

  $obj->attr('sender');

=head2 session

Contains a HashRef with all values stored in the session.

mtpolicyd will persist the content of this HashRef across requests with the same instance_id.

=head2 server

Contains the Net::Server object of mtpolicyd.

=head2 type

The type of the request. Postfix will always use 'smtpd_access_policy'.

=head2 use_caching

Could be used to disable caching. Only used within the unit tests.

=head1 METHODS

=head2 dump_attr

Returns an string to dump the content of a request.

=head2 get($variable_name)

Retrieve value of a session or request variable.

The format for the variable name is

  (<scope>:)?<variable>

If no scope is given it default to the request scope.

Valid scopes are:

=over

=item session, s

Session variables.

=item request, r

Request attributes.

=back

For example:

  $r->get('request:sender'); # retrieve sender from request
  $r->get('r:sender');       # short format
  $r->get('sender');         # scope defaults to request

  $r->get('session:user_policy'); # retrieve session variable user_policy
  $r->get('s:user_policy');       # the same

=head2 new_from_fh($fh)

An object constructor for creating an request object with the content read
for the supplied filehandle $fh.

Will die if am error ocours:

=over

=item error parsing request

A line in the request could not be parsed.

=item while reading request: <io-error>

The filehandle had an error while reading the request.

=item connection closed by peer

Connection has been closed while reading the request.

=item could not parse request

The client did not send a complete request.

=back

=head2 do_cached( $key, $sub )

This method will execute the function reference give in $sub and store
the return values in $key within the session.
If there is already a cached result stored within $key of the session
it will return the content instead of calling the reference again.

Returns an Array with the return values of the function call.

Example:

  my ( $ip_result, $info ) = $r->do_cached('rbl-'.$self->name.'-result',
    sub { $self->_rbl->check( $ip ) } );

=head2 is_already_done( $key )

This function will raise an flag with name of $key within the session and return true if the
flag is already set. False otherwise.

This could be used to prevent scores or headers from being applied a second time.

Example:

  if( defined $self->score && ! $r->is_already_done('rbl-'.$self->name.'-score') ) {
    $self->add_score($r, $self->name => $self->score);
  }

=head2 is_attr_defined

Returns true if all given attribute names are defined and non-empty.

=head1 AUTHOR

Markus Benning <ich@markusbenning.de>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by Markus Benning <ich@markusbenning.de>.

This is free software, licensed under:

  The GNU General Public License, Version 2, June 1991

=cut
