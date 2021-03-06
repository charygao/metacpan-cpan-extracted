package Data::BISON::Constants;

use warnings;
use strict;
use Carp;
use base qw(Exporter);

our @EXPORT = qw(
  FMB PWL UTF8 NULL UNDEF TRUE FALSE INT8 INT16 INT24 INT32 INT40 INT48
  INT56 INT64 FLOAT DOUBLE STRING ARRAY HASH STREAM OBJECT VERSION
  MIN_VER CUR_VER
);

use version; our $VERSION = qv( '0.0.3' );

use constant FMB  => 'FMB';
use constant PWL  => 'pwl';
use constant UTF8 => 'UTF-8';
use constant {
    NULL    => 0x01,
    UNDEF   => 0x02,
    TRUE    => 0x03,
    FALSE   => 0x04,
    INT8    => 0x05,
    INT16   => 0x06,
    INT24   => 0x07,
    INT32   => 0x08,
    INT40   => 0x09,
    INT48   => 0x0A,
    INT56   => 0x0B,
    INT64   => 0x0C,
    FLOAT   => 0x0D,
    DOUBLE  => 0x0E,
    STRING  => 0x0F,
    ARRAY   => 0x10,
    HASH    => 0x11,
    STREAM  => 0x12,
    OBJECT  => 0x13,
    BACKREF => 0x14,
    VERSION => 0xFF,
};

use constant MIN_VER => 1;
use constant CUR_VER => 1;

1;
__END__

=head1 NAME

Data::BISON::Constants - Various constants for BISON encoder, decoder

=head1 VERSION

This document describes Data::BISON::Constants version 0.0.3

=head1 AUTHOR

Andy Armstrong  C<< <andy@hexten.net> >>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2007, Andy Armstrong C<< <andy@hexten.net> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
