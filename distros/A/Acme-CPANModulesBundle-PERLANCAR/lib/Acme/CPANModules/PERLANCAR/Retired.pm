package Acme::CPANModules::PERLANCAR::Retired;

our $DATE = '2020-08-09'; # DATE
our $VERSION = '0.007'; # VERSION

our $LIST = {
    summary => 'Retired modules',
    description => <<'_',

This is a list of some of the modules which I wrote but have now been retired
and purged from CPAN, for various reasons but mostly because they are no longer
necessary. I've purged/retired more modules than these (mostly failed
experiments) but they are not worth mentioning here because nobody else seems to
have used them.

Note that you can always get these retired modules from BackPAN or GitHub (I
don't purge most of the repos) if needed.

_
    entries => [
        {
            module => 'Data::Schema',
            description => <<'_',

I wrote <pm:Data::Sah> which superseded this module since 2012.

_
            alternate_modules => ['Data::Sah'],
        },
        {
            module => 'Carp::Always::Dump',
            description => <<'_',

This module is like <pm:Carp::Always>, but dumps complex arguments instead of
just printing `ARRAY(0x22f8160)` or something like that.

Superseded by <pm:Devel::Confess>, which can do color
(<pm:Carp::Always::Color>), dumps (<pm:Carp::Always::Dump>), as well as a few
other tricks, all in a single package.

_
            alternate_modules => ['Devel::Confess'],
        },
        {
            module => 'Passwd::Unix::Alt',
            description => <<'_',

I first wrote <pm:Passwd::Unix::Alt> (a fork of <pm:Passwd::Unix>) to support
shadow passwd/group files, but later abandoned this fork due to a couple of
fundamental issues and later wrote a clean-slate attempt
<pm:Unix::Passwd::File>.

_
            alternate_modules => ['Unix::Passwd::File'],
        },
        {
            module => 'Module::List::WithPath',
            description => <<'_',

Superseded by <pm:PERLANCAR::Module::List>.

_
            alternate_modules => ['PERLANCAR::Module::List'],
        },
        {
            module => 'App::CreateSparseFile',
            description => <<'_',

I didn't know about the `fallocate` command.

_
            'x.date' => '2017-07-18',
        },
        {
            module => 'Log::Any::App',
            description => <<'_',

I've written <pm:Log::ger::App> to be its successor.

_
            'x.date' => '2017-09-08',
            alternate_modules => ['Log::ger::App'],
        },
        {
            module => 'Package::MoreUtil',
            description => <<'_',

I didn't know about <pm:Package::Stash>, which does things more properly and
performantly. But I've spun routines not yet covered by Package::Stash to
<pm:Package::Util::Lite>.

_
            'x.date' => '2019-01-06',
            alternate_modules => ['Package::Stash', 'Package::Util::Lite'],
        },
    ],
};

1;
# ABSTRACT: Retired modules

__END__

=pod

=encoding UTF-8

=head1 NAME

Acme::CPANModules::PERLANCAR::Retired - Retired modules

=head1 VERSION

This document describes version 0.007 of Acme::CPANModules::PERLANCAR::Retired (from Perl distribution Acme-CPANModulesBundle-PERLANCAR), released on 2020-08-09.

=head1 DESCRIPTION

This is a list of some of the modules which I wrote but have now been retired
and purged from CPAN, for various reasons but mostly because they are no longer
necessary. I've purged/retired more modules than these (mostly failed
experiments) but they are not worth mentioning here because nobody else seems to
have used them.

Note that you can always get these retired modules from BackPAN or GitHub (I
don't purge most of the repos) if needed.

=head1 INCLUDED MODULES

=over

=item * L<Data::Schema>

I wrote L<Data::Sah> which superseded this module since 2012.


Alternate modules: L<Data::Sah>

=item * L<Carp::Always::Dump>

This module is like L<Carp::Always>, but dumps complex arguments instead of
just printing C<ARRAY(0x22f8160)> or something like that.

Superseded by L<Devel::Confess>, which can do color
(L<Carp::Always::Color>), dumps (L<Carp::Always::Dump>), as well as a few
other tricks, all in a single package.


Alternate modules: L<Devel::Confess>

=item * L<Passwd::Unix::Alt>

I first wrote L<Passwd::Unix::Alt> (a fork of L<Passwd::Unix>) to support
shadow passwd/group files, but later abandoned this fork due to a couple of
fundamental issues and later wrote a clean-slate attempt
L<Unix::Passwd::File>.


Alternate modules: L<Unix::Passwd::File>

=item * L<Module::List::WithPath>

Superseded by L<PERLANCAR::Module::List>.


Alternate modules: L<PERLANCAR::Module::List>

=item * L<App::CreateSparseFile>

I didn't know about the C<fallocate> command.


=item * L<Log::Any::App>

I've written L<Log::ger::App> to be its successor.


Alternate modules: L<Log::ger::App>

=item * L<Package::MoreUtil>

I didn't know about L<Package::Stash>, which does things more properly and
performantly. But I've spun routines not yet covered by Package::Stash to
L<Package::Util::Lite>.


Alternate modules: L<Package::Stash>, L<Package::Util::Lite>

=back

=head1 FAQ

=head2 What are ways to use this module?

Aside from reading it, you can install all the listed modules using
L<cpanmodules>:

    % cpanmodules ls-entries PERLANCAR::Retired | cpanm -n

or L<Acme::CM::Get>:

    % perl -MAcme::CM::Get=PERLANCAR::Retired -E'say $_->{module} for @{ $LIST->{entries} }' | cpanm -n

This module also helps L<lcpan> produce a more meaningful result for C<lcpan
related-mods> when it comes to finding related modules for the modules listed
in this Acme::CPANModules module.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Acme-CPANModulesBundle-PERLANCAR>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Acme-CPANModulesBundle-PERLANCAR>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Acme-CPANModulesBundle-PERLANCAR>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 SEE ALSO

L<Acme::CPANModules> - about the Acme::CPANModules namespace

L<cpanmodules> - CLI tool to let you browse/view the lists

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2020, 2019, 2018 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
