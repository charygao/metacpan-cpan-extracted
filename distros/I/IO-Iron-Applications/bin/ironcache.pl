#!/usr/bin/perl
use IO::Iron::Applications::IronCache;
IO::Iron::Applications::IronCache->run;

# PODNAME: ironcache.pl

# ABSTRACT: ironcache.pl executable. Command line utility to operate IO-Iron's IronCache.

our $VERSION = '0.12'; # VERSION: generated by DZP::OurPkgVersion

__END__

=pod

=encoding UTF-8

=head1 NAME

ironcache.pl - ironcache.pl executable. Command line utility to operate IO-Iron's IronCache.

=head1 VERSION

version 0.12

=head1 SYNOPSIS

    ironcache.pl help
    ironcache.pl list items --help
    ironcache.pl list caches
    ironcache.pl list caches cache_[:digit:]{2}
    ironcache.pl list items item.01_01 --cache cache_A01 --alternatives
    ironcache.pl list items .+ --cache cache_A01 --config iron_cache.json
    ironcache.pl list items item.01_0[[:digit:]]{1} --cache cache_B05
    ironcache.pl list items item.01_0[[:digit:]]{1},item.01_0[[:alpha:]]{1}
            --cache cache_B05,cache_B06,cache_B07 --show-value
    ironcache.pl put item item.01_01 --cache cache_A01 --value 25
    ironcache.pl put item item.01_01 --cache cache_A01 <value_file.txt
    ironcache.pl increment item item.01_02 --cache cache_A01 --value 125
    ironcache.pl get item item.01_02 --cache cache_A01
    ironcache.pl delete item item.01_02 --cache cache_A01
    ironcache.pl clear cache cache_A01
    ironcache.pl delete cache cache_A01

=head1 DESCRIPTION

Ironcache.pl is a tool to access the features of
L<IO::Iron::IronCache|IO::Iron::IronCache> package
from the command line.

B<IO::Iron::IronCache> is a client library for the 
(L<IronCache|http://www.iron.io/cache>) cloud service.

=head1 REQUIREMENTS

L<IO::Iron|IO::Iron> package.

=head1 AUTHOR

Mikko Koivunalho <mikko.koivunalho AT iki.fi>

=head1 BUGS

Please report any bugs or feature requests to bug-io-iron-applications@rt.cpan.org or through the web interface at:
 http://rt.cpan.org/Public/Dist/Display.html?Name=IO-Iron-Applications

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Mikko Koivunalho.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

The full text of the license can be found in the
F<LICENSE> file included with this distribution.

=cut
