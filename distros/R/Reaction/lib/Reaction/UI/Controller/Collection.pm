package Reaction::UI::Controller::Collection;

use Moose;
BEGIN { extends 'Reaction::UI::Controller'; }

use aliased 'Reaction::UI::ViewPort::Collection::Grid';

__PACKAGE__->config(
  action => {
    list => { Chained => 'base', PathPart => '' },
    object => { Chained => 'base', PathPart => 'id' },
    view => { Chained => 'object', },
  },
);

with(
  'Reaction::UI::Controller::Role::GetCollection',
  'Reaction::UI::Controller::Role::Action::Simple',
  'Reaction::UI::Controller::Role::Action::Object',
  'Reaction::UI::Controller::Role::Action::View',
  'Reaction::UI::Controller::Role::Action::List'
);

has default_member_actions => (
  isa => 'ArrayRef',
  is => 'rw',
  lazy_build => 1
);

has default_collection_actions => (
  isa => 'ArrayRef',
  is => 'rw',
  lazy_build => 1
);

sub _build_default_member_actions { ['view'] }

sub _build_default_collection_actions { [] }

around _build_action_viewport_map => sub {
  my $orig = shift;
  my $map = shift->$orig( @_ );
  $map->{list} = Grid;
  return $map;
};

around _build_action_viewport_args => sub {
  my $orig = shift;
  my $self = shift;
  my $args = { list => { Member => {} } };

   my $m_protos = $args->{list}{Member}{action_prototypes} = {};
   for my $action_name( @{ $self->default_member_actions }){
     my $label = join(' ', map { ucfirst } split(/_/, $action_name));
     my $proto = $self->_build_member_action_prototype($label, $action_name);
     $m_protos->{$action_name} = $proto;
   }

   my $c_protos = $args->{list}{action_prototypes} = {};
   for my $action_name( @{ $self->default_collection_actions }){
     my $label = join(' ', map { ucfirst } split(/_/, $action_name));
     my $proto = $self->_build_collection_action_prototype($label, $action_name);
     $c_protos->{$action_name} = $proto;
   }

  return $args;
};

sub _build_member_action_prototype {
  my ($self, $label, $action_name) = @_;
  return {
    label => $label,
    uri => sub {
      my $action = $self->action_for($action_name);
      $_[1]->uri_for($action, [ @{$_[1]->req->captures}, $_[0]->__id ]);
    },
  };
}

sub _build_collection_action_prototype {
  my ($self, $label, $action_name) = @_;
  return {
    label => $label,
    uri => sub {
      my $action = $self->action_for($action_name);
      $_[1]->uri_for($action, $_[1]->req->captures);
    },
  };
}


sub base :CaptureArgs(0) {
  my ($self, $c) = @_;
}

##DEPRECATED ACTION

sub basic_page {
  my( $self, $c, @args) = @_;
  if( $c->debug ){
    my ($package,undef,$line,$sub_name,@rest) = caller(1);
    my $message = "The method 'basic_page', called from sub '${sub_name}' in package ${package} at line ${line} is deprecated. Please use 'setup_viewport' instead.";
    $c->log->debug( $message );
  }
  $self->setup_viewport( $c, @args );
}

1;

__END__;

=head1 NAME

Reaction::UI::Controller::Collection

=head1 DESCRIPTION

Controller class used to make displaying collections easier.
Inherits from L<Reaction::UI::Controller>.

=head1 ROLES CONSUMED

This role also consumes the following roles:

=over4

=item L<Reaction::UI::Controller::Role::Action::GetCollection>

=item L<Reaction::UI::Controller::Role::Action::Simple>

=item L<Reaction::UI::Controller::Role::Action::Object>

=item L<Reaction::UI::Controller::Role::Action::List>

=item L<Reaction::UI::Controller::Role::Action::View>

=back

=head1 ATTRIBUTES

=head2 default_member_actions

Read-write lazy building arrayref. The names of the member actions (the actions
that apply to each member of the collection and typically have an object as a
target e.g. update,delete) to be enabled by default. By default, this is only
'view'

=over 4

=item B<_build_default_member_actions> - Provided builder method, see METHODS

=item B<has_default_member_actions> - Auto generated predicate

=item B<clear_default_member_actions>- Auto generated clearer method

=back

=head2 default_collection_actions

Read-write lazy building arrayref. The names of the collection actions (the
actions that apply to the entire collection and typically have a collection as
a target e.g. create, delete_all) to be enabled by default. By default, this
is only empty.

=over 4

=item B<_build_default_member_actions> - Provided builder method, see METHODS

=item B<has_default_member_actions> - Auto generated predicate

=item B<clear_default_member_actions>- Auto generated clearer method

=back

=head1 METHODS

=head2 _build_action_viewport_map

Set C<list> to L<Reaction::UI::ViewPort::Collection::Grid>

=head2 _build_action_viewport_args

By default will reurn a hashref containing action prototypes for all default
member and collection actions. The prototype URI generators are generated by
C<_build_member_action_prototype> and C<_build_collection_action_prototype>
respectively and labels are the result of replacing underscores in the name
with spaces and capitalizing the first letter. If you plan to use custom
actions that are not supported by this scheme or you would like to customize
the values it is suggested you wrap / override this method.

Default output for a controller having only 'view' enabled:

    { list => {
        action_prototypes => {},
        Member => {
          action_prototypes => {
            view => {label => 'View', uri => sub{...} },
          },
        },
      },
    }

=head2 _build_member_action_prototype $label, $action_name

Creates an action prototype suitable for creating action links in
L<Reaction::UI::ViewPort::Role::Actions>. C<$action_name> should be the name of
a Catalyst action in this controller.The prototype will generate a URI
based on the action, current captures.

=head2 _build_collection_action_prototype $label, $action_name

=head2 basic_page $c, \%vp_args

Deprecated alias to C<setup_viewport>.

=head1 ACTIONS

=head2 base

Chain link, no-op.

=head2 list

Chained to C<base>. See L<Reaction::UI::Controller::Role::Action::List>

=head2 object

Chained to C<base>. See L<Reaction::UI::Controller::Role::Action::Object>

=head2 view

Chained to C<object>. See L<Reaction::UI::Controller::Role::Action::View>

=head1 SEE ALSO

L<Reaction::UI::Controller>

=head1 AUTHORS

See L<Reaction::Class> for authors.

=head1 LICENSE

See L<Reaction::Class> for the license.

=cut
