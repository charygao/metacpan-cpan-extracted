#!/usr/bin/perl -w
use strict;
use Test::More (tests => 2);

BEGIN {use Chart::Gnuplot;}

my $temp = "temp.ps";

# Test default setting of legend
{
    my $d = Chart::Gnuplot::DataSet->new(
        func  => "cos(x)",
        title => "cosine function",
    );

    ok($d->_thaw() eq "cos(x) title \"cosine function\"");
}


# Test formatting the legend
{
    my $c = Chart::Gnuplot->new(
        output => $temp,
        legend => {
            position => "outside center bottom",
            order    => "horizontal reverse",
            align    => 'left',
            width    => 3,
            height   => 4,
            title    => 'Trigonometric functions',
            sample   => {length => 10, position => 'left', spacing => 2},
            border   => 'on',
        },
    );

    $c->_setChart();
    ok(&diff($c->{_script}, "legend_1.gp") == 0);
}

###################################################################

# Compare two files
# - return 0 if two files are the same, except the ordering of the lines
# - return 1 otherwise
sub diff
{
    my ($f1, $f2) = @_;
    $f2 = "t/".$f2 if (!-e $f2);

    open(F1, $f1) || return(1);
    open(F2, $f2) || return(1);
    my @c1 = <F1>;
    my @c2 = <F2>;
    close(F1);
    close(F2);
    return(0) if (join("", sort @c1) eq join("", sort @c2));
    return(1);
}
