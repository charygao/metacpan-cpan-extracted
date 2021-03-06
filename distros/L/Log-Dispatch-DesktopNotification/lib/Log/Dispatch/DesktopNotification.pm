use strict;
use warnings;
package Log::Dispatch::DesktopNotification; # git description: v0.02-12-gd103704
# ABSTRACT: Send log messages to a desktop notification system

our $VERSION = '0.03';

use Module::Load qw/load/;
use Module::Load::Conditional qw/can_load/;
use namespace::clean 0.19;

#pod =head1 SYNOPSIS
#pod
#pod     my $notify = Log::Dispatch::DesktopNotification->new(
#pod         name      => 'notify',
#pod         min_level => 'debug',
#pod         app_name  => 'MyApp',
#pod     );
#pod
#pod =head1 METHODS
#pod
#pod =head2 new
#pod
#pod Creates a new L<Log::Dispatch> output that can be used to graphically notify a
#pod user on this system. Uses C<output_class> and calls C<new> on the returned
#pod class, passing along all arguments.
#pod
#pod =cut

sub new {
    my ($class, @args) = @_;
    return $class->output_class->new(@args);
}

#pod =head2 output_class
#pod
#pod Returns the name of a L<Log::Dispatch::Output> class that is suitable to
#pod graphically notify a user on the current system.
#pod
#pod On MacOS X, that will be L<Log::Dispatch::MacGrowl>. On other systems,
#pod L<Log::Dispatch::Desktop::Notify> will be returned if it is available and usable.
#pod Otherwise, L<Log::Dispatch::Null> will be returned.
#pod
#pod =cut

sub output_class {
    if ($^O eq 'darwin') {
        my $mod = 'Log::Dispatch::MacGrowl';
        load $mod; return $mod;
    }

    my $mod = 'Log::Dispatch::Desktop::Notify';
    load $mod; return $mod;
}

#pod =head1 LIMITATIONS
#pod
#pod Currently only supports Mac OS X and systems on which notification-daemon is
#pod available (most *N*Xes).
#pod
#pod =head1 SEE ALSO
#pod
#pod =for :list
#pod * L<Log::Dispatch>
#pod * L<Log::Dispatch::Desktop::Notify>
#pod * L<Log::Dispatch::MacGrowl>
#pod * L<Log::Dispatch::Null>
#pod
#pod =cut

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Log::Dispatch::DesktopNotification - Send log messages to a desktop notification system

=head1 VERSION

version 0.03

=head1 SYNOPSIS

    my $notify = Log::Dispatch::DesktopNotification->new(
        name      => 'notify',
        min_level => 'debug',
        app_name  => 'MyApp',
    );

=head1 METHODS

=head2 new

Creates a new L<Log::Dispatch> output that can be used to graphically notify a
user on this system. Uses C<output_class> and calls C<new> on the returned
class, passing along all arguments.

=head2 output_class

Returns the name of a L<Log::Dispatch::Output> class that is suitable to
graphically notify a user on the current system.

On MacOS X, that will be L<Log::Dispatch::MacGrowl>. On other systems,
L<Log::Dispatch::Desktop::Notify> will be returned if it is available and usable.
Otherwise, L<Log::Dispatch::Null> will be returned.

=head1 LIMITATIONS

Currently only supports Mac OS X and systems on which notification-daemon is
available (most *N*Xes).

=head1 SEE ALSO

=over 4

=item *

L<Log::Dispatch>

=item *

L<Log::Dispatch::Desktop::Notify>

=item *

L<Log::Dispatch::MacGrowl>

=item *

L<Log::Dispatch::Null>

=back

=head1 SUPPORT

Bugs may be submitted through L<the RT bug tracker|https://rt.cpan.org/Public/Dist/Display.html?Name=Log-Dispatch-DesktopNotification>
(or L<bug-Log-Dispatch-DesktopNotification@rt.cpan.org|mailto:bug-Log-Dispatch-DesktopNotification@rt.cpan.org>).

=head1 AUTHOR

Florian Ragwitz <rafl@debian.org>

=head1 CONTRIBUTORS

=for stopwords Karen Etheridge Christian Garbs

=over 4

=item *

Karen Etheridge <ether@cpan.org>

=item *

Christian Garbs <mitch@cgarbs.de>

=back

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2009 by Florian Ragwitz.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
