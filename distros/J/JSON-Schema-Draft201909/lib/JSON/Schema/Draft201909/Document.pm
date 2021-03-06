use strict;
use warnings;
package JSON::Schema::Draft201909::Document;
# vim: set ts=8 sts=2 sw=2 tw=100 et :
# ABSTRACT: One JSON Schema document

our $VERSION = '0.012';

use 5.016;
no if "$]" >= 5.031009, feature => 'indirect';
use Mojo::URL;
use Carp 'croak';
use JSON::MaybeXS 1.004001 'is_bool';
use Ref::Util 0.100 qw(is_plain_arrayref is_plain_hashref);
use List::Util 1.29 'pairs';
use Safe::Isa;
use Moo;
use MooX::TypeTiny;
use MooX::HandlesVia;
use Types::Standard qw(InstanceOf HashRef Str Dict HasMethods);
use namespace::clean;

extends 'Mojo::JSON::Pointer';

has schema => (
  is => 'ro',
  required => 1,
);

has canonical_uri => (
  is => 'rwp',
  isa => InstanceOf['Mojo::URL'], # always fragmentless
  lazy => 1,
  default => sub { Mojo::URL->new },
  coerce => sub { $_[0]->$_isa('Mojo::URL') ? $_[0] : Mojo::URL->new($_[0]) },
);

has resource_index => (
  is => 'bare',
  isa => HashRef[Dict[
      canonical_uri => InstanceOf['Mojo::URL'],
      path => Str,  # always a json pointer, relative to the document root
    ]],
  handles_via => 'Hash',
  handles => {
    resource_index => 'elements',
    _add_resources => 'set',
    _get_resource => 'get',
    _remove_resource => 'delete',
    _resource_pairs => 'kv',
  },
  init_arg => undef,
  lazy => 1,
  default => sub { {} },
);

# for internal use only
has serialized_schema => (
  is => 'rw',
  isa => Str,
  init_arg => undef,
);

before _add_resources => sub {
  my $self = shift;
  foreach my $pair (pairs @_) {
    my ($key, $value) = @$pair;
    if (my $existing = $self->_get_resource($key)) {
      croak 'a schema resource is already indexed with uri "'.$key.'"'
        if $existing->{path} ne $value->{path}
          or $existing->{canonical_uri} ne $value->{canonical_uri};
    }

    croak sprintf('canonical_uri cannot contain a plain-name fragment (%s)', $value->{canonical_uri})
      if ($value->{canonical_uri}->fragment // '') =~ m{^[^/]};
  }
};

# shims for Mojo::JSON::Pointer
sub data { goto \&schema }
sub FOREIGNBUILDARGS { () }

sub BUILD {
  my $self = shift;

  croak 'canonical_uri cannot contain a fragment' if defined $self->canonical_uri->fragment;

  my $original_uri = $self->canonical_uri->clone;
  my $schema = $self->schema;
  my %identifiers = _traverse_for_identifiers($schema, '', $original_uri->clone);

  if (is_plain_hashref($self->schema) and my $id = $self->get('/$id')) {
    $self->_set_canonical_uri(Mojo::URL->new($id)) if $id ne $self->canonical_uri;
  }

  # make sure the root schema is always indexed against *something*.
  $identifiers{$original_uri} = { path => '', canonical_uri => $self->canonical_uri }
    if (not "$original_uri" and $original_uri eq $self->canonical_uri)
      or ("$original_uri" and not exists $identifiers{$original_uri});

  $self->_add_resources(%identifiers);
}

sub _traverse_for_identifiers {
  my ($data, $path, $canonical_uri) = @_;
  my %identifiers;
  if (is_plain_arrayref($data)) {
    return map
      __SUB__->($data->[$_], jsonp($path, $_),
        $canonical_uri->clone->fragment($canonical_uri->fragment.'/'.$_)),
      0 .. $#{$data};
  }
  elsif (is_plain_hashref($data)) {
    if (exists $data->{'$id'} and JSON::Schema::Draft201909->_is_type('string', $data->{'$id'})) {
      my $uri = Mojo::URL->new($data->{'$id'});
      if (not length $uri->fragment) {
        $canonical_uri = $uri->is_abs ? $uri : $uri->base($canonical_uri)->to_abs;
        $canonical_uri->fragment(undef);
        $identifiers{$canonical_uri} = { path => $path, canonical_uri => $canonical_uri->clone };
      }
    }
    if (exists $data->{'$anchor'} and JSON::Schema::Draft201909->_is_type('string', $data->{'$anchor'})
        and $data->{'$anchor'} =~ /^[A-Za-z][A-Za-z0-9_:.-]+$/) {
      my $uri = Mojo::URL->new->base($canonical_uri)->to_abs->fragment($data->{'$anchor'});
      $identifiers{$uri} = { path => $path, canonical_uri => $canonical_uri->clone };
    }

    return
      %identifiers,
      map
        __SUB__->($data->{$_}, jsonp($path, $_),
          $canonical_uri->clone->fragment(jsonp($canonical_uri->fragment, $_))),
        keys %$data;
  }

  return ();
}

# shorthand for creating and appending json pointers
use namespace::clean 'jsonp';
sub jsonp {
  return join('/', (shift // ''), map s/~/~0/gr =~ s!/!~1!gr, @_);
}

1;

__END__

=pod

=encoding UTF-8

=for stopwords subschema

=head1 NAME

JSON::Schema::Draft201909::Document - One JSON Schema document

=head1 VERSION

version 0.012

=head1 SYNOPSIS

    use JSON::Schema::Draft201909::Document;

    my $document = JSON::Schema::Draft201909::Document->new(
      canonical_uri => 'https://example.com/v1/schema',
      schema => $schema,
    );
    my $foo_definition = $document->get('/$defs/foo');
    my %resource_index = $document->resource_index;

=head1 DESCRIPTION

This class represents one JSON Schema document, to be used by L<JSON::Schema::Draft201909>.

=head1 ATTRIBUTES

=head2 schema

The actual raw data representing the schema.

=head2 canonical_uri

When passed in during construction, this represents the initial URI by which the document should
be known. It is overwritten with the root schema's C<$id> property when one exists, and as such
can be considered the canonical URI for the document as a whole.

=head2 resource_index

An index of URIs to subschemas (json path to reach the location, and the canonical uri of that
location) for all identifiable subschemas found in the document. An entry for URI C<''> is added
only when no other suitable identifier can be found for the root schema.

This attribute should only be used by L<JSON::Schema::Draft201909> and not intended for use
externally (you should use the public accessors in L<JSON::Schema::Draft201909> instead).

=head1 METHODS

=for Pod::Coverage BUILD FOREIGNBUILDARGS

=head2 contains

Check if L</"schema"> contains a value that can be identified with the given JSON Pointer.
See L<Mojo::JSON::Pointer/contains>.

=head2 get

Extract value from L</"schema"> identified by the given JSON Pointer.
See L<Mojo::JSON::Pointer/get>.

=head1 SUPPORT

Bugs may be submitted through L<https://github.com/karenetheridge/JSON-Schema-Draft201909/issues>.

I am also usually active on irc, as 'ether' at C<irc.perl.org> and C<irc.freenode.org>.

=head1 AUTHOR

Karen Etheridge <ether@cpan.org>

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2020 by Karen Etheridge.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
