package DBIx::NoSQL::Store::Manager::StoreIndex;
our $AUTHORITY = 'cpan:YANICK';
# ABSTRACT: Marks attributes to be indexed in the store
$DBIx::NoSQL::Store::Manager::StoreIndex::VERSION = '1.0.0';

use Moose::Role;
Moose::Util::meta_attribute_alias('StoreIndex');

has store_isa => (
    is => 'rw',
    isa => 'Str',
    predicate => 'has_store_isa',
);

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

DBIx::NoSQL::Store::Manager::StoreIndex - Marks attributes to be indexed in the store

=head1 VERSION

version 1.0.0

=head1 SYNOPSIS

    # in a class consuming the DBIx::NoSQL::Store::Manager::Model role

    has something => (
        traits => [ 'StoreIndex' ],
        is => 'ro',
    );

=head1 DESCRIPTION

I<DBIx::NoSQL::Store::Manager::StoreIndex> (also aliased to I<StoreIndex>)
is used to mark attributes that are to be indexed by the
L<DBIx::NoSQL::Store::Manager> store.

=head1 AUTHOR

Yanick Champoux <yanick@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2018, 2013, 2012 by Yanick Champoux.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
