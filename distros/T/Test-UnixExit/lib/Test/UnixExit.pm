# -*- Perl -*-
#
# Tests exit status words

package Test::UnixExit;

use 5.006;
use strict;
use warnings;
use Carp qw(croak);
use Test::Builder;

our $VERSION = '0.01';

require Exporter;
use vars qw(@ISA @EXPORT);
@ISA    = qw(Exporter);
@EXPORT = qw(exit_is);

my $test = Test::Builder->new;
my @keys = qw(code signal iscore);

sub exit_is {
    my ( $status, $expected_value, $name ) = @_;

    croak "Usage: status expected-value test-name"
      if !defined $status
      or !defined $expected_value;

    if ( $expected_value =~ m/^[0-9]+$/ ) {
        $expected_value = { code => $expected_value };
    } elsif ( ref $expected_value ne 'HASH' ) {
        croak "expected-value must be integer or hash reference";
    }
    for my $key (@keys) {
        $expected_value->{$key} = 0
          if !exists $expected_value->{$key}
          or !defined $expected_value->{$key};
    }

    my $got_value;
    $got_value->{code}   = $status >> 8;
    $got_value->{signal} = $status & 127;
    $got_value->{iscore} = $status & 128 ? 1 : 0;

    my $passed = 1;
    for my $key (@keys) {
        if ( $got_value->{$key} != $expected_value->{$key} ) {
            $passed = 0;
            last;
        }
    }
    $test->ok( $passed, $name );

    $test->diag(
        sprintf
          "Got:      code=%-3d signal=%-2d iscore=%d\nExpected: code=%-3d signal=%-2d iscore=%d\n",
        map( { $got_value->{$_} } @keys ),
        map( { $expected_value->{$_} } @keys )
    ) if !$passed;

    return $passed;
}

1;
__END__

=head1 NAME

Test::UnixExit - tests exit status words

=head1 SYNOPSIS

  #use Expect;
  #use Test::Cmd;
  #use Test::Most;
  use Test::UnixExit;

  # ... some call that sets $? here or $expect->exitstatus ...

  exit_is( $?, 0, "exited ok" );
  exit_is( $?, { code => 0, signal => 2, iscore => 0 }, "SIGINT" );

=head1 DESCRIPTION

This module provides a means to check that the exit status word conforms
to a particular pattern, including what signal and whether a core was
generated; the simple C<<<$? >> 8 == 0>>> test discards those last
two points. This code is most useful when testing external commands via
C<system>, L<Test::Cmd>, or L<Expect>; perl code itself may instead be
tested with other modules such as L<Test::Exit> or L<Test::Trap>.

Internally L<Test::Builder> is used, so this module might best be paired
with L<Test::Most> (and is otherwise untested with other test modules).

=head1 FUNCTION

The one function is exported by default. Sorry about that.

=over 4

=item B<exit_is> I<status>, I<expected-value>, I<test-name>

This function accepts a I<status> (the 16-bit return value from the
C<wait(2)> call), an I<expected-value> as either an 8-bit exit code or a
hash reference with various fields set, and an optional name of the
test. Whether or not the test passed is the return value.

The fields for the hash reference are:

    code   => 8-bit exit status number (WEXITSTATUS)
    iscore => 1 or 0 if a core file was created or not
    signal => what signal the process ate (WTERMSIG), if any

Unspecified fields default to 0, though will be checked against the
provided I<status-word>.

=back

=head1 BUGS

=head2 Reporting Bugs

Please report any bugs or feature requests to
C<bug-test-unixexit at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Test-UnixExit>.

Patches might best be applied towards:

L<https://github.com/thrig/Test-UnixExit>

=head2 Known Issues

The I<expected-value> to B<exit_is> is not much checked whether the
inputs are sane, e.g. that I<code> is an 8-bit number, etc. This may be
a problem if this input is being generated by something that is buggy.

=head1 SEE ALSO

L<Test::Cmd>, L<Expect> - these provide means to check external
commands, either by running the commands under a shell, or simulating a
terminal environment. Good ways to obtain a C<$?> to pass to this code,
in other words.

L<Test::Exit>, L<Test::Trap> - these check that Perl code behaves in
a particular way, and may be more suitable for testing code in a
module over running a wrapper via the complication of a shell or
virtual terminal.

L<wait(2)> - note that shells are different from the system call in that
the 16-bit status word is shoehorned into an 8-bit value available via
the shell C<$?> variable, which is the same name as the variable Perl
stores the 16-bit status word in. This can and does cause confusion.

=head1 AUTHOR

thrig - Jeremy Mates (cpan:JMATES) C<< <jmates at cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016 by Jeremy Mates

This program is distributed under the (Revised) BSD License:
L<http://www.opensource.org/licenses/BSD-3-Clause>

=cut
