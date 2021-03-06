# -*- perl -*-
use strict;
use warnings;
use Test::More;

plan skip_all => 'done_testing requires Test::More 0.88' if Test::More->VERSION < 0.88;
plan skip_all => 'This test is only run for the module author'
    unless -d '.git' || $ENV{IS_MAINTAINER};

eval "use Test::Pod::Coverage 1.04";
plan skip_all => "Test::Pod::Coverage 1.04 required for testing POD coverage"
    if $@;

for (all_modules()) {
  if ($_ eq 'B::Utils1::Install::IFiles') {
    diag "skip generated $_";
  } else {
    pod_coverage_ok($_);
  }
}

done_testing;
