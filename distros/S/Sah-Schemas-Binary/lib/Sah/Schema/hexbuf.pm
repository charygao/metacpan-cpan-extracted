package Sah::Schema::hexbuf;

our $AUTHORITY = 'cpan:PERLANCAR'; # AUTHORITY
our $DATE = '2020-03-08'; # DATE
our $DIST = 'Sah-Schemas-Binary'; # DIST
our $VERSION = '0.005'; # VERSION

our $schema = [str => {
    summary => 'Binary data encoded in hexdigits',
    match => qr/\A([0-9A-fa-f][0-9A-fa-f])*\z/,
    examples => [
        {value=>'', valid=>1},
        {value=>'f', valid=>0, summary=>'Odd number of digits'},
        {value=>'fafafa', valid=>1},
        {value=>'fafafg', valid=>0},
    ],
}, {}];

1;

# ABSTRACT: Binary data encoded in hexdigits

__END__

=pod

=encoding UTF-8

=head1 NAME

Sah::Schema::hexbuf - Binary data encoded in hexdigits

=head1 VERSION

This document describes version 0.005 of Sah::Schema::hexbuf (from Perl distribution Sah-Schemas-Binary), released on 2020-03-08.

=head1 SYNOPSIS

Using with L<Data::Sah>:

 use Data::Sah qw(gen_validator);
 my $vdr = gen_validator("hexbuf*");
 say $vdr->($data) ? "valid" : "INVALID!";

 # Data::Sah can also create a validator to return error message, coerced value,
 # even validators in other languages like JavaScript, from the same schema.
 # See its documentation for more details.

Using in L<Rinci> function metadata (to be used with L<Perinci::CmdLine>, etc):

 package MyApp;
 our %SPEC;
 $SPEC{myfunc} = {
     v => 1.1,
     summary => 'Routine to do blah ...',
     args => {
         arg1 => {
             summary => 'The blah blah argument',
             schema => ['hexbuf*'],
         },
         ...
     },
 };
 sub myfunc {
     my %args = @_;
     ...
 }

Sample data:

 ""  # valid

 "f"  # INVALID (Odd number of digits)

 "fafafa"  # valid

 "fafafg"  # INVALID

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Sah-Schemas-Binary>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Sah-Schemas-Binary>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Sah-Schemas-Binary>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2020, 2018 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
