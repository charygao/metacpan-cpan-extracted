package WebTerminal::Dispatcher;

use vars qw( $VERSION );
$VERSION = '0.1.0';
use strict;
use utf8;
#
# based on testmsg.pl from "Advanced Perl Programming"
#

use WebTerminal::Msg;
use Exporter;

our @ISA         = qw( Exporter );
our @EXPORT   = qw(send );
our @EXPORT_OK   = qw(send );
our %EXPORT_TAGS = (
	ALL     => [qw( send )],
	DEFAULT => [],
);

sub send {
	my $id   = shift;
	my $ip = shift;
	my $cmds  = shift;
	my $host = 'localhost';
	my $port = 2057;
	my $cmd='';
	my @cmdlines=split("\n",$cmds);
	for my $cmdline (reverse @cmdlines) {
		$cmdline=~/^\s*$/ && next;
		$cmdline=~/^(pugs|\.\.\.\.)\>\s+/ && do {
			$cmd=$cmdline;
			$cmd=~s/^(pugs|\.\.\.\.)\>\s+//;
			chomp $cmd;
			last;
		};
	} 
#   We're using PUGS_SAFEMODE=1 instead 
#    if ($cmd=~/\b(system|exec|fork|wait|open|slurp|eval|kill)\b|(\`)/) {
#    my $offending_command=$1||$2;
#    return "Sorry, \'$offending_command\' is not allowed.\npugs> ";
 #   } else {
    my $conn;
    my $ntries=5;
#    for (1..$ntries) {
	$conn = WebTerminal::Msg->connect( $host, $port, \&rcvd_msg_from_server );
#	die "Client could not connect to $host:$port ($wd)\n" unless $conn;
    if (not $conn) {
 #       # Assume server has died
#WV: disabled until stable
#       system("/usr/bin/perl ../bin/termserv.pl");
#       sleep 5;
#    } else {last;}
        return "Sorry, the pugs server is not running.";
    } else {
	my $msg = "$id\n$ip\n" . $cmd;
	$conn->send_now($msg);
	( my $rmesg, my $err ) = $conn->rcv_now();
	( my $rid, my $reply ) = split( "\n", $rmesg, 2 );
    $conn->disconnect();
	if ( "$id" ne  "$rid" ) {
#		die "Terminal server returned wrong id: $rid, should be $id";
        return "Sorry, the pugs session died.";
	}
	return $reply;
   }
}

sub rcvd_msg_from_server {
	my ( $conn, $msg, $err ) = @_;
	if ( defined $msg ) {
		die "Strange... shouldn't really be coming here\n";
	}
}
