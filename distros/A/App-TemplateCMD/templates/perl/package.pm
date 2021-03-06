[% IF not vars %][% vars = [ 'search' ] %][% END -%]
[% IF not module -%]
    [%- IF out.match('^lib') -%]
        [%- out = out.replace('lib/', '') -%]
        [%- out = out.replace('[.]pm', '') -%]
        [%- out = out.replace('/', '::', 1) -%]
        [%- module = out -%]
    [%- END -%]
[% END -%]
[% IF not module  %][% module       = 'Module::Name' %][% END -%]
[% IF not version %][% version.perl = '0.001'        %][% END -%]
[% IF not base    %][% base         = 'Some::Thing'  %][% END -%]
package [% module %];

# Created on: [% date %] [% time %]
# Create by:  [% contact.fullname or user %]
# $Id$
# $Revision$, $HeadURL$, $Date$
# $Revision$, $Source$, $Date$

[% IF moose -%]
use Moose;
use namespace::autoclean;
[% ELSIF moo -%]
use Moo;
use warnings;
[% ELSE -%]
use strict;
use warnings;
[% END -%]
use version;
use Carp;
use Scalar::Util;
use List::Util;
#use List::MoreUtils;
use Data::Dumper qw/Dumper/;
use English qw/ -no_match_vars /;
[%- IF moose || moo %]

extends '[% base %]';
[%- ELSE %]
use base qw/[% base %]/;
[%- END %]

[% IF moose || moo -%]
our $VERSION = [% version.perl %];
[%- ELSE %]
our $VERSION     = [% version.perl %];
our @EXPORT_OK   = qw//;
our %EXPORT_TAGS = ();
#our @EXPORT      = qw//;
[%- END %]

[% IF !(moose || moo) -%]
sub new {
	my $caller = shift;
	my $class  = ref $caller ? ref $caller : $caller;
	my %param  = @_;
	my $self   = \%param;

	bless $self, $class;

	return $self;
}
[%- END %]

[% IF moose -%]
__PACKAGE__->meta->make_immutable;
[%- END %]

1;

 =__END__

=head1 NAME

[% module %] - <One-line description of module's purpose>

[% INCLUDE perl/pod/VERSION.pl %]
[% INCLUDE perl/pod/SYNOPSIS.pl %]
[% INCLUDE perl/pod/DESCRIPTION.pl %]
[% INCLUDE perl/pod/METHODS.pl %]

[% IF !moose -%]
[% INCLUDE perl/pod.pl return => module, sub => 'new' -%]
[% END %]

[% INCLUDE perl/pod/detailed.pl %]
=head1 AUTHOR

[% contact.fullname %] - ([% contact.email %])

=head1 LICENSE AND COPYRIGHT
[% INCLUDE licence.txt %]
=cut
