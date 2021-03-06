package Data::Sah::Coerce::perl::array::str_comma_sep;

our $DATE = '2019-07-26'; # DATE
our $VERSION = '0.009'; # VERSION

use 5.010001;
use strict;
use warnings;

sub meta {
    +{
        v => 4,
        prio => 60, # a bit lower than normal
    };
}

sub coerce {
    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{expr_match} = "!ref($dt)";

    $res->{expr_coerce} = "[split /\\s*,\\s*/, $dt]";

    $res;
}

1;
# ABSTRACT: Coerce array from a comma-separated items in a string

__END__

=pod

=encoding UTF-8

=head1 NAME

Data::Sah::Coerce::perl::array::str_comma_sep - Coerce array from a comma-separated items in a string

=head1 VERSION

This document describes version 0.009 of Data::Sah::Coerce::perl::array::str_comma_sep (from Perl distribution Data-Sah-CoerceRule-array-str_comma_sep), released on 2019-07-26.

=head1 DESCRIPTION

The rule is not enabled by default. You can enable it in a schema using e.g.:

 ["array*", of=>"int", "x.coerce_rules"=>["str_comma_sep"]]

=for Pod::Coverage ^(meta|coerce)$

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Data-Sah-CoerceRule-array-str_comma_sep>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Data-Sah-CoerceRule-array-str_comma_sep>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Data-Sah-CoerceRule-array-str_comma_sep>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2019, 2018, 2016 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
