package Doodle::Helpers;

use 5.014;

use strict;
use warnings;

use registry 'Doodle::Library';
use routines;

use Data::Object::Role;

our $VERSION = '0.08'; # VERSION

# METHODS

method schema_create(Any %args) {
  $args{doodle} = $self;

  my $command = Doodle::Command->new(%args, name => 'create_schema');

  push @{$self->commands}, $command;

  return $command;
}

method schema_delete(Any %args) {
  $args{doodle} = $self;

  my $command = Doodle::Command->new(%args, name => 'delete_schema');

  push @{$self->commands}, $command;

  return $command;
}

method table_create(Any %args) {
  $args{doodle} = $self;

  my $command = Doodle::Command->new(%args, name => 'create_table');

  push @{$self->commands}, $command;

  return $command;
}

method table_delete(Any %args) {
  $args{doodle} = $self;

  my $command = Doodle::Command->new(%args, name => 'delete_table');

  push @{$self->commands}, $command;

  return $command;
}

method table_rename(Any %args) {
  $args{doodle} = $self;

  my $command = Doodle::Command->new(%args, name => 'rename_table');

  push @{$self->commands}, $command;

  return $command;
}

method column_create(Any %args) {
  $args{doodle} = $self;

  my $command = Doodle::Command->new(%args, name => 'create_column');

  push @{$self->commands}, $command;

  return $command;
}

method column_update(Any %args) {
  $args{doodle} = $self;

  my $command = Doodle::Command->new(%args, name => 'update_column');

  push @{$self->commands}, $command;

  return $command;
}

method column_rename(Any %args) {
  $args{doodle} = $self;

  my $command = Doodle::Command->new(%args, name => 'rename_column');

  push @{$self->commands}, $command;

  return $command;
}

method column_delete(Any %args) {
  $args{doodle} = $self;

  my $command = Doodle::Command->new(%args, name => 'delete_column');

  push @{$self->commands}, $command;

  return $command;
}

method index_create(Any %args) {
  $args{doodle} = $self;

  my $command = Doodle::Command->new(%args, name => 'create_index');

  push @{$self->commands}, $command;

  return $command;
}

method index_delete(Any %args) {
  $args{doodle} = $self;

  my $command = Doodle::Command->new(%args, name => 'delete_index');

  push @{$self->commands}, $command;

  return $command;
}

method relation_create(Any %args) {
  $args{doodle} = $self;

  my $command = Doodle::Command->new(%args, name => 'create_relation');

  push @{$self->commands}, $command;

  return $command;
}

method relation_delete(Any %args) {
  $args{doodle} = $self;

  my $command = Doodle::Command->new(%args, name => 'delete_relation');

  push @{$self->commands}, $command;

  return $command;
}

1;

=encoding utf8

=head1 NAME

Doodle::Helpers

=cut

=head1 ABSTRACT

Doodle Command Helpers

=cut

=head1 SYNOPSIS

  use Doodle;

  # consumes Doodle::Helpers

  my $self = Doodle->new;

  my $command = $self->schema_create;

=cut

=head1 DESCRIPTION

Helpers for configuring Commands.

=cut

=head1 LIBRARIES

This package uses type constraints from:

L<Doodle::Library>

=cut

=head1 METHODS

This package implements the following methods:

=cut

=head2 column_create

  column_create(Any %args) : Command

Registers a column create and returns the Command object.

=over 4

=item column_create example #1

  # given: synopsis

  my %args; # (..., column => $column)

  $command = $self->column_create(%args);

=back

=cut

=head2 column_delete

  column_delete(Any %args) : Command

Registers a column delete and returns the Command object.

=over 4

=item column_delete example #1

  # given: synopsis

  my %args; # (..., column => $column)

  $command = $self->column_delete(%args);

=back

=cut

=head2 column_rename

  column_rename(Any %args) : Command

Registers a column rename and returns the Command object.

=over 4

=item column_rename example #1

  # given: synopsis

  my %args; # (..., column => $column)

  $command = $self->column_rename(%args);

=back

=cut

=head2 column_update

  column_update(Any %args) : Command

Registers a column update and returns the Command object.

=over 4

=item column_update example #1

  # given: synopsis

  my %args; # (..., column => $column)

  $command = $self->column_update(%args);

=back

=cut

=head2 index_create

  index_create(Any %args) : Command

Registers a index create and returns the Command object.

=over 4

=item index_create example #1

  # given: synopsis

  my %args; # (..., index => $index)

  $command = $self->index_create(%args);

=back

=cut

=head2 index_delete

  index_delete(Any %args) : Command

Register and return an index_delete command.

=over 4

=item index_delete example #1

  # given: synopsis

  my %args; # (..., index => $index)

  $command = $self->index_delete(%args);

=back

=cut

=head2 relation_create

  relation_create(Any %args) : Command

Registers a relation create and returns the Command object.

=over 4

=item relation_create example #1

  # given: synopsis

  my %args; # (..., relation => $relation)

  $command = $self->relation_create(%args);

=back

=cut

=head2 relation_delete

  relation_delete(Any %args) : Command

Registers a relation delete and returns the Command object.

=over 4

=item relation_delete example #1

  # given: synopsis

  my %args; # (..., relation => $relation)

  $command = $self->relation_delete(%args);

=back

=cut

=head2 schema_create

  schema_create(Any %args) : Command

Registers a schema create and returns the Command object.

=over 4

=item schema_create example #1

  # given: synopsis

  my %args; # (..., schema => $schema)

  $command = $self->schema_create(%args);

=back

=cut

=head2 schema_delete

  schema_delete(Any %args) : Command

Registers a schema delete and returns the Command object.

=over 4

=item schema_delete example #1

  # given: synopsis

  my %args; # (..., schema => $schema)

  $command = $self->schema_delete(%args);

=back

=cut

=head2 table_create

  table_create(Any %args) : Command

Registers a table create and returns the Command object.

=over 4

=item table_create example #1

  # given: synopsis

  my %args; # (..., table => $table)

  $command = $self->table_create(%args);

=back

=cut

=head2 table_delete

  table_delete(Any %args) : Command

Registers a table delete and returns the Command object.

=over 4

=item table_delete example #1

  # given: synopsis

  my %args; # (..., table => $table)

  $command = $self->table_delete(%args);

=back

=cut

=head2 table_rename

  table_rename(Any %args) : Command

Registers a table rename and returns the Command object.

=over 4

=item table_rename example #1

  # given: synopsis

  my %args; # (..., table => $table)

  $command = $self->table_rename(%args);

=back

=cut

=head1 AUTHOR

Al Newkirk, C<awncorp@cpan.org>

=head1 LICENSE

Copyright (C) 2011-2019, Al Newkirk, et al.

This is free software; you can redistribute it and/or modify it under the terms
of the The Apache License, Version 2.0, as elucidated in the L<"license
file"|https://github.com/iamalnewkirk/doodle/blob/master/LICENSE>.

=head1 PROJECT

L<Wiki|https://github.com/iamalnewkirk/doodle/wiki>

L<Project|https://github.com/iamalnewkirk/doodle>

L<Initiatives|https://github.com/iamalnewkirk/doodle/projects>

L<Milestones|https://github.com/iamalnewkirk/doodle/milestones>

L<Contributing|https://github.com/iamalnewkirk/doodle/blob/master/CONTRIBUTE.md>

L<Issues|https://github.com/iamalnewkirk/doodle/issues>

=cut
