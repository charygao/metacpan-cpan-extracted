package IPC::PrettyPipe::Queue::Element;

# ABSTRACT: role for an element in an B<IPC::PrettyPipe::Queue>

use Moo::Role;

use namespace::clean;

our $VERSION = '0.13';

has last => (
    is       => 'rwp',
    default  => sub { 0 },
    init_arg => undef,
);

has first => (
    is       => 'rwp',
    default  => sub { 0 },
    init_arg => undef,
);


1;

#
# This file is part of IPC-PrettyPipe
#
# This software is Copyright (c) 2018 by Smithsonian Astrophysical Observatory.
#
# This is free software, licensed under:
#
#   The GNU General Public License, Version 3, June 2007
#

__END__

=pod

=for :stopwords Diab Jerius Smithsonian Astrophysical Observatory

=head1 NAME

IPC::PrettyPipe::Queue::Element - role for an element in an B<IPC::PrettyPipe::Queue>

=head1 VERSION

version 0.13

=head1 SYNOPSIS

  with 'IPC::PrettyPipe::Queue::Element';

=head1 DESCRIPTION

This role should be composed into objects which will be contained in
B<L<IPC::PrettyPipe::Queue>> objects.  No object should be in more than one
queue at a time.

=head1 METHODS

The following methods are available:

=over

=item first

  $is_first = $element->first;

This returns true if the element is the first in its containing queue.

=item last

  $is_last = $element->last;

This returns true if the element is the last in its containing queue.

=back

=head1 SUPPORT

=head2 Bugs

Please report any bugs or feature requests to bug-ipc-prettypipe@rt.cpan.org  or through the web interface at: https://rt.cpan.org/Public/Dist/Display.html?Name=IPC-PrettyPipe

=head2 Source

Source is available at

  https://gitlab.com/djerius/ipc-prettypipe

and may be cloned from

  https://gitlab.com/djerius/ipc-prettypipe.git

=head1 SEE ALSO

Please see those modules/websites for more information related to this module.

=over 4

=item *

L<IPC::PrettyPipe|IPC::PrettyPipe>

=back

=head1 AUTHOR

Diab Jerius <djerius@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2018 by Smithsonian Astrophysical Observatory.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
