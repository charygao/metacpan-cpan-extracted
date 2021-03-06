package Doodle::Grammar;

use 5.014;

use strict;
use warnings;

use registry 'Doodle::Library';
use routines;

use Data::Object::Class;
use Data::Object::ClassHas;

use Doodle::Statement;

use Scalar::Util ();

our $VERSION = '0.08'; # VERSION

has name => (
  is => 'ro',
  isa => 'Str',
  def => 'unknown'
);

# METHODS

method wrap(Str $arg) {
  return $arg;
}

method exception(Str $msg) {
  my $engine = ucfirst $self->name;

  require Carp;

  Carp::confess sprintf "[%s] %s", $engine, ucfirst $msg;
}

method execute(Command $cmd) {
  my $sub = $cmd->name;
  my $sql = $self->$sub($cmd);

  my $statement = Doodle::Statement->new(cmd => $cmd, sql => $sql);

  return $statement;
}

method create_schema(Command $cmd) {
  # this class is meant to be subclassed

  return $self->exception("does not support the create_schema behaviour");
}

method delete_schema(Command $cmd) {
  # this class is meant to be subclassed

  return $self->exception("does not support the delete_schema behaviour");
}

method create_table(Command $cmd) {
  # this class is meant to be subclassed

  return $self->exception("does not support the create_table behaviour");
}

method delete_table(Command $cmd) {
  # this class is meant to be subclassed

  return $self->exception("does not support the delete_table behaviour");
}

method rename_table(Command $cmd) {
  # this class is meant to be subclassed

  return $self->exception("does not support the rename_table behaviour");
}

method create_column(Command $cmd) {
  # this class is meant to be subclassed

  return $self->exception("does not support the create_column behaviour");
}

method update_column(Command $cmd) {
  # this class is meant to be subclassed

  return $self->exception("does not support the update_column behaviour");
}

method delete_column(Command $cmd) {
  # this class is meant to be subclassed

  return $self->exception("does not support the delete_column behaviour");
}

method rename_column(Command $cmd) {
  # this class is meant to be subclassed

  return $self->exception("does not support the rename_column behaviour");
}

method create_index(Command $cmd) {
  # this class is meant to be subclassed

  return $self->exception("does not support the create_index behaviour");
}

method delete_index(Command $cmd) {
  # this class is meant to be subclassed

  return $self->exception("does not support the delete_index behaviour");
}

method create_constraint(Command $cmd) {
  # this class is meant to be subclassed

  return $self->exception("does not support the create_constraint behaviour");
}

method delete_constraint(Command $cmd) {
  # this class is meant to be subclassed

  return $self->exception("does not support the delete_constraint behaviour");
}

method render(Str $str, Command $cmd) {
  my $output = $str;

  # compress multiline statements
  $output =~ s/\n+\s*/ /gm;

  # process template/data
  my @tokens = $output =~ /\{\W*(\w+)\W*\}/g;

  for my $token (@tokens) {
    my $render = "render_$token";
    next if !$self->can($render);

    my $value = $self->$render($cmd);
    next if !$value;

    $output =~ s/\{(\W*)$token(\W*)\}/$1$value$2/g;
  }

  # clean up remaining tokens
  $output =~ s/\s*\{[^\}]+\}//g;

  # return the compiled sql statement
  return $output;
}

method render_unique(Command $cmd) {
  # render index "unique" clause

  return $cmd->indices->[0]->data->{unique} ? 'unique' : undef;
}

method render_temporary(Command $cmd) {
  # render table "temporary" clause

  return $cmd->table->data->{temporary} ? 'temporary' : undef;
}

method render_if_exists(Command $cmd) {
  # render schema/table "if exists" clause

  my $source = $cmd->name =~ /schema/ ? $cmd->schema : $cmd->table;

  return 'if exists' if $source->data->{if_exists};

  return undef;
}

method render_if_not_exists(Command $cmd) {
  # render schema/table "if exists" clause

  my $source = $cmd->name =~ /schema/ ? $cmd->schema : $cmd->table;

  return 'if not exists' if $source->data->{if_not_exists};

  return undef;
}

method render_schema_name(Command $cmd) {
  # render schema name

  return $self->wrap($cmd->schema->name);
}

method render_table(Command $cmd) {
  # render table expression

  return $self->wrap($cmd->table->name);
}

method render_new_table(Command $cmd) {
  # render table expression

  return $self->wrap($cmd->table->data->{to});
}

method render_new_column(Command $cmd) {
  # render alter table add column expression

  return $self->render_column($cmd->columns->[0]);
}

method render_new_column_name(Command $cmd) {
  # render alter table rename column to expression

  return $self->wrap($cmd->columns->[0]->data->{to});
}

method render_column_name(Command $cmd) {
  # render alter table alter column name

  return $self->wrap($cmd->columns->[0]->name);
}

method render_column_change(Command $cmd) {
  # render alter table alter column changes

  my $col = $cmd->columns->[0];

  return join ' ', 'set', $col->data->{set} if $col->data->{set};
  return join ' ', 'drop', $col->data->{drop} if $col->data->{drop};
  return join ' ', 'type', $col->type;
}

method render_columns(Command $cmd) {
  # render create table column expressions

  return join ', ', map $self->render_column($_), @{$cmd->table->columns};
}

method render_constraints(Command $cmd) {
  # render create table constraints

  return join ', ', map $self->render_constraint($_), @{$cmd->table->relations};
}

method render_type(Column $col) {
  # render column data type expression

  my $name = $col->type;
  my $type = "type_$name";

  $self->exception("can not handle a $name column") if !$self->can($type);

  return $self->$type($col);
}

method render_column(Column $col) {
  # render column spec expression

  my @renders = (
    'render_type',
    'render_nullable',
    'render_default',
    'render_increments',
    'render_primary'
  );

  return join ' ', $self->wrap($col->name), map $self->$_($col), @renders;
}

method render_constraint(Relation $rel) {
  # render create table constraint expression

  my $column = $self->wrap($rel->column);
  my $ftable = $self->wrap($rel->foreign_table);
  my $fcolumn = $self->wrap($rel->foreign_column);

  return "foreign key ($column) references $ftable ($fcolumn)";
}

method render_default(Column $col) {
  # render column default value

  my $data = $col->data;

  return () if !exists $data->{default};

  my $default = $data->{default};

  my $type = $default->[0];
  my $value = $default->[1];

  if ($type eq 'function') {
    $value = uc $value;
    return "default $value";
  }

  if ($type eq 'string') {
    return "default '$value'";
  }

  if ($type eq 'integer') {
    return "default $value";
  }

  if ($type eq 'deduce') {
    if (Scalar::Util::looks_like_number($value)) {
      return "default $value";
    }
    else {
      return "default '$value'";
    }
  }

  return ();
}

method render_nullable(Column $col) {
  # render column null/not-null expression

  my $data = $col->data;

  return () if !exists $data->{nullable};

  return $data->{nullable} ? 'null' : 'not null';
}

method render_increments(Column $col) {
  # render column auto-increment expression

  my $data = $col->data;

  return $data->{increments} ? 'auto_increment' : ();
}

method render_primary(Column $col) {
  # render column primary key expression

  my $data = $col->data;

  return $data->{primary} ? 'primary key' : ();
}

method render_index_name(Command $cmd) {
  # render table create index expression

  return $self->wrap($cmd->indices->[0]->name);
}

method render_index_columns(Command $cmd) {
  # render table create index columns expression

  return join ', ', map $self->wrap($_), @{$cmd->indices->[0]->columns};
}

method render_relation(Command $cmd) {
  # render table create foreign constraint expression

  my $relation = $cmd->relation;

  my $name = $self->wrap($relation->name);
  my $expr = $self->render_constraint($relation);

  my $on_delete = $relation->data->{on_delete};
  my $on_update = $relation->data->{on_update};

  my @args = ($name, $expr);

  push @args, "on delete $on_delete" if $on_delete;
  push @args, "on update $on_update" if $on_update;

  return join ' ', @args;
}

method render_relation_name(Command $cmd) {
  # render table create foreign key name

  return $self->wrap($cmd->relation->name);
}

method render_engine(Command $cmd) {
  # render engine

  my $engine =  $cmd->table->engine;

  return return $engine ? "engine = $engine" : undef;
}

method render_charset(Command $cmd) {
  # render charset

  my $charset = $cmd->table->charset;

  return $charset ? "character set $charset" : undef;
}

method render_collation(Command $cmd) {
  # render collation

  my $collation = $cmd->table->collation;

  return $collation ? "collate $collation" : undef;
}

1;

=encoding utf8

=head1 NAME

Doodle::Grammar

=cut

=head1 ABSTRACT

Doodle Grammar Base Class

=cut

=head1 SYNOPSIS

  use Doodle::Grammar;

  my $self = Doodle::Grammar->new;

=cut

=head1 DESCRIPTION

This package determines how command objects should be interpreted to produce
the correct DDL statements.

=cut

=head1 LIBRARIES

This package uses type constraints from:

L<Doodle::Library>

=cut

=head1 ATTRIBUTES

This package has the following attributes:

=cut

=head2 name

  name(Str)

This attribute is read-only, accepts C<(Str)> values, and is optional.

=cut

=head1 METHODS

This package implements the following methods:

=cut

=head2 create_column

  create_column(Command $command) : Str

Generate SQL statement for column-create Command.

=over 4

=item create_column example #1

  # given: synopsis

  use Doodle;

  my $ddl = Doodle->new;
  my $column = $ddl->table('users')->column('id');
  my $command = $column->create;

  my $create_column = $self->create_column($command);

=back

=cut

=head2 create_constraint

  create_constraint(Column $column) : Str

Returns the SQL statement for the create constraint command.

=over 4

=item create_constraint example #1

  # given: synopsis

  use Doodle;

  my $ddl = Doodle->new;
  my $relation = $ddl->table('emails')->relation('user_id', 'users', 'id');
  my $command = $relation->create;

  $self->create_constraint($command);

=back

=cut

=head2 create_index

  create_index(Command $command) : Str

Generate SQL statement for index-create Command.

=over 4

=item create_index example #1

  # given: synopsis

  use Doodle;

  my $ddl = Doodle->new;
  my $index = $ddl->table('users')->index(columns => ['is_admin']);
  my $command = $index->create;

  my $create_index = $self->create_index($command);

=back

=cut

=head2 create_schema

  create_schema(Command $command) : Str

Generate SQL statement for schema-create Command.

=over 4

=item create_schema example #1

  # given: synopsis

  use Doodle;

  my $ddl = Doodle->new;
  my $schema = $ddl->schema('app');
  my $command = $schema->create;

  my $create_schema = $self->create_schema($command);

=back

=cut

=head2 create_table

  create_table(Command $command) : Str

Generate SQL statement for table-create Command.

=over 4

=item create_table example #1

  # given: synopsis

  use Doodle;

  my $ddl = Doodle->new;
  my $table = $ddl->table('users');
  my $command = $table->create;

  my $create_table = $self->create_table($command);

=back

=cut

=head2 delete_column

  delete_column(Command $command) : Str

Generate SQL statement for column-delete Command.

=over 4

=item delete_column example #1

  # given: synopsis

  use Doodle;

  my $ddl = Doodle->new;
  my $column = $ddl->table('users')->column('id');
  my $command = $column->delete;

  my $delete_column = $self->delete_column($command);

=back

=cut

=head2 delete_constraint

  delete_constraint(Column $column) : Str

Returns the SQL statement for the delete constraint command.

=over 4

=item delete_constraint example #1

  # given: synopsis

  use Doodle;

  my $ddl = Doodle->new;
  my $relation = $ddl->table('emails')->relation('user_id', 'users', 'id');
  my $command = $relation->delete;

  $self->delete_constraint($command);

=back

=cut

=head2 delete_index

  delete_index(Command $command) : Str

Generate SQL statement for index-delete Command.

=over 4

=item delete_index example #1

  # given: synopsis

  use Doodle;

  my $ddl = Doodle->new;
  my $index = $ddl->table('users')->index(columns => ['is_admin']);
  my $command = $index->delete;

  my $delete_index = $self->delete_index($command);

=back

=cut

=head2 delete_schema

  delete_schema(Command $command) : Str

Generate SQL statement for schema-delete Command.

=over 4

=item delete_schema example #1

  # given: synopsis

  my $ddl = Doodle->new;
  my $schema = $ddl->schema('app');
  my $command = $schema->delete;

  my $delete_schema = $self->delete_schema($command);

=back

=cut

=head2 delete_table

  delete_table(Command $command) : Str

Generate SQL statement for table-delete Command.

=over 4

=item delete_table example #1

  # given: synopsis

  use Doodle;

  my $ddl = Doodle->new;
  my $table = $ddl->table('users');
  my $command = $table->delete;

  my $delete_table = $self->delete_table($command);

=back

=cut

=head2 exception

  exception(Str $message) : Any

Throws an exception using L<Carp> confess.

=over 4

=item exception example #1

  # given: synopsis

  $self->exception('Oops');

=back

=cut

=head2 execute

  execute(Command $command) : Statement

Processed the Command and returns a Statement object.

=over 4

=item execute example #1

  # given: synopsis

  use Doodle;

  my $ddl = Doodle->new;
  my $column = $ddl->table('users')->column('id');
  my $command = $column->create;

  my $statement = $self->execute($command);

=back

=cut

=head2 rename_column

  rename_column(Command $command) : Str

Generate SQL statement for column-rename Command.

=over 4

=item rename_column example #1

  # given: synopsis

  use Doodle;

  my $ddl = Doodle->new;
  my $column = $ddl->table('users')->column('id');
  my $command = $column->rename('uuid');

  my $rename_column = $self->rename_column($command);

=back

=cut

=head2 rename_table

  rename_table(Command $command) : Str

Generate SQL statement for table-rename Command.

=over 4

=item rename_table example #1

  # given: synopsis

  use Doodle;

  my $ddl = Doodle->new;
  my $table = $ddl->table('users');
  my $command = $table->rename('people');

  my $rename_table = $self->rename_table($command);

=back

=cut

=head2 render

  render(Command $command) : Str

Returns the SQL statement for the given Command.

=over 4

=item render example #1

  # given: synopsis

  use Doodle;

  my $ddl = Doodle->new;
  my $schema = $ddl->schema('app');
  my $command = $schema->create;
  my $template = 'create schema {schema_name}';

  my $sql = $self->render($template, $command);

=back

=cut

=head2 update_column

  update_column(Any @args) : Str

Generate SQL statement for column-update Command.

=over 4

=item update_column example #1

  # given: synopsis

  use Doodle;

  my $ddl = Doodle->new;
  my $column = $ddl->table('users')->column('id')->integer_small;
  my $command = $column->update;

  my $update_column = $self->update_column($command);

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
