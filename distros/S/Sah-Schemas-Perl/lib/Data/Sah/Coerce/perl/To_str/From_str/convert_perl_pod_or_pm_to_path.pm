package Data::Sah::Coerce::perl::To_str::From_str::convert_perl_pod_or_pm_to_path;

# AUTHOR
our $DATE = '2020-06-19'; # DATE
our $DIST = 'Sah-Schemas-Perl'; # DIST
our $VERSION = '0.034'; # VERSION

use 5.010001;
use strict;
use warnings;

sub meta {
    +{
        v => 4,
        summary => 'Convert POD/module name existing in @INC to its filesystem path',
        prio => 50,
    };
}

sub coerce {
    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{modules}{'Module::Path::More'} //= {version=>0, core=>0, pp=>1};
    $res->{expr_match} = "1";
    $res->{expr_coerce} = join(
        "",
        "do { ",
        "my \$_sahc_orig = $dt; ",
        "if (\$_sahc_orig =~ m!\\A\\w+((?:/|::)\\w+)*(?:\\.pm|\\.pod)?\\z!) {",
        "  (my \$tmp = \$_sahc_orig) =~ s!/!::!g; my \$ext; \$tmp =~ s/\\.(pm|pod)\\z// and \$ext = \$1;",
        "  Module::Path::More::module_path(module=>\$tmp, find_pm=>!\$ext || \$ext eq 'pm' ? 2:0, find_pod=>!\$ext || \$ext eq 'pod' ? 1:0, find_prefix=>0, find_pmc=>0) || \$_sahc_orig ",
        "} else {",
        "  \$_sahc_orig ",
        "} ",
        "}",
    );

    $res;
}

1;
# ABSTRACT:

__END__

=pod

=encoding UTF-8

=head1 NAME

Data::Sah::Coerce::perl::To_str::From_str::convert_perl_pod_or_pm_to_path

=head1 VERSION

This document describes version 0.034 of Data::Sah::Coerce::perl::To_str::From_str::convert_perl_pod_or_pm_to_path (from Perl distribution Sah-Schemas-Perl), released on 2020-06-19.

=head1 DESCRIPTION

This rule can convert strings in the form of:

 Foo::Bar
 Foo/Bar
 Foo/Bar.pod
 Foo/Bar.pm

into the filesystem path (e.g.
C</home/ujang/perl5/perlbrew/perls/perl-5.24.0/lib/site_perl/5.24.0/Foo/Bar.pm>)
when the POD or module exists in C<@INC>. Otherwise, it leaves the string as-is.

This rule is the same as
L<Data::Sah::Coerce::perl::To_str::From_str::convert_perl_pm_or_pod_to_path> except that
.pod is prioritized over .pm. If C<Foo.pm> and C<Foo.pod> are both found on the
filesystem, C<Foo.pod> will be returned.

=for Pod::Coverage ^(meta|coerce)$

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Sah-Schemas-Perl>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Sah-Schemas-Perl>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Sah-Schemas-Perl>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2020, 2019, 2018, 2017, 2016 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
