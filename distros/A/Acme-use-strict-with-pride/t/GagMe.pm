#!/usr/local/bin/perl -w
# A tied hash for testing.
package GagMe;
use strict;

sub TIEHANDLE {
    my $class = shift;
    bless(\( my $ref = ''), $class);
}

sub PRINT {
    my $self = shift;
    $$self .= join('', @_);
}

sub read {
    my $self = shift;
    return substr($$self, 0, length($$self), '');
}

1;
