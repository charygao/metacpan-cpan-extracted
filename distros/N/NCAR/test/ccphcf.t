# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 1 };
use NCAR;
ok(1); # If we made it this far, we're ok.;

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.
unlink( 'gmeta' );

use PDL;
use NCAR::Test;
use strict;

my ( $IERRF, $LUNIT, $IWTYPE, $IWKID ) = ( 6, 2, 1, 1 );
# 
# This program demonstrates the use of hachures
# 
my ( $M, $N, $LRWK, $LIWK ) = ( 20, 30, 3500, 3500 );
my $ZREG = zeroes float, $M, $N;
my $RWRK = zeroes float, $LRWK;
my $IWRK = zeroes long, $LIWK;

# 
# Create some data
# 
my @t;
open DAT, "<data/ccphcf.dat";
{
  local $/ = undef;
  my $t = <DAT>;
  $t =~ s/^\s*//o;
  $t =~ s/\s*$//o;
  @t = split /\s+/, $t;
}
close DAT;
for my $J ( 1 .. $N ) {
  for my $I ( 1 .. $M ) {
    set( $ZREG, $I-1, $J-1, shift( @t ) );
  }
}
# 
# Open GKS, open and activate a workstation.
# 
&NCAR::gopks ($IERRF, my $ISZDM);
&NCAR::gopwk ($IWKID, $LUNIT, $IWTYPE);
&NCAR::gacwk ($IWKID);
#
# Turn on hachures and demonstrate changing hachure spacing and length
#
&NCAR::cpseti('HCF - HACHURING FLAG',2);
&NCAR::cpsetr('HCS - HACHURE SPACING',.05);
&NCAR::cpsetr('HCL - HACHURE LENGTH',.01);
#
# Initialize Conpack
#
&NCAR::cprect($ZREG,$M,$M,$N,$RWRK,$LRWK,$IWRK,$LIWK);
#
# Draw perimiter
#
&NCAR::cpback($ZREG, $RWRK, $IWRK);
#
# Draw Contours
#
&NCAR::cpcldr($ZREG,$RWRK,$IWRK);
#     
# Close frame and close GKS
#
&NCAR::frame();
# 
# Deactivate and close workstation, close GKS.
# 
&NCAR::gdawk ($IWKID);
&NCAR::gclwk ($IWKID);
&NCAR::gclks();
      
   
rename 'gmeta', 'ncgm/ccphcf.ncgm';
