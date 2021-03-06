use strict;
use Socket;
use Email::Simple;
use Email::Simple::Creator;
use Email::MessageID;
use Test::More;
use POE qw(Component::Server::SimpleSMTP Component::Client::SMTP);

my $from = 'chris@bingosnet.co.uk';
my $to = 'gumby@gumbybra.in';
my %data = (
	from => $from,
	to => $to,
	email => Email::Simple->create(
      		header => [
				'Message-ID' => '<12345@foobar>',
        			From    => $from,
        			To      => $to,
        			Subject => 'Message in a bottle',
      		],
      		body => 'My bRain hUrts!',
	)->as_string(), 
	tests => [ 
		[ 220 => 'noop' ], 
		[ 250 => "expn blah" ],
		[ 502 => "vrfy $to" ],
		[ 252 => "mail from: <$from>" ],
		[ 250 => "rcpt to: <$to>" ],
		[ 250 => "data" ],
	],
);

plan tests => 17;

POE::Session->create(
  package_states => [
	'main' => [qw(
			_start
			_sock_up
			_sock_fail
			_sock_in
			_sock_err
			_local_recipient
			smtpd_registered
			smtpd_connection
			smtpd_disconnected
	)],
  ],
  heap => \%data,
);

$poe_kernel->run();
exit 0;

sub _start {
  $_[HEAP]->{smtpd} = POE::Component::Server::SimpleSMTP->spawn(
	address => '127.0.0.1',
	port => 0,
	handlers => [
	   {
	      	SESSION => $_[SESSION]->ID(),
		EVENT   => '_local_recipient',
		MATCH   => 'gumbybra.in$',
	   },
	],
	options => { trace => 0 },
  );
  isa_ok( $_[HEAP]->{smtpd}, 'POE::Component::Server::SimpleSMTP' );
  return;
}

sub smtpd_registered {
  my ($heap,$object) = @_[HEAP,ARG0];
  isa_ok( $object, 'POE::Component::Server::SimpleSMTP' );
  $heap->{port} = ( sockaddr_in( $object->getsockname() ) )[0];
  $heap->{factory} = POE::Wheel::SocketFactory->new(
	RemoteAddress  => '127.0.0.1',
	RemotePort     => $heap->{port},
	SuccessEvent   => '_sock_up',
	FailureEvent   => '_sock_fail',
  );
  return;
}

sub _sock_up {
  my ($heap,$socket) = @_[HEAP,ARG0];
  delete $heap->{factory};
  $heap->{socket} = POE::Wheel::ReadWrite->new(
	Handle => $socket,
	InputEvent => '_sock_in',
	ErrorEvent => '_sock_err',
  );
  return;
}

sub _sock_fail {
  my $heap = $_[HEAP];
  delete $heap->{factory};
  $heap->{smtpd}->shutdown();
  return;
}

sub _sock_in {
  my ($heap,$input) = @_[HEAP,ARG0];
  my @parms = split /\s+/, $input;
  my $test = shift @{ $heap->{tests} };
  if ( $test and $test->[0] eq $parms[0] ) {
	pass($input);
	$heap->{socket}->put( $test->[1] );
	return;
  }
  pass($input);
  if ( $heap->{email} ) {
    $heap->{socket}->put( delete $heap->{email} );
    $heap->{socket}->put( '.' );
  } 
  else {
    $heap->{socket}->put('quit');
  }
  return;
}

sub _sock_err {
  delete $_[HEAP]->{socket};
  pass("Disconnected");
  $_[HEAP]->{smtpd}->shutdown();
  return;
}

sub smtpd_connection {
  pass($_[STATE]);
  return;
}

sub smtpd_disconnected {
  pass($_[STATE]);
  return;
}

sub _local_recipient {
  pass($_[STATE]);
  my $email = Email::Simple->new( $_[ARG0]->{msg} );
  return unless $email;
  my @messageids = $email->header("Message-ID");
  ok( scalar @messageids == 1, "Only one Message-ID header");
  ok( $_[ARG0]->{subject} eq 'Message in a bottle', 'There is a subject item' );
  diag("@messageids\n");
  return;
}
