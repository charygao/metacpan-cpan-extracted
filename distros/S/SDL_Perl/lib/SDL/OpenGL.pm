# SDL::OpenGL.pm
#
#	A simplified OpenGL wrapper
#
# Copyright (C) 2002, 2003, 2004 David J. Goehrig
#

package SDL::OpenGL;

require Exporter;
require DynaLoader;
use vars qw(
	@EXPORT
	@ISA
);
@ISA=qw(Exporter DynaLoader);

use SDL;
use SDL::OpenGL::Constants;

bootstrap SDL::OpenGL;
for ( keys %SDL::OpenGL:: ) {
	if (/^gl/) {
		push @EXPORT,$_;
	}
}

# export all GL constants
for (@SDL::OpenGL::Constants::EXPORT) {
	push @EXPORT, $_;
}


1;

__END__;

=pod



=head1 NAME

SDL::OpenGL - a perl extension

=head1 DESCRIPTION

L<SDL::OpenGL> is a perl module which when used by your application
exports the gl* and glu* functions into your application's primary namespace.
Most of the functions described in the OpenGL 1.3 specification are currently
supported in this fashion.  As the implementation of the OpenGL bindings that
comes with SDL_perl is largely type agnositic, there is no need to decline
the function names in the fashion that is done in the C API. For example,
glVertex3d is simply glVertex, and perl just does the right thing with regards
to types.

=head1 CAVEATS

The following methods work different in Perl than in C:

=over 2

=item glCallLists

        glCallLists(@array_of_numbers);

Unlike the C function, which get's passed a count, a type and a list of
numbers, the Perl equivalent only takes a list of numbers.

Note that this is slow, since it needs to allocate memory and construct a
list of numbers from the given scalars. For a faster version see
L<glCallListsString>.

=back

The following methods exist in addition to the normal OpenGL specification:

=over 2

=item glCallListsString

        glCallListsString($string);

Works like L<glCallLists()>, except that it needs only one parameter, a scalar
holding a string. The string is interpreted as a set of bytes, and each of
these will be passed to glCallLists as GL_BYTE. This is faster than
glCallLists, so you might want to pack your data like this:

        my $lists = pack("C", @array_of_numbers);

And later use it like this:

        glCallListsString($lists);

=back

=head1 AUTHOR

David J. Goehrig

=head1 SEE ALSO

L<perl> L<SDL::App>

=cut
