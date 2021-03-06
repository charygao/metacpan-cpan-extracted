package Config::Structured;
$Config::Structured::VERSION = '2.001';
# ABSTRACT: Provides generalized and structured configuration value access

use 5.022;

use Moose;
use Moose::Util::TypeConstraints;
use Mojo::DynamicMethods -dispatch;

use Syntax::Keyword::Junction;
use Carp;
use IO::All;
use List::Util qw(reduce);
use Data::DPath qw(dpath);

use Readonly;

use Config::Structured::Deserializer;

use Data::Printer;

use experimental qw(signatures lexical_subs);

# Symbol constants
Readonly::Scalar my $EMPTY => q{};
Readonly::Scalar my $SLASH => q{/};

# Token key constants
Readonly::Scalar my $DEF_ISA     => q{isa};
Readonly::Scalar my $DEF_DEFAULT => q{default};
Readonly::Scalar my $CFG_SOURCE  => q{source};
Readonly::Scalar my $CFG_REF     => q{ref};

# Token value constants
Readonly::Scalar my $CONF_FROM_FILE => q(file);
Readonly::Scalar my $CONF_FROM_ENV  => q(env);

# Method names that are needed by Config::Structured and cannot be overridden by config node names
Readonly::Array my @RESERVED =>
  qw(get meta BUILD BUILD_DYNAMIC _config _structure _base _add_helper __register_default __register_as);

#
# The configuration structure (e.g., $app.conf.def contents)
#
has '_structure_v' => (
  is       => 'ro',
  isa      => 'Str|HashRef',
  init_arg => 'structure',
  required => 1,
);

has '_structure' => (
  is       => 'ro',
  isa      => 'HashRef',
  init_arg => undef,
  lazy     => 1,
  default  => sub {Config::Structured::Deserializer->decode(shift->_structure_v)}
);

#
# The file-based configuration (e.g., $app.conf contents)
#
has '_config_v' => (
  is       => 'ro',
  isa      => 'Str|HashRef',
  init_arg => 'config',
  required => 1,
);

has '_config' => (
  is       => 'ro',
  isa      => 'HashRef',
  init_arg => undef,
  lazy     => 1,
  default  => sub {Config::Structured::Deserializer->decode(shift->_config_v)}
);

#
# This instance's base path (e.g., /db)
#   Recursively constucted through re-instantiation of non-leaf config nodes
#
has '_base' => (
  is      => 'ro',
  isa     => 'Str',
  default => $SLASH,
);

#
# Convenience method for adding dynamic methods to an object
#
sub _add_helper {
  Mojo::DynamicMethods::register __PACKAGE__, @_;
}

#
# Dynamically create methods at instantiation time, corresponding to configuration structure's dpaths
# Use lexical subs and closures to avoid polluting namespace unnecessarily (preserving it for config nodes)
#
sub BUILD ($self, $args) {
  # lexical subroutines

  state sub pkg_prefix($msg) {
    '[' . __PACKAGE__ . "] $msg";
  }

  state sub is_hashref($node) {
    return ref($node) eq 'HASH';
  }

  state sub is_leaf_node($node) {
    exists($node->{isa});
  }

  state sub is_ref_node ($def, $node) {
    return 0 if ($def->{isa} =~ /hash/i);
    return 0 unless (ref($node) eq 'HASH');
    return (exists($node->{$CFG_SOURCE}) && exists($node->{$CFG_REF}));
  }

  state sub ref_content_value($node) {
    my $source = $node->{$CFG_SOURCE};
    my $ref    = $node->{$CFG_REF};
    if ($source eq $CONF_FROM_FILE) {
      if (-f -r $ref) {
        chomp(my $contents = io->file($ref)->slurp);
        return $contents;
      }
    } elsif ($source eq $CONF_FROM_ENV) {
      return $ENV{$ref} if (exists($ENV{$ref}));
    }
    return;
  }

  state sub node_value ($el, $node) {
    if (defined($node)) {
      my $v = is_ref_node($el, $node) ? ref_content_value($node) : $node;
      return $v if (defined($v));
    }
    return $el->{$DEF_DEFAULT};
  }

  state sub concat_path {
    reduce {local $/ = $SLASH; chomp($a); join(($b =~ m|^$SLASH|) ? $EMPTY : $SLASH, $a, $b)} @_;
  }

  state sub typecheck ($isa, $value) {
    my $tc = Moose::Util::TypeConstraints::find_or_parse_type_constraint($isa);
    if (defined($tc)) {
      return $tc->check($value);
    } else {
      carp(pkg_prefix "Invalid typeconstraint '$isa'. Skipping typecheck");
      return 1;
    }
  }

  # Closures

  my $make_leaf_generator = sub ($el, $path) {
    return sub {
      my $isa = $el->{isa};
      my $v   = node_value($el, dpath($path)->matchr($self->_config)->[0]);
      if (defined($v)) {
        return $v if (typecheck($isa, $v));
        carp(pkg_prefix "Value '" . np($v) . "' does not conform to type '$isa' for node $path");
      }
      return;
    }
  };

  my $make_branch_generator = sub($path) {
    return sub {
      return __PACKAGE__->new(
        structure => $self->_structure,
        config    => $self->_config,
        _base     => $path
      );
    }
  };

  foreach my $el (dpath($self->_base)->match($self->_structure)) {
    if (is_hashref($el)) {
      foreach my $def (keys(%{$el})) {
        carp(pkg_prefix "Reserved word '$def' used as config node name: ignored") and next if ($def eq any(@RESERVED));
        $self->meta->remove_method($def)
          ;    # if the config node refers to a method already defined on our instance, remove that method
        my $path = concat_path($self->_base, $def);    # construct the new directive path by concatenating with our base

# Detect whether the resulting node is a branch or leaf node (leaf nodes are required to have an "isa" attribute, though we don't (yet) perform type constraint validation)
# if it's a branch node, return a new Config instance with a new base location, for method chaining (e.g., config->db->pass)
        $self->_add_helper(
          $def => (is_leaf_node($el->{$def}) ? $make_leaf_generator->($el->{$def}, $path) : $make_branch_generator->($path)));
      }
    }
  }
}

#
# Handle dynamic method dispatch
#
sub BUILD_DYNAMIC {
  my ($class, $method, $dyn_methods) = @_;
  return sub {
    my ($self, @args) = @_;
    my $dynamic = $dyn_methods->{$self}{$method};
    return $self->$dynamic(@args) if ($dynamic);
    my $package = ref $self;
    croak qq{Can't locate object method "$method" via package "$package"};
  }
}

#
# Saved Named/Default Config instances
#
our $saved_instances = {
  default => undef,
  named   => {}
};

#
# Instance method
# Saves the current instance as the default instance
#
sub __register_default($self) {
  $saved_instances->{default} = $self;
  return $self;
}

#
# Instance method
# Saves the current instance by the specified name
# Parameters:
#  Name (Str), required
#
sub __register_as ($self, $name) {
  croak 'Registration name is required' unless (defined $name);

  $saved_instances->{named}->{$name} = $self;
  return $self;
}

#
# Class method
# Return a previously saved instance. Returns undef if no instances have been saved. Returns the default instance if no name is provided
# Parameters:
#  Name (Str), optional
#
sub get ($class, $name = undef) {
  if (defined $name) {
    return $saved_instances->{named}->{$name};
  } else {
    return $saved_instances->{default};
  }
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Config::Structured - Provides generalized and structured configuration value access

=head1 VERSION

version 2.001

=head1 SYNOPSIS

  use Config::Structured;

  my $conf = Config::Structured->new(
    structure    => { ... },
    config       => { ... }
  );

  say $conf->some->nested->value();

=head1 DESCRIPTION

  L<Config::Structured> provides a structured method of accessing configuration values

  This is predicated on the use of a configuration C<structure> (required), This structure
  provides a hierarchical structure of configuration branches and leaves. Each branch becomes
  a L<Config::Structured> method which returns a new L<Config::Structured> instance rooted at
  that node, while each leaf becomes a method which returns the configuration value.

  The configuration value is normally provided in the C<config> hash. However, a C<config> node
  for a non-Hash value can be a hash containing the "source" and "ref" keys. This permits sourcing
  the config value from a file (when source="file") whose filesystem location is given in the "ref"
  value, or an environment variable (when source="env") whose name is given in the "ref" value.

  I<Structure Leaf Nodes> are required to include an "isa" key, whose value is a type 
  (see L<Moose::Util::TypeConstraints>). If typechecking is not required, use isa => 'Any'.
  There are a few other keys that L<Config::Structured> respects in a leaf node:

  =over

  =item C<default>

  This key's value is the default configuration value if a data source or value is not provided by
  the configuation.

  =item C<description>

  =item C<notes>

  A human-readable description and implementation notes, respectively, of the configuration node. 
  L<Config::Structured> does not do anything with these values at present, but they provides inline 
  documentation of configuration directivess within the structure (particularly useful in the common 
  case where the structure is read from a file)

  =back

=head1 METHODS

=head2 get($name?)

Class method.

Returns a registered L<Config::Structured> instance.  If C<$name> is not provided, returns the default instance.
Instances can be registered with C<__register_default> or C<__register_as>. This mechanism is used to provide
global access to a configuration, even from code contexts that otherwise cannot share data.

=head2 __register_default()

Call on a L<Config::Structured> instance to set the instance as the default.

=head2 __register_as($name)

Call on a L<Config::Structured> instance to register the instance as the provided name.

=head1 AUTHOR

Mark Tyrrell <mtyrrell@concertpharma.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2019 by Concert Pharmaceuticals, Inc.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
