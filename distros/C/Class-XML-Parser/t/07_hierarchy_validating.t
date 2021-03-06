#!/usr/bin/perl

use lib './lib';

use strict;
use warnings;

use Data::Dumper;
use Cwd;

use Test::More tests => 7;

use_ok( 'Class::XML::Parser' );

my $xml = <<'EOXML';
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE parser PUBLIC "-//Example//DTD Parse Example//EN"
                        "http://example.com/validator.dtd">
<parser>
    <elem1 y="64">
        <elem2>Element2 text, 1st run</elem2>
        <elem2>Element2 text, 2nd run</elem2>
        <elem3 attr1="attr_val1" attr2="attr_val2">
            <elem_bottom attr_bottom="attr_bottom_val">bottom_value</elem_bottom>
            <empty_element />
        </elem3>
        <elem4>    whitespace abounds    </elem4>
    </elem1>
</parser>
EOXML

my $dtd = Cwd::abs_path( "t/validator.dtd" );

SKIP: {
    eval { require XML::Checker::Parser };
    skip "XML::Checker::Parser not installed", 6 if $@;

    my $parser = Class::XML::Parser->new(
        root_class      => 'ParseResult::TestHierarchy',
        prune           => 1,
        strip           => 1,
        validate        => 1,
        map_uri         => {
            "http://example.com/validator.dtd"  => "file:$dtd",
        },
    );

    my $res = $parser->parse( $xml );
    my $expected = {
        elem1   => {
            y       => '64',
            elem4   => {
                elem4   => 'whitespace abounds',
            },
            elem2   => [
                "Element2 text, 1st run",
                "Element2 text, 2nd run",
            ],
            elem3   => {
                attr1       => 'attr_val1',
                attr2       => 'attr_val2',
                elem_bottom => {
                    elem_bottom => 'bottom_value',
                    attr_bottom => 'attr_bottom_val',
                },
            },
        }
    };

    ok( ref $res, "expect a reference back" );
    is_deeply( $res, $expected, 'datastructure' );
    isa_ok( $res, 'ParseResult::TestHierarchy' );
    isa_ok( $res->elem1, 'ParseResult::TestHierarchy::Elem1' );
    isa_ok( $res->elem1->elem3, 'ParseResult::TestHierarchy::Elem3' );
    isa_ok( $res->elem1->elem3->elem_bottom, 'ParseResult::TestHierarchy::Bottom' );
}

# this just defines an AUTOLOADER, for quick-and-easy accessors/mutators
package ParseBase;

use vars qw( $AUTOLOAD );

sub new { bless {}, shift }

sub AUTOLOAD {
    my ( $self, $val ) = @_;

    my $method = $AUTOLOAD;
    $method =~ s/.*:://;

    return if $method eq 'DESTROY';

    if ( defined $val ) {
        $self->{ $method } = $val;
    }

    return $self->{ $method };
}

package ParseResult::TestHierarchy;

use base qw( ParseBase );

sub __xml_parse_objects {
    {
        elem1   => 'ParseResult::TestHierarchy::Elem1',
    }
}

package ParseResult::TestHierarchy::Elem1;

use base qw( ParseBase );

sub __xml_parse_objects {
    {
        elem3   => 'ParseResult::TestHierarchy::Elem3',
        elem4   => 'ParseResult::TestHierarchy::Elem4',
    }
}

sub elem2 {
    my ( $self, $val ) = @_;

    push @{ $self->{ elem2 } }, $val
      if defined $val;

    return $self->{ elem2 };
}

package ParseResult::TestHierarchy::Elem3;

use base qw( ParseBase );

sub __xml_parse_objects {
    {
        elem_bottom => 'ParseResult::TestHierarchy::Bottom',
    }
}

package ParseResult::TestHierarchy::Elem4;

use base qw( ParseBase );

package ParseResult::TestHierarchy::Bottom;

use base qw( ParseBase );

1;
