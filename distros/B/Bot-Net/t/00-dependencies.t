#!/usr/bin/env perl

use warnings;
use strict;

# This module was taken from the Jifty t/01-dependencies.t test. Very handy.

=head1 DESCRIPTION

Makes sure that all of the modules that are 'use'd are listed in the
Makefile.PL as dependencies.

=cut

use Test::More;
use File::Find;
eval "use Module::CoreList"; 
plan skip_all => "Module::CoreList is not installed." if $@;
plan 'no_plan';

my %used;
find( \&wanted, qw/ lib t /);

sub wanted {
    return unless -f $_;
    return if $File::Find::dir =~ m!/.svn($|/)!;
    return if $File::Find::name =~ /~$/;
    return if $File::Find::name =~ /generate-changelog/;
    return if $File::Find::name =~ /\.(pod|html)$/;
    
    # read in the file from disk
    my $filename = $_;
    local $/;
    open(FILE, $filename) or return;
    my $data = <FILE>;
    close(FILE);

    # strip pod, in a really idiotic way.  Good enough though
    $data =~ s/^=head.+?(^=cut|\Z)//gms;

    # look for use and use base statements
    $used{$1}{$filename}++ while $data =~ /^\s*use\s+([\w:]+)/gm;
    while ($data =~ m|^\s*use base qw.([\w\s:]+)|gm) {
        $used{$_}{$filename}++ for split ' ', $1;
    }
}

my %required;
{ 
    local $/;
    ok(open(MAKEFILE,"Makefile.PL"), "Opened Makefile");
    my $data = <MAKEFILE>;
    close(FILE);
    while ($data =~ /^\s*?(?:requires|recommends)\s*\(?\s*'([\w:]+)'(?:\s*=>\s*['"]?([\d\.]+)['"]?)?.*?(?:#(.*))?$/gm) {
        $required{$1} = $2;
        if (defined $3 and length $3) {
            $required{$_} = undef for split ' ', $3;
        }
    }
}

for (sort keys %used) {
    my $first_in = Module::CoreList->first_release($_);
    next if defined $first_in and $first_in <= 5.00803;
    next if /^(Bot::Net|TestNet|inc|t)(::|$)/;
    ok(exists $required{$_}, "$_ in Makefile.PL")
      or diag("used in ", join ", ", sort keys %{ $used{$_ } });
    delete $used{$_};
    delete $required{$_};
}

for (sort keys %required) {
    my $first_in = Module::CoreList->first_release($_, $required{$_});
    fail("Required module $_ (v. $required{$_}) is in core since $first_in") if defined $first_in and $first_in <= 5.008003;
}

1;

