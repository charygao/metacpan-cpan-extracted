package CPAN::Porters;
use strict;
use warnings;

our $VERSION = '0.03';

1;


=head1 NAME

CPAN::Porters - resource for people maintaining packages of CPAN modules in various distributions

=head1 SYNOPSIS

CPAN modules can be either installed from source (downloaded directly from CPAN)
or they can be installed with the package mangement system of your distribution.

CPAN::Porters is a resource for people who are maintaining those packages in the
various distributions.

=head1 Reasoning

When developing an application we usually don't want to build our own machine. Neither
compile our own kernel. In most of the cases we won't want to compile and install 
our own version of a database engine nor Apache or any other 3rd party tool. 
So my assumption is that we won't want to install our CPAN dependencies either.
Again - in the standard case.

For people just using an application written in Perl it is even more important that they
should not deal with all these packages. Most of us know how much people suffer when they
need to install 10s of modules and their dependencies from CPAN. Especially for modules
with dependencies outside of CPAN.

While CPAN.pm, CPANPLUS.pm have improved a lot they still cannot deal with cases when one 
of the dependencies fails to install cleanly.

In addition while we usually want to work with recent versions of modules from CPAN, 
we usually don't want to get the bleeding edge. Espcially not in applications.

=head1 General resources

L<http://www.szabgab.com/distributions/> Statistics about CPAN modules in the various distributions

=head2 Related mailing lists

Module Authors: L<http://lists.cpan.org/showlist.cgi?name=module-authors>

Perl QA L<http://qa.perl.org> and the mailing list L<http://lists.cpan.org/showlist.cgi?name=perl-qa>

CPAN Testers L<http://testers.cpan.org/>

CPAN Discuss http://lists.cpan.org/showlist.cgi?name=cpan-discuss


=head1 Guidelines for inclusion

In addition to the guidelines of each distribution on which module to include, 
when to upgrade etc. we would like to setup our own guidelines to help people
decide what to include, what would be the priorites, when to upgrade a module
etc.

A few guidelines on how to select and prioritize modules:

=over 4

=item * Modules that are dependencies of another module by a different module author.

=item * Modules that require compilation

=item * Modules that require files not on CPAN

Such modules are especially difficult to install with CPAN.pm or CPANPLUS as they require
files outside the scope of CPAN. Making sure such modules and their dependencies can be
installed with the standard packaging system gets extra points.

=item * Web development frameworks

=item * Modules required by some of the big open source Perl applications.

     For a good listing see the journal entry of brian d foy
     L<http://use.perl.org/~brian_d_foy/journal/9974>

=back

Requirements for inclusion or upgrade

=over 4

=item * The module already has all its prereq in the system

=item * The module passes all its tests with its prereqs currently in the system on the system

=item * The tests of all the currently available dependent modules in the system pass with this new version

=item * A broader requirement would be that the version has no failing test reports on any other system, 
       though this requirement might be too harsh and unnecessary


=back


=head1 Guidelines for module authors

In order to make packaging of CPAN modules for the various distros easier
module authors should create and package their module adhering to some
standards. Following is a wishlist created by the Debian Perl module maintainers:
L<http://people.debian.org/~terpstra/message/20080304.104744.f5ca7c1c.en.html>

=over 4

=item * Sane version numbering

While having the version in a uniform way might be nice, 
it would be already helpful if one module used a consistent scheme.

That is stick try to stick to the whatever version numbering scheme you 
have started.

"We have way too many modules where we have to do {d,u}versionmangling 
because they switch from x.yyyy to x.yy and
x.yy.zz or stuff like that (and we try to add 00$ or strip it or
divide .xxxx into .xx.yy or something like that)."

TODO: list a few reasonable scheme here:

 \d+\.\d\d(_\d\d)?

=item * Copyrights/licensing

Ideally each and every file in given CPAN distribution should have
clearly stated copyright and license information. AUTHORS/CHANGES (if
properly filled) can be used as a source of guessing, but I think
guessing about legal stuff is nothing we want daily.

=item * No interactive prompting during installation

No interactive prompting from Makefile.PL or other parts of the build
system without corresponding (and documented!) ways of setting the same
parameters automatically.

=item * No network access during build

no network access needed for building and testing (or an
easy and documented way to turn network tests off).

=item * Use standar packaging systems

Please use one of the standard Perl module build packages if at all
possible.  (This probably goes without saying.)

=item * Structured POD

POD documentation for modules should be structured as described in the
pod2man man page.  In particular, the NAME section and its content is
mandatory.  Otherwise, one doesn't get a valid man page.

Make sure your POD documentation makes sense when translated with
pod2man. I went several times, i.e., over all of PDF::API2's manpages
because they used "=head1 PDF::API2::Some::Thing" instead of "=head1 NAME".
Those bugs take a _lot_ of time to properly patch!

POD is not just to be used by perldoc.

=item * Don't ship Makefiles

Please don't ship generated Makefiles etc.

=item * Testing

Don't use conditions in tests that test for the existence of author
specfic files or settings (" unless -d '.svn'" or "unless $username eq
'timbo'")

Specifically, don't do this unless that's being used as a criteria for
skipping a test that's really meaningless outside of the author's
environment.  (I do have a few tests in modules that depend on local
infrastructure to run and hence are skipped if they're not run by me.)
 
=back


=head1 Distributions

For our purposes a distribution is one if the Linux (or BSD) distributions with
its own rpm or deb (...) based packaging system. It can also be some stand-alone
Perl package such as the ActivePerl of ActiveState or Vanilla and Strawberry Perl.

=head2 Debian

Perl Packages - the return
L<http://www.debian-administration.org/articles/281>

Building Debian Packages of Perl modules:
L<http://www.debian-administration.org/articles/78>

Debian New Maintainers' Guide L<http://www.debian.org/doc/maint-guide/>

Debian Perl mailing list: L<http://lists.debian.org/debian-perl/>

L<http://pkg-perl.alioth.debian.org/>

The Debian Perl Policy 
L<http://www.debian.org/doc/packaging-manuals/perl-policy/>

The latest versions of CPAN modules built for Debian. 
This site is not related to the official Debian packages. It can be 
good for people who want the latest versions of CPAN modules in 
.deb format. L<http://debian.pkgs.cpan.org/>

Debian Package serach tool will help finding out if a module is
already in included: L<http://www.debian.org/distrib/packages>

Wiki about the Debian Perl Group:
L<http://wiki.debian.org/Teams/DebianPerlGroup>

L<Parse::Debian::Packages>


=head2 Ubuntu

My current understanding is that the best way to get CPAN modules into Ubuntu is to get them 
into Debian unstable and then sync them into Ubuntu universe.

Look at Gutsy Gibson (7.10) development forum L<http://ubuntuforums.org/forumdisplay.php?f=238>
and more specifically at  Requesting New Packages for Inclusion in Gutsy Universe 
L<http://ubuntuforums.org/showthread.php?t=414355>

=head2 Fedora

More details needed.

For now look at 
L<http://fedoraproject.org/> and 

L<http://fedoraproject.org/wiki/PackageMaintainers>

L<http://fedoraproject.org/wiki/SIGs/Perl?action=show&redirect=Perl>

L<http://www.redhat.com/mailman/listinfo/fedora-perl-devel-list>

And the wish-list so far:

=over 4

=item * Clearly and properly copyright your works.

=item * Always apply a widely used and commonly acknowledged license to your works.

=back

=head2 RedHat

=head2 Mandriva

L<MDV::Distribconf>

L<http://wiki.mandriva.com/en/Policies/Perl>

=head2 SuSE


=head2 OpenSUSE

L<http://en.opensuse.org/SUSE_Build_Tutorial#Perl_Packages>

=head2 Gentoo

As in Gentoo the standard way is to install everything from source and they have some way to
channel all CPAN via their system for Gentoo this whole issue is probably not relevant.

=head2 FreeBSD

L<http://people.freebsd.org/~tom/portpm/>

=head2 NetBSD

L<http://www.netbsd.org/docs/pkgsrc/creating.html>

=head2 OpenBSD

L<http://www.openbsd.org/faq/faq15.html>

=head2 ActivePerl

ActivePerl is distribute by ActiveState L<http://www.activestate.com/> Its list of packages
far exceeds of any of the other distributions listed here. It is based on the automatic build
system of ActiveState.

=head2 Strawberry and Vanilla

L<http://win32.perl.org/>

=head2 Sun Solaris

=head2 IBM AIX

=head2 HP-UX


=head1 TODO

=over 4

=item * Collect the basic information for the main distributions

=back

=head1 SEE ALSO

L<http://www.mail-archive.com/module-authors@perl.org/msg05248.html>

L<http://use.perl.org/~Alias/journal/32221>

PIG has moved here: L<http://svn.ali.as/cpan/trunk/PIG/>

cpan2dist is a script from L<CPANPLUS>

=head1 AUTHOR

This document is maintained by Gabor Szabo <gabor@pti.co.il>

=cut

