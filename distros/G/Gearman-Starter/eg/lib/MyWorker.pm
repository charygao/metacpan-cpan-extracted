package MyWorker;
use strict;
use warnings;
use Storable qw( thaw );
use List::Util qw( sum );

sub job_lazy_sum {
    sleep 10;
    sum @{ thaw($_[0]->arg) };
}

sub job_sum {
    sum @{ thaw($_[0]->arg) };
}

1;
