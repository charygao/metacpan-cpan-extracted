package Search::Elasticsearch::Serializer::JSON::Cpanel;
$Search::Elasticsearch::Serializer::JSON::Cpanel::VERSION = '6.81';
use Cpanel::JSON::XS;
use Moo;

has 'JSON' =>
    ( is => 'ro', default => sub { Cpanel::JSON::XS->new->utf8(1) } );

with 'Search::Elasticsearch::Role::Serializer::JSON';

1;

=pod

=encoding UTF-8

=head1 NAME

Search::Elasticsearch::Serializer::JSON::Cpanel - A JSON Serializer using Cpanel::JSON::XS

=head1 VERSION

version 6.81

=head1 SYNOPSIS

    $e = Search::Elasticsearch(
        serializer => 'JSON::Cpanel'
    );

=head1 DESCRIPTION

While the default serializer, L<Search::Elasticsearch::Serializer::JSON>,
tries to choose the appropriate JSON backend, this module allows you to
choose the L<Cpanel::JSON::XS> backend specifically.

This class does L<Search::Elasticsearch::Role::Serializer::JSON>.

=head1 SEE ALSO

=over

=item * L<Search::Elasticsearch::Serializer::JSON>

=item * L<Search::Elasticsearch::Serializer::JSON::XS>

=item * L<Search::Elasticsearch::Serializer::JSON::PP>

=back

=head1 AUTHOR

Enrico Zimuel <enrico.zimuel@elastic.co>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2020 by Elasticsearch BV.

This is free software, licensed under:

  The Apache License, Version 2.0, January 2004

=cut

__END__

# ABSTRACT: A JSON Serializer using Cpanel::JSON::XS

