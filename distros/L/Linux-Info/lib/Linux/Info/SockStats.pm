package Linux::Info::SockStats;
use strict;
use warnings;
use Carp qw(croak);
our $VERSION = '1.5'; # VERSION

=head1 NAME

Linux::Info::SockStats - Collect linux socket statistics.

=head1 SYNOPSIS

    use Linux::Info::SockStats;

    my $lxs  = Linux::Info::SockStats->new;
    my $stat = $lxs->get;

=head1 DESCRIPTION

Linux::Info::SockStats gathers socket statistics from the virtual F</proc> filesystem (procfs).

For more information read the documentation of the front-end module L<Linux::Info>.

=head1 SOCKET STATISTICS

Generated by F</proc/net/sockstat>.

    used    -  Total number of used sockets.
    tcp     -  Number of tcp sockets in use.
    udp     -  Number of udp sockets in use.
    raw     -  Number of raw sockets in use.
    ipfrag  -  Number of ip fragments in use (only available by kernels > 2.2).

=head1 METHODS

=head2 new()

Call C<new()> to create a new object.

    my $lxs = Linux::Info::SockStats->new;

It's possible to set the path to the proc filesystem.

     Linux::Info::SockStats->new(
        files => {
            # This is the default
            path => '/proc',
            sockstat => 'net/sockstat',
        }
    );

=head2 get()

Call C<get()> to get the statistics. C<get()> returns the statistics as a hash reference.

    my $stat = $lxs->get;

=head1 EXPORTS

Nothing.

=head1 SEE ALSO

=over

=item *

B<proc(5)>

=item *

L<Linux::Info>

=back

=head1 AUTHOR

Alceu Rodrigues de Freitas Junior, E<lt>arfreitas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 of Alceu Rodrigues de Freitas Junior, E<lt>arfreitas@cpan.orgE<gt>

This file is part of Linux Info project.

Linux-Info is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Linux-Info is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Linux Info.  If not, see <http://www.gnu.org/licenses/>.

=cut

sub new {
    my $class = shift;
    my $opts = ref( $_[0] ) ? shift : {@_};

    my %self = (
        files => {
            path     => '/proc',
            sockstat => 'net/sockstat',
        }
    );

    foreach my $file ( keys %{ $opts->{files} } ) {
        $self{files}{$file} = $opts->{files}->{$file};
    }

    return bless \%self, $class;
}

sub get {
    my $self  = shift;
    my $class = ref $self;
    my $file  = $self->{files};
    my %socks = ();

    my $filename =
      $file->{path} ? "$file->{path}/$file->{sockstat}" : $file->{sockstat};
    open my $fh, '<', $filename
      or croak "$class: unable to open $filename ($!)";

    while ( my $line = <$fh> ) {
        if ( $line =~ /sockets: used (\d+)/ ) {
            $socks{used} = $1;
        }
        elsif ( $line =~ /TCP: inuse (\d+)/ ) {
            $socks{tcp} = $1;
        }
        elsif ( $line =~ /UDP: inuse (\d+)/ ) {
            $socks{udp} = $1;
        }
        elsif ( $line =~ /RAW: inuse (\d+)/ ) {
            $socks{raw} = $1;
        }
        elsif ( $line =~ /FRAG: inuse (\d+)/ ) {
            $socks{ipfrag} = $1;
        }
    }

    close($fh);
    return \%socks;
}

1;
