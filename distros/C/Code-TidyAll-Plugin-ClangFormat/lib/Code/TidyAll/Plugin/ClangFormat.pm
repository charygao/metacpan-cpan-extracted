package Code::TidyAll::Plugin::ClangFormat;
$Code::TidyAll::Plugin::ClangFormat::VERSION = '0.0.1';
use Moo;

use Path::Tiny qw/ path tempdir tempfile cwd /;

extends 'Code::TidyAll::Plugin';

my $FMT = ".clang-format";

sub transform_file
{
    my ( $self, $fn ) = @_;

    # print cwd(), "\n";
    path($fn)->parent->child($FMT)
        ->spew_raw( path( $self->tidyall->root_dir )->child($FMT)->slurp_raw );
    my @cmd = ( 'clang-format', '-style=file', '-i', $fn );
    eval { system(@cmd); };
    return;
}

1;

__END__

=pod

=head1 NAME

Code::TidyAll::Plugin::ClangFormat - run clang-format using Code::TidyAll

=head1 VERSION

version 0.0.1

=head1 SYNOPSIS

In your C<.tidyallrc>:

    [ClangFormat]
    select = **/*.{c,cpp,h,hpp}

Also define a C<.clang-format> at the root_dir .

=head1 DESCRIPTION

This speeds up the clang-format tool ( L<https://clang.llvm.org/docs/ClangFormat.html>)
checking and reformatting, by caching results using L<Code::TidyAll> .

It was originally written for use by Freecell Solver
( L<https://fc-solve.shlomifish.org/> ), an open source automated solver
for some variants of Patience / card solitaire.
games.

=head1 VERSION

version 0.0.1

=head1 AUTHOR

Shlomi Fish <shlomif@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2019 by Shlomi Fish.

This is free software, licensed under:

  The MIT (X11) License

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
L<https://github.com/shlomif/code-tidyall-plugin-clangformat/issues>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=for :stopwords cpan testmatrix url annocpan anno bugtracker rt cpants kwalitee diff irc mailto metadata placeholders metacpan

=head1 SUPPORT

=head2 Perldoc

You can find documentation for this module with the perldoc command.

  perldoc Code::TidyAll::Plugin::ClangFormat

=head2 Websites

The following websites have more information about this module, and may be of help to you. As always,
in addition to those websites please use your favorite search engine to discover more resources.

=over 4

=item *

MetaCPAN

A modern, open-source CPAN search engine, useful to view POD in HTML format.

L<https://metacpan.org/release/Code-TidyAll-Plugin-ClangFormat>

=item *

Search CPAN

The default CPAN search engine, useful to view POD in HTML format.

L<http://search.cpan.org/dist/Code-TidyAll-Plugin-ClangFormat>

=item *

RT: CPAN's Bug Tracker

The RT ( Request Tracker ) website is the default bug/issue tracking system for CPAN.

L<https://rt.cpan.org/Public/Dist/Display.html?Name=Code-TidyAll-Plugin-ClangFormat>

=item *

AnnoCPAN

The AnnoCPAN is a website that allows community annotations of Perl module documentation.

L<http://annocpan.org/dist/Code-TidyAll-Plugin-ClangFormat>

=item *

CPAN Ratings

The CPAN Ratings is a website that allows community ratings and reviews of Perl modules.

L<http://cpanratings.perl.org/d/Code-TidyAll-Plugin-ClangFormat>

=item *

CPANTS

The CPANTS is a website that analyzes the Kwalitee ( code metrics ) of a distribution.

L<http://cpants.cpanauthors.org/dist/Code-TidyAll-Plugin-ClangFormat>

=item *

CPAN Testers

The CPAN Testers is a network of smoke testers who run automated tests on uploaded CPAN distributions.

L<http://www.cpantesters.org/distro/C/Code-TidyAll-Plugin-ClangFormat>

=item *

CPAN Testers Matrix

The CPAN Testers Matrix is a website that provides a visual overview of the test results for a distribution on various Perls/platforms.

L<http://matrix.cpantesters.org/?dist=Code-TidyAll-Plugin-ClangFormat>

=item *

CPAN Testers Dependencies

The CPAN Testers Dependencies is a website that shows a chart of the test results of all dependencies for a distribution.

L<http://deps.cpantesters.org/?module=Code::TidyAll::Plugin::ClangFormat>

=back

=head2 Bugs / Feature Requests

Please report any bugs or feature requests by email to C<bug-code-tidyall-plugin-clangformat at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/Public/Bug/Report.html?Queue=Code-TidyAll-Plugin-ClangFormat>. You will be automatically notified of any
progress on the request by the system.

=head2 Source Code

The code is open to the world, and available for you to hack on. Please feel free to browse it and play
with it, or whatever. If you want to contribute patches, please send me a diff or prod me to pull
from your repository :)

L<https://github.com/shlomif/perl-Code-TidyAll-Plugin-ClangFormat>

  git clone https://github.com/shlomif/perl-Code-TidyAll-Plugin-ClangFormat.git

=cut
