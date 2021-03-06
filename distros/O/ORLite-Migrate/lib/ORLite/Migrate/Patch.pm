package ORLite::Migrate::Patch;

# A convenience module for writing migration patches.
# Based on Padre::DB::Patch.

use 5.006;
use strict;
use warnings;
use Exporter ();
use DBI      ();

use vars qw{$VERSION @ISA @EXPORT $FILE};
BEGIN {
	$VERSION = '1.10';
	@ISA     = 'Exporter';
	@EXPORT  = qw{
		file
		dbh
		do
		selectall_arrayref
		selectall_hashref
		selectcol_arrayref
		selectrow_array
		selectrow_arrayref
		selectrow_hashref
		pragma
		table_exists
		column_exists
	};

	# The location of the SQLite database file
	$FILE = undef;
}

sub file {
	unless ( $FILE ) {
		# The filename is passed on STDIN
		$FILE = <STDIN>;
		chomp($FILE);
		unless ( -f $FILE and -w $FILE ) {
			die "SQLite file $FILE does not exist";
		}
	}
	return $FILE;
}

sub dbh {
	my $file = file();
	my $dbh  = DBI->connect(
		"dbi:SQLite:$file",
		undef, undef,
		{   RaiseError => 1,
		}
	);
	unless ($dbh) {
		die "Failed to connect to $file";
	}
	return $dbh;
}

sub do {
	dbh()->do(@_);
}

sub selectall_arrayref {
	dbh()->selectall_arrayref(@_);
}

sub selectall_hashref {
	dbh()->selectall_hashref(@_);
}

sub selectcol_arrayref {
	dbh()->selectcol_arrayref(@_);
}

sub selectrow_array {
	dbh()->selectrow_array(@_);
}

sub selectrow_arrayref {
	dbh()->selectrow_arrayref(@_);
}

sub selectrow_hashref {
	dbh()->selectrow_hashref(@_);
}

sub pragma {
	do("pragma $_[0] = $_[1]") if @_ > 2;
	selectrow_arrayref("pragma $_[0]")->[0];
}

sub table_exists {
	selectrow_array(
		"select count(*) from sqlite_master where type = 'table' and name = ?",
		{}, $_[0],
	);
}

sub column_exists {
	table_exists( $_[0] )
		or selectrow_array( "select count($_[1]) from $_[0]", {} );
}

1;
