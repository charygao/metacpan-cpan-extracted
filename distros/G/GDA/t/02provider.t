#!/usr/bin/perl -w
#
# 02provider.t
#
# $Revision: 1.1.1.1 $
#
# Copyright (C) 2001 Gregor N. Purdy. All rights reserved.
#
# This program is free software. It may be modified and/or
# distributed under the same terms as Perl itself.
#

use strict;

print "1..2\n";

use GDA 'libgda-perl-test-02', $GDA::VERSION, $0;
use GDA::Provider;

print "not " if $@;
print "ok 1\n";

my @x = map { $_->name } GDA::Provider->list();
printf "x: %d: %s\n", scalar(@x), join(', ', @x);
print "ok 2\n";

exit 0;

