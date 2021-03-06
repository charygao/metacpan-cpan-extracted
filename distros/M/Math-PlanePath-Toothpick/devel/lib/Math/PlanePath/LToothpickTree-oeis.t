#!/usr/bin/perl -w

# Copyright 2012 Kevin Ryde

# This file is part of Math-PlanePath-Toothpick.
#
# Math-PlanePath-Toothpick is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published
# by the Free Software Foundation; either version 3, or (at your option) any
# later version.
#
# Math-PlanePath-Toothpick is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General
# Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with Math-PlanePath-Toothpick.  If not, see <http://www.gnu.org/licenses/>.


use 5.004;
use strict;
use Test;
plan tests => 4;

use lib 't','xt';
use MyTestHelpers;
MyTestHelpers::nowarnings();
use MyOEIS;

use Math::PlanePath::LToothpickTree;

# uncomment this to run the ### lines
#use Smart::Comments '###';

my $max_count = undef;

#------------------------------------------------------------------------------
# A172310 - "L" total cells

MyOEIS::compare_values
  (anum => 'A172310',
   max_count => $max_count,
   func => sub {
     my ($count) = @_;
     my $path = Math::PlanePath::LToothpickTree->new;
     my @got;
     my $total = 0;
     for (my $depth = 0; @got < $count; $depth++) {
       push @got, $path->tree_depth_to_n($depth);
     }
     return \@got;
   });

#------------------------------------------------------------------------------
# A172311 - "L" cells added

MyOEIS::compare_values
  (anum => 'A172311',
   max_count => $max_count,
   func => sub {
     my ($count) = @_;
     my $path = Math::PlanePath::LToothpickTree->new;
     my @got = (0);
     for (my $depth = 0; @got < $count; $depth++) {
       my $added = ($path->tree_depth_to_n($depth+1)
                    - $path->tree_depth_to_n($depth));
       push @got, $added;
     }
     return \@got;
   });

#------------------------------------------------------------------------------
# A172312 - "L" cells added / 2

MyOEIS::compare_values
  (anum => 'A172312',
   max_count => $max_count,
   func => sub {
     my ($count) = @_;
     my $path = Math::PlanePath::LToothpickTree->new;
     my @got;
     for (my $depth = 1; @got < $count; $depth++) {
       my $added = ($path->tree_depth_to_n($depth+1)
                    - $path->tree_depth_to_n($depth));
       push @got, $added/2;
     }
     return \@got;
   });

#------------------------------------------------------------------------------
exit 0;
