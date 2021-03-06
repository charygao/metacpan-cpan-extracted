#!/usr/bin/perl -sw
##
## 01-encode_content.t
##
## Copyright (c) 2001, Vipul Ved Prakash.  All rights reserved.
## This code is free software; you can redistribute it and/or modify
## it under the same terms as Perl itself.
##
## $Id: 03-armour-compress.t,v 1.1.1.1 2001/03/18 07:27:39 vipul Exp $

use lib '../lib';
use Convert::ASCII::Armour;

print "1..8\n";
my $i = 0;
my $converter = new Convert::ASCII::Armour;

my %data = ( Message  => "This is a message",
             Number   => "8989323", 
             Date     => "13 March, 2001",
             Longline => "abcdefghijklmnopqrstuvwxyz\
                          ABCDEFGHIJKLMNOPQRSTUVWZYZ\ 
                          123456789\
                          ~!@#$%^&*()-_=+[{]}\|"
           );

my %headers = ( 
                Scheme  => "Crypt::RSA::EME::OAEP", 
                Version => "1.24"
              );

my $encoded = $converter->armour ( 
                Content  => \%data, 
                Headers  => \%headers,
                Object   => "RSA ENCRYPTED MESSAGE", 
                Compress => 1
              );

print "$encoded\n";
print $encoded ? "ok " : "not ok "; print ++$i . "\n";

$decoded = $converter->unarmour ( $encoded ) or die $converter->errstr;

print $data{Longline} eq $$decoded{Content}{Longline} ? "ok " : "not ok "; print ++$i . "\n";
print $data{Number} eq $$decoded{Content}{Number} ? "ok " : "not ok "; print ++$i . "\n";
print $data{Date} eq $$decoded{Content}{Date} ? "ok " : "not ok "; print ++$i . "\n";
print $data{Message} eq $$decoded{Content}{Message} ? "ok " : "not ok "; print ++$i . "\n";
print $headers{Scheme} eq $$decoded{Headers}{Scheme} ? "ok " : "not ok "; print ++$i . "\n";
print $headers{Version} eq $$decoded{Headers}{Version} ? "ok " : "not ok "; print ++$i . "\n";
print "RSA ENCRYPTED MESSAGE" eq $$decoded{Object} ? "ok " : "not ok "; print ++$i . "\n";

