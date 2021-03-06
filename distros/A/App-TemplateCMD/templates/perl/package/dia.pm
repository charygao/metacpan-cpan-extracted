[% IF not vars %][% vars = [ 'search' ] %][% END -%]
[% IF not module %][% module = 'Module::Name' %][% END -%]
package [% module %];

# Created on: [% date %] [% time %]
# Create by:  [% contact.fullname or user %]
# $Id$
# $Revision$, $HeadURL$, $Date$
# $Revision$, $Source$, $Date$

use strict;
use warnings;
use version;
use Carp;
use Scalar::Util;
use List::Util;
#use List::MoreUtils;
use Data::Dumper qw/Dumper/;
use English qw/ -no_match_vars /;
use base qw/Exporter/;

our $VERSION     = version->new('0.0.1');
our @EXPORT_OK   = qw//;
our %EXPORT_TAGS = ();
#our @EXPORT      = qw//;

[% funcs = sigs.join(',') %]
[%- sigs = funcs.split('\)') %]
[%- FOREACH sig = sigs %]
[%- matches = sig.match('^,?(\w+)[(](.*)$') -%]
sub [% matches.0 %] {

[% IF matches.0 == 'new' -%]
	my ($caller, %param) = @_;
	my $class = ref $caller ? ref $caller : $caller;
	my $self  = \%param;

	[%- FOREACH param = matches.1.split(',') %]
	carp "Missing [% param %]" if !$param{'[% param %]'};
	[%- END %]

	bless $self, $class;
[%- ELSE %]
	my ( $self, %args ) = @_;

	[%- FOREACH param = matches.1.split(',') %]
	carp "Missing [% param %]" if !$args{'[% param %]'};
	[%- END %]
[%- END %]

	return;
}

[% END %]

1;

 =__END__

=head1 NAME

[% module %] - <One-line description of module's purpose>

[% INCLUDE perl/pod/VERSION.pl %]
[% INCLUDE perl/pod/SYNOPSIS.pl %]
[% INCLUDE perl/pod/DESCRIPTION.pl %]
[% INCLUDE perl/pod/METHODS.pl %]

[% FOREACH sig = sigs %]
[%- matches = sig.match('^,?(\w+)[(](.*)$') -%]
=head3 C<[% matches.0 %] ([% matches.1.split(',').join(', ') %])>
[% FOREACH arg = matches.1.split(',') %]
Arg: C<[% arg %]> - type (detail) - description
[% END %]
Return: type - description

Description:

[% END %]

[% INCLUDE perl/pod/detailed.pl %]
=head1 AUTHOR

[% contact.fullname %] - ([% contact.email %])

=head1 LICENSE AND COPYRIGHT
[% INCLUDE licence.txt %]
=cut
