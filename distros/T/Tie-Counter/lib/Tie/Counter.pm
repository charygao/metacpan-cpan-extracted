package Tie::Counter;

use 5.006;

use strict;
use warnings;
no  warnings 'syntax';

our $VERSION = '2009110701';


sub TIESCALAR {
    my $class     =   shift;
    my $value     =   shift;  #  ?? 0;  # Would have been nice....
       $value     =   0 unless defined $value;
    bless \$value => $class;
}

sub FETCH     {
    ${+shift} ++;
}

sub STORE     {
    my $self  = shift;
    my $value = shift;
    $$self    = $value;
}


"End of Tie::Counter";

__END__

=pod

=head1 NAME

Tie::Counter - Have a counter in a scalar.

=head1 SYNOPSIS

    use Tie::Counter;

    tie my $counter => 'Tie::Counter';

    my @array = qw /Red Green Blue/;

    foreach my $colour (@array) {           # Prints:
        print "  $counter  $colour\n";      #   0  Red
    }                                       #   1  Green
                                            #   2  Blue

=head1 DESCRIPTION

C<Tie::Counter> allows you to tie a scalar in such a way that it increments
each time it is used. This might be useful for interpolating counters in
strings.

The tie takes an optional extra argument, the first value of the counter,
defaulting to 0. Any argument for which magical increment is defined on 
is allowed. Assigning to the counter will set a new value.

=head1 DEVELOPMENT
 
The current sources of this module are found on github,
L<< git://github.com/Abigail/tie--counter.git >>.

=head1 AUTHOR
    
Abigail L<< <test-regexp@abigail.be> >>.

=head1 COPYRIGHT and LICENSE

Copyright (C) 1999, 2009 by Abigail

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

