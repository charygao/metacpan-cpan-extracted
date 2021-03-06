# ====================================================================
# Copyright (c) 2006 by Peter Liscovius. All rights reserved.
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
# ====================================================================

# $Author: peterdd $
# $Id: VideoStream.pm,v 1.3 2007/09/29 08:08:15 peterdd Exp $

package SWF::VideoStream;
use SWF();

use strict;

$SWF::Sound::VERSION = $SWF::VERSION;

1;

__END__

=head1 NAME

SWF::VideoStream - SWF Video class

=head1 SYNOPSIS

	use SWF::VideoStream;
	$videostream = new SWF::VideoStream("test.flv");


=head1 DESCRIPTION

	XXX

=head1 AUTHOR

	developers of ming 
	ming.sourceforge.net

=head1 SEE ALSO

SWF, SWF::Action, SWF::Movie, SWF::MovieClip, SWF::Sound

=cut
