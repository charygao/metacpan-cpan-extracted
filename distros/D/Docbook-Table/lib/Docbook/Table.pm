#!/usr/bin/perl -w


package Docbook::Table;

require v5.6.0;
use strict;
use warnings;
use Carp;

our $VERSION = '1.00';

=head1 NAME

Docbook::Table -- create Docbook tables from Perl data structures

=head1 SYNOPSIS

    use Docbook::Table;
    my $t = Docbook::Table->new();
    $t->title("Pet names");
    $t->headings("Pet type", "Pet name");

    my %pets = (
        dog     => "Rover",
        cat     => "Garfield",
        bird    => "Tweetie"
    );

    $t->body(\%pets);
    $t->generate;

    $t->sort(\&backwards);

=head1 DESCRIPTION

This module generates Docbook SGML/XML tables from Perl data structures.
Its main purpose is to simplify automatic document generation.

=head2 Starting your table

    use Docbook::Table;
    my $t = Docbook::Table->new();

=begin testing

BEGIN {
    use lib "./lib";
    use_ok('Docbook::Table');
    use vars qw($t);
}
$t = Docbook::Table->new();
isa_ok($t, 'Docbook::Table');

=end testing

=cut

sub new {
    my $self = {};
    $self->{calling_package} = (caller)[0];
    bless $self;
    return $self;
}

=head2 Specifying the title

Docbook tables must have a title.  You can set the title by passing a
string to the title() method.

    $t->title("This is the title");

=for testing
$t->title("foo");
is($t->{title}, "foo", "Setting title");

=cut

sub title {
    my ($self, $title) = @_;
    $self->{title} = $title;
}

=head2 Specifying the headings

Simply pass a list of headings to the headings() method.

    $t->headings(@headings);

Note that the number of columns (a required attribute of the C<tgroup>
element) is generated by counting the number of elements in the list
passed to headings().

=for testing
is($t->headings(), undef, "Set headings fails for empty list");
$t->headings(qw(foo bar baz));
is(ref($t->{headings}), "ARRAY", "Setting headings");
is($t->{headings}[0], "foo", "Setting headings");

=cut

sub headings {
    my ($self, @headings) = @_;
    unless (@headings) {
        carp "No headings specified";
        return undef;
    }
    $self->{headings} = \@headings;
}

=head2 Specifying the body

Accepted data types for the body of the table are:

=over 4

=item Simple hash

Used to generate a simple 2-column table.  

=item List of lists

Used to generate multi-column tables.

=item Hash of lists

Used to generate multi-column tables.

=item Hash of hashes and other structures

Not supported (yet).

=back

All data structures for the body should be passed by reference to the
body() method.

    $t->body(\%hash);
    $t->body(\@list);

If you pass it the wrong sort of thing, it will emit a warning and
return undef.

=for testing
is($t->body("foo"), undef, "body fails on non hash/arrayref");
$t->body({ a => "apple", b => "banana" });
is(ref($t->{body}), "HASH", "body sets hashref");
$t->body([ [1,2,3], [4,5,6], [7,8,9] ]);
is(ref($t->{body}), "ARRAY", "body sets arrayref");

=cut

sub body {
    my ($self, $bodyref) = @_;
    unless (ref $bodyref eq 'HASH' or ref $bodyref eq 'ARRAY') {
        carp "Body must be an arrayref or hashref";
        return undef;
    }
    $self->{body} = $bodyref;
}

=head2 Sorting

By default, hashes are sorted asciibetically by key, and lists are left
in their original order.  If you wish to specify a different sort order,
pass a subroutine reference to the sort() method.

    $t->sort(\&backwards);
    $t->sort( sub { $b cmp $a } );

If you pass it anything other than a subroutine reference, it will emit
a warning and return undef.

=for testing
is($t->sort("foo"), undef, "sort fails on non-subref");
{
    no warnings 'once';
    $t->sort( sub { $b cmp $a } );
    is(ref($t->{sortsub}), "CODE", "sort sets a subroutine ref");
}

=cut


sub sort {
    my ($self, $sortsub) = @_;
    unless (ref $sortsub eq 'CODE') {
        carp "Sort must be a subroutine reference";
        return undef;
    }
    $self->{sortsub} = $sortsub;
}

=head2 Generating the table

The generate() method actually generates the table for you and returns
it as a string.  It will emit warnings and return undef if you haven't 
specified a title, headings and a body.

=cut

sub generate {
    my ($self) = @_;

    foreach (qw(title headings body)) {
        unless ($self->{$_}) {
            warn "No $_ specified\n";
            return undef;
        }
    }

    return $self->table_opening()
        . $self->table_head()
        . $self->table_body()
        . $self->table_close;
}

=for testing
like($t->table_opening(), qr/<table>/, "Open table");

=cut

sub table_opening {
    my $self = shift;
    my $cols = @{$self->{headings}};

    return qq(<table>
<title>$self->{title}</title>
<tgroup cols="$cols">
);

}

=for testing
like($t->table_head(), qr/<thead>/, "table heading");
like($t->table_head(), qr/baz/, "table heading");

=cut

sub table_head {
    my $self = shift;
    my @headings = @{$self->{headings}};

    my $out = qq(<thead>\n);
    $out .= $self->row(@headings);
    $out .= qq(</thead>\n);
}

sub table_body {
    my $self = shift;
    my $bodyref = $self->{body};

    my $out = "<tbody>\n";


    # note to self and others:
    # this is a little funky.  If we don't alias $a and $b across 
    # from the calling package, we can't sort properly.  A side 
    # effect of this is that we'll also end up with the calling 
    # package's @a, %a and &a (and b, too) so D::T has to be 
    # careful not to use them. 
    {
        no strict 'refs';
        *Docbook::Table::a = *{$self->{calling_package} . "::a"};
        *Docbook::Table::b = *{$self->{calling_package} . "::b"};
    }

    if (ref $bodyref eq 'HASH') {
        my $sort = $self->{sortsub} || sub { $a cmp $b };
        foreach my $key (sort $sort keys %$bodyref) {
            if (ref $bodyref->{$key} eq 'ARRAY') {
                $out .= $self->row($key, @{$bodyref->{key}});
            } elsif (ref $bodyref->{$key}) {
                carp "Unsupported data structure.  Looks like you've got something other than scalars or arrayrefs in the values of the hash you're using for the body.";
                return undef;
            } else {
                $out .= $self->row($key, $bodyref->{key});
            }
        }
    } elsif (ref $bodyref eq 'ARRAY') {
        my $sort = $self->{sortsub} || sub { 1 }; 
                    # sub { 1 } just leaves the list alone
        foreach my $row (sort $sort @$bodyref) {
            $out .= $self->row(@$row);
        }
    }

    $out .= "/<tbody>\n";

    return $out;

}

=begin testing

my $expected = "\t<row>\n\t\t<entry>foo</entry>\n\t</row>\n";
is($t->row("foo"), $expected, "generate a row");

=end testing

=cut

sub row {
    shift;
    my @entries = @_;
    my $row = "\t<row>\n";
    $row .= "\t\t<entry>$_</entry>\n" foreach @entries;
    $row .= "\t</row>\n";
    return $row;
}

sub table_close {
    return qq(</table>\n);
}

return "FALSE";     # true value ;)

=head1 AUTHOR

Kirrily Robert <skud@cpan.org>

=head1 COPYING 

Docbook::Table (c) 2001 Kirrily Robert <skud@cpan.org>
This software is distributed under the same licenses as Perl itself.

=head1 SEE ALSO

L<YAML>

=cut
