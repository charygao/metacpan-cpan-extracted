#!/usr/bin/env perl

use strict qw(vars refs subs);
use Meta::Utils::System qw();
use Meta::Utils::Opts::Opts qw();
use Meta::Utils::Hash qw();
use Meta::Baseline::Aegis qw();
use Meta::Utils::Output qw();

my($newx,$modi,$dele,$srcx,$test,$abso);
my($opts)=Meta::Utils::Opts::Opts->new();
$opts->set_standard();
$opts->def_bool("new","should I list new files ?",1,\$newx);
$opts->def_bool("modified","should I list modifield files ?",1,\$modi);
$opts->def_bool("deleted","should I list deleted files ?",0,\$dele);
$opts->def_bool("srcx","should I list source files ?",1,\$srcx);
$opts->def_bool("test","should I list test files ?",1,\$test);
$opts->def_bool("absolute","use absolute pathnames ?",0,\$abso);
$opts->set_free_allo(0);
$opts->analyze(\@ARGV);

my($set)=Meta::Baseline::Aegis::source_files_set($newx,$modi,$dele,$srcx,$test,$abso);
$set->foreach(\&Meta::Utils::Output::println);

Meta::Utils::System::exit_ok();

__END__

=head1 NAME

base_aegi_source_files.pl - list source files using our own methods (perl).

=head1 COPYRIGHT

Copyright (C) 2001, 2002 Mark Veltzer;
All rights reserved.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111, USA.

=head1 DETAILS

	MANIFEST: base_aegi_source_files.pl
	PROJECT: meta
	VERSION: 0.29

=head1 SYNOPSIS

	base_aegi_source_files.pl

=head1 DESCRIPTION

This script is just a printing utility for the results of the library
function source_files_hash.
Adderess that functions documentation for explanation.

=head1 OPTIONS

=over 4

=item B<help> (type: bool, default: 0)

display help message

=item B<pod> (type: bool, default: 0)

display pod options snipplet

=item B<man> (type: bool, default: 0)

display manual page

=item B<quit> (type: bool, default: 0)

quit without doing anything

=item B<gtk> (type: bool, default: 0)

run a gtk ui to get the parameters

=item B<license> (type: bool, default: 0)

show license and exit

=item B<copyright> (type: bool, default: 0)

show copyright and exit

=item B<description> (type: bool, default: 0)

show description and exit

=item B<history> (type: bool, default: 0)

show history and exit

=item B<new> (type: bool, default: 1)

should I list new files ?

=item B<modified> (type: bool, default: 1)

should I list modifield files ?

=item B<deleted> (type: bool, default: 0)

should I list deleted files ?

=item B<srcx> (type: bool, default: 1)

should I list source files ?

=item B<test> (type: bool, default: 1)

should I list test files ?

=item B<absolute> (type: bool, default: 0)

use absolute pathnames ?

=back

no free arguments are allowed

=head1 BUGS

None.

=head1 AUTHOR

	Name: Mark Veltzer
	Email: mailto:veltzer@cpan.org
	WWW: http://www.veltzer.org
	CPAN id: VELTZER

=head1 HISTORY

	0.00 MV initial code brought in
	0.01 MV make quality checks on perl code
	0.02 MV more perl checks
	0.03 MV make Meta::Utils::Opts object oriented
	0.04 MV more harsh checks on perl code
	0.05 MV check that all uses have qw
	0.06 MV fix todo items look in pod documentation
	0.07 MV make all tests real tests
	0.08 MV more on tests/more checks to perl
	0.09 MV more on tests
	0.10 MV silense all tests
	0.11 MV more perl quality
	0.12 MV perl code quality
	0.13 MV more perl quality
	0.14 MV more perl quality
	0.15 MV revision change
	0.16 MV languages.pl test online
	0.17 MV perl packaging
	0.18 MV license issues
	0.19 MV md5 project
	0.20 MV database
	0.21 MV perl module versions in files
	0.22 MV thumbnail user interface
	0.23 MV more thumbnail issues
	0.24 MV website construction
	0.25 MV improve the movie db xml
	0.26 MV web site automation
	0.27 MV SEE ALSO section fix
	0.28 MV move tests to modules
	0.29 MV md5 issues

=head1 SEE ALSO

Meta::Baseline::Aegis(3), Meta::Utils::Hash(3), Meta::Utils::Opts::Opts(3), Meta::Utils::Output(3), Meta::Utils::System(3), strict(3)

=head1 TODO

-this script should be thrown once a new aegis is on the scene. We should ask aegis to provide the source manifest to cook and not do this through this tool. A change in cook is needed in order to do this...

-dire should be 0,1 or 2 only (dont accept any other values) (actually this is supposed to be an enumerated opts type...).
