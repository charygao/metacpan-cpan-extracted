package Zing::Zang::Worker;

use 5.014;

use strict;
use warnings;

use registry;
use routines;

use Data::Object::Class;
use Data::Object::ClassHas;

extends 'Zing::Worker';

our $VERSION = '0.13'; # VERSION

# ATTRIBUTES

has 'on_handle' => (
  is => 'ro',
  isa => 'Maybe[CodeRef]',
  opt => 1,
);

has 'on_perform' => (
  is => 'ro',
  isa => 'Maybe[CodeRef]',
  opt => 1,
);

has 'on_receive' => (
  is => 'ro',
  isa => 'Maybe[CodeRef]',
  opt => 1,
);

has 'queues' => (
  is => 'ro',
  isa => 'ArrayRef[Str]',
  req => 1,
);

# METHODS

method handle(@args) {
  return $self if !$self->on_handle;

  $self->on_handle->($self, @args);

  return $self;
}

method receive(@args) {
  return $self if !$self->on_receive;

  $self->on_receive->($self, @args);

  return $self;
}

method perform(@args) {
  return $self if !$self->on_perform;

  $self->on_perform->($self, @args);

  return $self;
}

1;
=encoding utf8

=head1 NAME

Zing::Zang::Worker - Worker Process

=cut

=head1 ABSTRACT

Worker Process Implementation

=cut

=head1 SYNOPSIS

  use Zing::Zang::Worker;

  my $zang = Zing::Zang::Worker->new(
    on_handle => sub {
      my ($self, $name, $data) = @_;

      $self->{handled} = [$name, $data];
    },
    queues => ['tasks']
  );

  # $zang->execute;

=cut

=head1 DESCRIPTION

This package provides a L<Zing::Worker> which uses callbacks and doesn't need
to be subclassd. It supports providing a process C<perform> method as
C<on_perform> and a C<receive> method as C<on_receive> which operate as
expected, and also a C<handle> method as C<on_handle> which is executed
whenever a message is received from one of the queue(s).

=cut

=head1 INHERITS

This package inherits behaviors from:

L<Zing::Worker>

=cut

=head1 LIBRARIES

This package uses type constraints from:

L<Zing::Types>

=cut

=head1 ATTRIBUTES

This package has the following attributes:

=cut

=head2 on_handle

  on_handle(Maybe[CodeRef])

This attribute is read-only, accepts C<(Maybe[CodeRef])> values, and is optional.

=cut

=head2 on_perform

  on_perform(Maybe[CodeRef])

This attribute is read-only, accepts C<(Maybe[CodeRef])> values, and is optional.

=cut

=head2 on_receive

  on_receive(Maybe[CodeRef])

This attribute is read-only, accepts C<(Maybe[CodeRef])> values, and is optional.

=cut

=head2 queues

  queues(ArrayRef[Str])

This attribute is read-only, accepts C<(ArrayRef[Str])> values, and is required.

=cut

=head1 AUTHOR

Al Newkirk, C<awncorp@cpan.org>

=head1 LICENSE

Copyright (C) 2011-2019, Al Newkirk, et al.

This is free software; you can redistribute it and/or modify it under the terms
of the The Apache License, Version 2.0, as elucidated in the L<"license
file"|https://github.com/iamalnewkirk/zing/blob/master/LICENSE>.

=head1 PROJECT

L<Wiki|https://github.com/iamalnewkirk/zing/wiki>

L<Project|https://github.com/iamalnewkirk/zing>

L<Initiatives|https://github.com/iamalnewkirk/zing/projects>

L<Milestones|https://github.com/iamalnewkirk/zing/milestones>

L<Contributing|https://github.com/iamalnewkirk/zing/blob/master/CONTRIBUTE.md>

L<Issues|https://github.com/iamalnewkirk/zing/issues>

=cut
