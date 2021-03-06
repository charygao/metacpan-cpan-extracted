#!/usr/bin/perl

use warnings;
use strict;

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

use Test::More tests => 1;

BEGIN {
    use_ok('Bot::BasicBot::Pluggable::Module::Notify');
};

#########################
