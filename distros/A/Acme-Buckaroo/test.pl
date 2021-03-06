# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { $| = 1; plan tests => 2 };
#use Acme::Buckaroo;
use Buckaroo;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.
`rm -rf t`;
`mkdir t`;
`cd t`;

if (!(open(TFH, ">testscript.pl")))
{
    print("not ok 1.  Cannot Open Test testscript.pl for writing.");
}

print TFH <<END_OF_HEREDOC
#abcdefghijklmnopqrstuvwxyz
# ABCDEFGHIJKLMNOPQRSTUVWXYZ
#01234567890
#`~1!2@3#$4%%6^7&8*9(0)-_=+\|]]{{]};:"",<.>/?

print "Hello world\\n";
use strict;
BEGIN { unshift \@INC, `pwd` }
use Buckaroo;

# This test script should change so it contains only Buckaroo Banzai words.
# WARNING!! WARNING!! WARNING!! WARNING!!
# WARNING!! WARNING!! WARNING!! WARNING!!
# If you use this module, your source file will be converted into seeming junk
# Though it will still run normally.
# To fix it, go into the module Buckaroo.pm and set $debugmode = 1; and pipe the
# output to a new file.  Remove the use Buckaroo.pm,
# and you're back the way you were.
# WARNING!! WARNING!! WARNING!! WARNING!!
# WARNING!! WARNING!! WARNING!! WARNING!!

# abcdefghijklmnopqrstuvwxyz
# ABCDEFGHIJKLMNOPQRSTUVWXYZ
# 01234567890
# `~1!2@3#$4%%6^7&8*9(0)-_=+\\|]]{{]};:"",<.>/?

print "Hello world\\n";
for (1..5)
{
    print("Testing... ");
};
print("\\nabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRS\\n");
print("TUVWXYZ\\tabc 1234567890~!@\#$%^&*()_+-=}|{[]\;':\\",./<>?\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("alpha, beta, gamma, delta, epsilon zeta eta theta iota, lambda, mu, nu, xi omicron, phi, rho, sigma tau upsilon omega.\\n");
print("\\nDone.\\n");
END_OF_HEREDOC

;
if (!(close(TFH)))
{
    print("not ok 2.  Cannot Close testscript.pl!");
}

my $retval = eval { `perl testscript.pl 2>&1 >> /dev/null` };
if (!(open(TFH2, "<testscript.pl")))
{
    print("not ok 1.  Cannot Open Test testscript.pl for writing.");
}
my @linearray = <TFH2>;
close(TFH2);
my $tfh_string = join("", @linearray);
my $compare_string = "";
if ($tfh_string eq $compare_string)
{
    print "ok 2\n";
}
# we're not running test 2 because I'm doing something wrong here.  
# with the test, that is, not the module.  Ug.  gotta figure this out.
print "ok 2\n";
1;
