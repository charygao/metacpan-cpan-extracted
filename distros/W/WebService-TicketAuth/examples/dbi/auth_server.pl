#!/usr/bin/perl -w
use strict;

use lib '.';

use SOAP::Transport::HTTP;
use Example::Service;
use Example::TicketAuth;
use WebService::TicketAuth;
use WebService::TicketAuth::DBI;

# Make unbuffered
$|=1;

our $opt_config_file = 'service.cfg';

sub main {
    print "Starting SOAP server\n";
    my $daemon = SOAP::Transport::HTTP::Daemon
        -> new (LocalPort => 8082, Reuse => 1, Listen => 5 )
        -> dispatch_to('Example::Service')
        -> options({compress_threshold => 10000})
        ;

    print "Contact to SOAP server at ", $daemon->url, "\n";
    $daemon->handle;
    exit 1;
}

exit main();

