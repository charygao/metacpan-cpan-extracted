package Project::Euler::Problem::P002;

use Carp;
use Modern::Perl;
use Moose;

with 'Project::Euler::Problem::Base';
use Project::Euler::Lib::Types  qw/ PosInt  PosIntArray /;

use Math::Big 1.12  qw/ fibonacci /;
use Project::Euler::Lib::MultipleCheck;


use List::Util qw/ sum /;

my $multiple_check = Project::Euler::Lib::MultipleCheck->new(
    multi_nums => [2],
    check_all  => 1,
);



=head1 NAME

Project::Euler::Problem::P002 - Solutions for problem 002

=head1 VERSION

Version v0.1.2

=cut

use version 0.77; our $VERSION = qv("v0.1.2");


=head1 SYNOPSIS

L<< http://projecteuler.net/index.php?section=problems&id=2 >>

    use Project::Euler::Problem::P002;
    my $p2 = Project::Euler::Problem::P002->new;

    my $default_answer = $p2->solve;

=head1 DESCRIPTION

This module is used to solve problem #002

This is a simple problem which computes the fib numbers upto a certain maximum
and sums all of them that are even (or as implemented here, divisible by every
multi_nums)

=head1 Problem Attributes

=head2 Multiple Numbers

An array of positive numbers that are used to filter out the fib numbers

    [2]

=cut

has 'multi_nums' => (
    is       => 'rw',
    isa      => PosIntArray,
    required => 1,
    default  => sub { return [2] },
);
around 'multi_nums' => sub {
    my ($func, $self, $args) = @_;

    if  (ref $args) {
        $self->$func( [sort {$a <=> $b} @$args] );
    }
    else {
        $self->$func();
    }
};

=head1 SETUP

=head2 Problem Number

    002

=cut

sub _build_problem_number {
    #  Must be an int > 0
    return 2;
}


=head2 Problem Name

    Sum filtered fib numbers

=cut

sub _build_problem_name {
    #  Must be a string whose length is between 10 and 80
    return q{Sum filtered fib numbers};
}


=head2 Problem Date

    2001-10-19

=cut

sub _build_problem_date {
    return q{19 October 2001};
}


=head2 Problem Desc

Each new term in the Fibonacci sequence is generated by adding the previous two
terms. By starting with 1 and 2, the first 10 terms will be:

1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

Find the sum of all the even-valued terms in the sequence which do not exceed
four million.

=cut

sub _build_problem_desc {
    return <<'__END_DESC';
Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:

1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

Find the sum of all the even-valued terms in the sequence which do not exceed four million.
__END_DESC
}


=head2 Default Input

    Max number to go up to: 4,000,000

=cut

sub _build_default_input {
    return 4_000_000;
}


=head2 Default Answer

    4,613,732

=cut

sub _build_default_answer {
    return 4_613_732;
}


=head2 Has Input?

    Yes

=cut

#has '+has_input' => (default => 0);


=head2 Help Message

You can change C<< multi_nums >> to alter the way the program will function.  If you
are providing custom_input, don't forget to specify the wanted_answer if you
know it!

=cut

sub _build_help_message {
    return <<'__END_HELP';
You can change multi_nums to alter the way the program will function.  If you
are providing custom_input, don't forget to specify the wanted_answer if you
know it!
__END_HELP

}



=head1 INTERNAL FUNCTIONS

=head2 Validate Input

The restrictions on custom_input

    A positive integer

=cut

sub _check_input {
      my ( $self, $input, $old_input ) = @_;

      if ($input !~ /\D/ or $input < 1) {
          croak sprintf(q{Your input, '%s', must be all digits and >= 1}, $input);
      }
}



=head2 Solving the problem

Use L<< Math::Big >> to find fib numbers upto $max, filter them, and find the sum

=cut

sub _solve_problem {
    my ($self, $max) = @_;

    #  If the user didn't give us a max, then use the default_input
    $max //= $self->default_input;

    #  Tell the checker object the numbers to filter on
    $multiple_check->multi_nums($self->multi_nums);

    my $sum = 0;
    my $num = 1;

    #  Turn the Math::BigInt object into an int
    my $ans = fibonacci($num++)->numify;

    while ($ans < $max) {
        $sum += $ans  if  $multiple_check->check($ans);
        $ans = fibonacci($num++)->numify;
    }

    return $sum;
}


=head1 AUTHOR

Adam Lesperance, C<< <lespea at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-project-euler at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Project-Euler>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Project::Euler::Problem::P002

=head1 ACKNOWLEDGEMENTS

L<< Math::Big >>

=head1 COPYRIGHT & LICENSE

Copyright 2009 Adam Lesperance.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut


#  Cleanup the Moose stuff
no Moose;
__PACKAGE__->meta->make_immutable;
1; # End of Project::Euler::Problem::P002
