package Mail::MtPolicyd::Plugin::Stress;

use Moose;
use namespace::autoclean;

our $VERSION = '2.05'; # VERSION
# ABSTRACT: mtpolicyd plugin for postfix stress mode

extends 'Mail::MtPolicyd::Plugin';

with 'Mail::MtPolicyd::Plugin::Role::UserConfig' => {
	'uc_attributes' => [ 'action' ],
};
with 'Mail::MtPolicyd::Plugin::Role::PluginChain';

use Mail::MtPolicyd::Plugin::Result;


has 'action' => ( is => 'rw', isa => 'Maybe[Str]' );

sub run {
	my ( $self, $r ) = @_;
	my $session = $r->session;
	my $stress = $r->attr('stress');

	if( defined $stress && $stress eq 'yes' ) {
		$self->log($r, 'MTA has stress feature turned on');

		my $action = $self->get_uc($session, 'action');
		if( defined $action ) {
			return Mail::MtPolicyd::Plugin::Result->new(
				action => $action,
				abort => 1,
			);
		}
		if( defined $self->chain ) {
			my $chain_result = $self->chain->run( $r );
			return( @{$chain_result->plugin_results} );
		}
	}

	return;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Mail::MtPolicyd::Plugin::Stress - mtpolicyd plugin for postfix stress mode

=head1 VERSION

version 2.05

=head1 DESCRIPTION

Will return an action or execute further plugins if postfix signals stress.

See postfix STRESS_README.

=head1 PARAMETERS

An action must be specified:

=over

=item action (default: empty)

The action to return when under stress.

=item Plugin (default: empty)

Execute this plugins when under stress.

=back

=head1 EXAMPLE: defer clients when under stress

To defer clients under stress:

  <Plugin stress>
    module = "Stress"
    action = "defer please try again later"
  </Plugin>

This will return an defer action and execute no further tests.

You may want to do some white listing for preferred clients before this action.

=head1 AUTHOR

Markus Benning <ich@markusbenning.de>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by Markus Benning <ich@markusbenning.de>.

This is free software, licensed under:

  The GNU General Public License, Version 2, June 1991

=cut
