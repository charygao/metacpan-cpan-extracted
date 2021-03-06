use 5.16.0;

package Map::Metro::Plugin::Map::Stockholm;

# ABSTRACT: Map::Metro map for Stockholm
our $AUTHORITY = 'cpan:CSSON'; # AUTHORITY
our $VERSION = '0.1973';

use Moose;
with 'Map::Metro::Plugin::Map';

has '+mapfile' => (
    default => 'map-stockholm.metro',
);
sub map_version {
    return $VERSION;
}
sub map_package {
    return __PACKAGE__;
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

Map::Metro::Plugin::Map::Stockholm - Map::Metro map for Stockholm



=begin html

<p>
<img src="https://img.shields.io/badge/perl-5.16+-blue.svg" alt="Requires Perl 5.16+" />
<a href="https://travis-ci.org/Csson/p5-Map-Metro-Plugin-Map-Stockholm"><img src="https://api.travis-ci.org/Csson/p5-Map-Metro-Plugin-Map-Stockholm.svg?branch=master" alt="Travis status" /></a>
<a href="http://cpants.cpanauthors.org/release/CSSON/Map-Metro-Plugin-Map-Stockholm-0.1973"><img src="http://badgedepot.code301.com/badge/kwalitee/CSSON/Map-Metro-Plugin-Map-Stockholm/0.1973" alt="Distribution kwalitee" /></a>
<a href="http://matrix.cpantesters.org/?dist=Map-Metro-Plugin-Map-Stockholm%200.1973"><img src="http://badgedepot.code301.com/badge/cpantesters/Map-Metro-Plugin-Map-Stockholm/0.1973" alt="CPAN Testers result" /></a>
<img src="https://img.shields.io/badge/coverage-69.2%-red.svg" alt="coverage 69.2%" />
</p>

=end html

=head1 VERSION

Version 0.1973, released 2019-08-28.

=head1 SYNOPSIS

    use Map::Metro;
    my $graph = Map::Metro->new('Stockholm')->parse;

Or:

    $ map-metro.pl route Stockholm Akalla Medborgarplatsen

=head1 DESCRIPTION

See L<Map::Metro> for usage information.

=head1 STATUS

This map L<contains|Map::Metro::Plugin::Map::Stockholm>:

* All seven subway lines [L<wikipedia|https://en.wikipedia.org/wiki/Stockholm_metro>]

* The I<Spårväg City> tram line [L<wikipedia|https://en.wikipedia.org/wiki/Sp%C3%A5rv%C3%A4g_City>]

* The I<Tvärbanan> tram line [L<wikipedia|https://en.wikipedia.org/wiki/Nockebybanan>]

* The I<Nockebybanan> tram line [L<wikipedia|https://en.wikipedia.org/wiki/Tv%C3%A4rbanan>]

* The I<Lidingöbanan> tram line [L<wikipedia|https://en.wikipedia.org/wiki/Liding%C3%B6banan>]

=for HTML <p><a href="https://raw.githubusercontent.com/Csson/p5-Map-Metro-Plugin-Map-Stockholm/master/static/images/stockholm.png"><img src="https://raw.githubusercontent.com/Csson/p5-Map-Metro-Plugin-Map-Stockholm/master/static/images/stockholm.png" style="max-width: 600px" /></a></p>

=head1 SOURCE

L<https://github.com/Csson/p5-Map-Metro-Plugin-Map-Stockholm>

=head1 HOMEPAGE

L<https://metacpan.org/release/Map-Metro-Plugin-Map-Stockholm>

=head1 AUTHOR

Erik Carlsson <info@code301.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by Erik Carlsson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
