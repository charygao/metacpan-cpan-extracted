package Sah::Schema::dns::records;

our $DATE = '2019-07-25'; # DATE
our $VERSION = '0.002'; # VERSION

our $schema = [array => {
    summary => 'Array of DNS records',
    of => ["dns::record", {req=>1}, {}],
}, {}];

# TODO add constraint: there can only be at most 1 SOA record

1;
# ABSTRACT: Array of DNS records

__END__

=pod

=encoding UTF-8

=head1 NAME

Sah::Schema::dns::records - Array of DNS records

=head1 VERSION

This document describes version 0.002 of Sah::Schema::dns::records (from Perl distribution Sah-Schemas-DNS), released on 2019-07-25.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Sah-Schemas-DNS>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Sah-Schemas-DNS>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Sah-Schemas-DNS>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2019 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
