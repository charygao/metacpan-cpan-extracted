#!/usr/bin/perl -w

# Copyright 2011 Kevin Ryde

# This file is part of Pod-MinimumVersion.
#
# Pod-MinimumVersion is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published
# by the Free Software Foundation; either version 3, or (at your option) any
# later version.
#
# Pod-MinimumVersion is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with Pod-MinimumVersion.  If not, see <http://www.gnu.org/licenses/>.


## no critic (RequireUseStrict, RequireUseWarnings)
use Pod::MinimumVersion;
my $pmv = Pod::MinimumVersion->new (string => '');
$pmv->reports;

use Test;
BEGIN { plan tests => 1 }
ok (1, 1, 'Pod::MinimumVersion load as first thing');
exit 0;
