use strict;
use warnings;

package warnings::lock;
# ABSTRACT: Lock down the set of warnings active in a lexical scope

our $VERSION = '1';

use Variable::Magic 'wizard', 'cast';


my $hints_key = __PACKAGE__ . '/desired_warning_bits';

my $wiz = wizard set => sub {
    ${^WARNING_BITS} = $^H{$hints_key}
        if exists $^H{$hints_key};
};

sub import {
    $^H |= 0x20000;
    $^H{$hints_key} = ${^WARNING_BITS};
    cast ${^WARNING_BITS} => $wiz;
}

sub unimport {
    delete $^H{$hints_key};
}

1;

__END__

=pod

=head1 NAME

warnings::lock - Lock down the set of warnings active in a lexical scope

=head1 VERSION

version 1

=head1 SYNOPSIS

    # Set up warnings just the way we want them
    use warnings;
    use feature 'signatures';
    no warnings 'experimental::signatures';

    # Lock warnings into their current state
    use warnings::lock;

    # Import additional modules which might attempt to change our warnings
    # configuration
    use Moose;
    ...

    # Use of signatures feature will not warn
    sub greeting ($name) { print "Hello $name!" }

=head1 DESCRIPTION

This module allows you to lock down the set of warnings active within a lexical
scope. This is useful to protect yourself from other modules you C<use>
overwriting the warnings configuration you set up.

=head1 PROBLEM

Perl's L<warnings> are really useful. It's generally a good idea to turn them on
with C<use warnings>.

However, sometimes you might have a good reason to turn off specific warnings
which C<use warnings> enabled. One common example is to disable warnings for
experimental features: C<no warnings 'experimental::signatures'>.

For better or worse, it has become rather popular for certain kinds of CPAN
modules to try to ensure that their users have warnings enabled. While well
intentioned, this sometimes has unintended consequences.

If you import one of those modules, such as L<Moose>, after setting up your
warnings as described above, the warnings configuration will be reverted back to
perl's default set of warnings, even though you explicitly asked for certain
default warnings to be disabled.

This is unfortunate.

=head1 WORKAROUND

The problem can be worked around by paying close attention to the order of
imports in your code and ensuring that your personal warnings configuration is
only applied B<after> any other modules which might change warnings are
imported.

Unfortunately there are drawbacks to that approach. Moving your configuration to
after all your imports might cause more of your code to run without the warnings
you wanted enabled. This is made worse by the common practise of many
organizations to use site-specific pragmas to define their Perl language
preferences such as strictures, warnings, features, syntax extensions, safety
measures, and so on. In that scenario it's even more important to apply that
configuration early.

=head1 SOLUTION

Instead of making our warnings changes as late as possible to ensure nothing
else will accidentally overwrite them, it would be nice to just set up warnings
exactly the way we want them to be and then lock them into place, preventing any
other modules from making modifications to them.

This is what C<warnings::lock> provides.

It's especially handy when used as part of a site-wide pragma setting up
warnings and other language preferences, in which case the user of the pragma
doesn't usually have to be aware of C<warnings::lock> being used.

=head1 UNLOCKING WARNINGS

The only case the users of your site-wide pragma might have to be aware of
C<warnings::lock>'s existence is when they need to temporarily disable certain
warnings for a new lexical scope.

With C<warnings::lock> in effect, even the L<warnings> module itself won't be
able to change warnings, and so the following idiom won't do what you'd expect:

    {
        no warnings 'recursion';
        ...
    }

Within that block, C<recursion> warnings would still be enabled. The current
solution is to disable warning locking within that same scope before turning off
additional warnings:

    {
        no warnings::lock;
        no warnings 'recursion';

        # deep recursion warnings disabled for the rest of this block
        ...
    }

    # deep recursion warnings enabled again after the block
    ...

This isn't great, but seems a lot less error-prone than trusting to never get
the import order wrong anywhere. If you think this is terrible, the authors
would love to talk to you about how to improve things. Options include raising a
warning or an exception when L<warnings> is used directly within a lexical scope
affected by L<warnings::lock>, always permitting direct L<warnings> usage while
only preventing modifications from other imports, or supporting something along
the lines of C<no warnings::lock 'recursion'>. Please get in touch!

=head1 SEE ALSO

=for :list * L<warnings>
    * L<feature>
    * L<experimental>

=head1 IMPLEMENTATION

This module is using L<Variable::Magic> to cast C<MAGIC> onto the special
C<${^WARNING_BITS}> global variable. After importing the module, every write to
C<${^WARNING_BITS}> will result in its value being immediately overwritten by
the value it had during import of this module.

A number of different ways of implementing this module have been explored by the
authors, but we eventually settled on the above as it seems to be the most
robust implementation we could come up with without having to resort to writing
C code, using C<tie>, customizing C<CORE::GLOBAL::require>, or overriding
foreign module's C<import> method.

If you think you know a better way, or if you've discovered a bug or limitation
caused by the current implementation, please let us know! We'll be happy to
consider better alternatives as long as backwards compatibility can be largely
preserved.

=head1 AUTHORS

=over 4

=item *

Florian Ragwitz <rafl@debian.org>

=item *

William Stevenson <wstevenson@maxmind.com>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by MaxMind, Inc..

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
