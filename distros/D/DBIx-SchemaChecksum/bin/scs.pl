#!/usr/bin/perl

use strict;
use warnings;
use DBIx::SchemaChecksum::App;

# PODNAME: scs.pl
# ABSTRACT: run DBIx::SchemaChecksum, but really you should use dbchecksum

DBIx::SchemaChecksum::App->new_with_command->run();

__END__

=pod

=encoding UTF-8

=head1 NAME

scs.pl - run DBIx::SchemaChecksum, but really you should use dbchecksum

=head1 VERSION

version 1.102

=head1 USAGE

Deprecated, please use C<bin/dbchecksum>

=head1 SEE ALSO

See C<perldoc DBIx::SchemaChecksum> for even more info.

=head1 AUTHORS

=over 4

=item *

Thomas Klausner <domm@cpan.org>

=item *

Maroš Kollár <maros@cpan.org>

=item *

Klaus Ita <koki@worstofall.com>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Thomas Klausner, Maroš Kollár, Klaus Ita.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
