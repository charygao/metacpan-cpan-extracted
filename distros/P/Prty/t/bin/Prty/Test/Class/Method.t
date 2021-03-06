#!/usr/bin/env perl

package Prty::Test::Class::Method::Test;
use base qw/Prty::Test::Class/;

use strict;
use warnings;
use v5.10.0;

# -----------------------------------------------------------------------------

sub test_loadClass : Init(1) {
    shift->useOk('Prty::Test::Class::Method');
}

# -----------------------------------------------------------------------------

package main;
Prty::Test::Class::Method::Test->runTests;

# eof
