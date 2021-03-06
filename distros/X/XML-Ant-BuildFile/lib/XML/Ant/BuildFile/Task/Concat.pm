package XML::Ant::BuildFile::Task::Concat;

# ABSTRACT: concat task node in an Ant build file

#pod =head1 DESCRIPTION
#pod
#pod This is a L<Moose|Moose> type class meant for use with
#pod L<XML::Rabbit|XML::Rabbit> when processing C<< <concat/> >> tasks in an Ant
#pod build file.
#pod
#pod =head1 SYNOPSIS
#pod
#pod     package My::Ant;
#pod     use Moose;
#pod     with 'XML::Rabbit::Node';
#pod
#pod     has paths => (
#pod         isa         => 'ArrayRef[XML::Ant::BuildFile::Task::Concat]',
#pod         traits      => 'XPathObjectList',
#pod         xpath_query => './/concat',
#pod     );
#pod
#pod =cut

use utf8;
use Modern::Perl '2010';    ## no critic (Modules::ProhibitUseQuotedVersion)

our $VERSION = '0.217';     # VERSION
use English '-no_match_vars';
use Moose;
use MooseX::Types::Moose 'Str';
use MooseX::Has::Sugar;
use MooseX::Types::Path::Class 'File';
use Path::Class;
use XML::Ant::Properties;
use namespace::autoclean;
extends 'XML::Ant::BuildFile::ResourceContainer';
with 'XML::Ant::BuildFile::Task';

has _destfile =>
    ( ro,
    ## no critic (ValuesAndExpressions::RequireInterpolationOfMetachars)
    isa         => Str,
    traits      => ['XPathValue'],
    xpath_query => './@destfile',
    );

#pod =attr destfile
#pod
#pod The file to concatenate into as a L<Path::Class::File|Path::Class::File>
#pod object.
#pod
#pod =cut

has destfile => ( ro, lazy,
    isa => File,
    default =>
        sub { file( XML::Ant::Properties->apply( $_[0]->_destfile ) ) },
);

no Moose;

1;

__END__

=pod

=encoding UTF-8

=for :stopwords Mark Gardner GSI Commerce cpan testmatrix url annocpan anno bugtracker rt
cpants kwalitee diff irc mailto metadata placeholders metacpan

=head1 NAME

XML::Ant::BuildFile::Task::Concat - concat task node in an Ant build file

=head1 VERSION

version 0.217

=head1 SYNOPSIS

    package My::Ant;
    use Moose;
    with 'XML::Rabbit::Node';

    has paths => (
        isa         => 'ArrayRef[XML::Ant::BuildFile::Task::Concat]',
        traits      => 'XPathObjectList',
        xpath_query => './/concat',
    );

=head1 DESCRIPTION

This is a L<Moose|Moose> type class meant for use with
L<XML::Rabbit|XML::Rabbit> when processing C<< <concat/> >> tasks in an Ant
build file.

=head1 ATTRIBUTES

=head2 destfile

The file to concatenate into as a L<Path::Class::File|Path::Class::File>
object.

=head1 SUPPORT

=head2 Perldoc

You can find documentation for this module with the perldoc command.

  perldoc XML::Ant::BuildFile::Project

=head2 Websites

The following websites have more information about this module, and may be of help to you. As always,
in addition to those websites please use your favorite search engine to discover more resources.

=over 4

=item *

MetaCPAN

A modern, open-source CPAN search engine, useful to view POD in HTML format.

L<http://metacpan.org/release/XML-Ant-BuildFile>

=item *

Search CPAN

The default CPAN search engine, useful to view POD in HTML format.

L<http://search.cpan.org/dist/XML-Ant-BuildFile>

=item *

RT: CPAN's Bug Tracker

The RT ( Request Tracker ) website is the default bug/issue tracking system for CPAN.

L<https://rt.cpan.org/Public/Dist/Display.html?Name=XML-Ant-BuildFile>

=item *

AnnoCPAN

The AnnoCPAN is a website that allows community annotations of Perl module documentation.

L<http://annocpan.org/dist/XML-Ant-BuildFile>

=item *

CPAN Ratings

The CPAN Ratings is a website that allows community ratings and reviews of Perl modules.

L<http://cpanratings.perl.org/d/XML-Ant-BuildFile>

=item *

CPAN Forum

The CPAN Forum is a web forum for discussing Perl modules.

L<http://cpanforum.com/dist/XML-Ant-BuildFile>

=item *

CPANTS

The CPANTS is a website that analyzes the Kwalitee ( code metrics ) of a distribution.

L<http://cpants.cpanauthors.org/dist/XML-Ant-BuildFile>

=item *

CPAN Testers

The CPAN Testers is a network of smokers who run automated tests on uploaded CPAN distributions.

L<http://www.cpantesters.org/distro/X/XML-Ant-BuildFile>

=item *

CPAN Testers Matrix

The CPAN Testers Matrix is a website that provides a visual overview of the test results for a distribution on various Perls/platforms.

L<http://matrix.cpantesters.org/?dist=XML-Ant-BuildFile>

=item *

CPAN Testers Dependencies

The CPAN Testers Dependencies is a website that shows a chart of the test results of all dependencies for a distribution.

L<http://deps.cpantesters.org/?module=XML::Ant::BuildFile::Project>

=back

=head2 Bugs / Feature Requests

Please report any bugs or feature requests through the web
interface at L<https://github.com/mjgardner/xml-ant-buildfile/issues>. You will be automatically notified of any
progress on the request by the system.

=head2 Source Code

The code is open to the world, and available for you to hack on. Please feel free to browse it and play
with it, or whatever. If you want to contribute patches, please send me a diff or prod me to pull
from your repository :)

L<https://github.com/mjgardner/xml-ant-buildfile>

  git clone git://github.com/mjgardner/xml-ant-buildfile.git

=head1 AUTHOR

Mark Gardner <mjgardner@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by GSI Commerce.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
