#!/usr/bin/perl -w
# -*-mode:cperl-*-

# Name:   40_test4a.t
# Author: wd (Wolfgang.Dobler@kis.uni-freiburg.de)
# Date:   06-Feb-2005
# Description:
#   Part of test suite for Namelist module

use strict;
use Test::More tests => 6;
use Fortran::F90Namelist::Group;

# 1. Object creation
my $nlgrp = Fortran::F90Namelist::Group->new();
isa_ok($nlgrp, 'Fortran::F90Namelist::Group');

## Read reference file
my $hash;
{ local $/;
  open(HASH,"< t/files/test4a.hash")
    or die "Couldn't open reference file t/files/test4a.hash";
  $hash = <HASH>;
  close(HASH);
}
my ($namesref, $nlists, $hashref);
eval("$hash");
die "$@\n" if ($@);
#
my $parseresp = $nlgrp->parse(file => "t/files/test4a.nml");

# 2.+3. Result from parsing
is( defined($parseresp), 1,         'parsing');
is( $parseresp,          $nlists,   'parse() return value');
# 4.-6. Compare with reference values
is($nlgrp->nlists,       $nlists,   'nslots');
is_deeply($nlgrp->names, $namesref, 'names');
is_deeply($nlgrp->hash,  $hashref,  'data');

# End of file 40_test4a.t
