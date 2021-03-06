#!/usr/bin/perl

use IO::Socket::CLI::POP3;

my $pop3 = IO::Socket::CLI::POP3->new(HOST => 'pop.mail.yahoo.com');

$pop3->debug(0);

unless ($pop3->is_open()) {
    sleep 1;
    $pop3->is_open() || die "Connection not open at " . $pop3->socket->peerhost . " port " . $pop3->socket->peerport . "\n";
}

$pop3->read();

do {
    $pop3->prompt();
    $pop3->read();
} while ($pop3->is_open());
