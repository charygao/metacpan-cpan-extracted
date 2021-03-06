use strict;
use warnings;

use Test::More tests => 9;
use Clownfish::Type::Void;
use Clownfish::Parser;

my $void_type = Clownfish::Type::Void->new;
is( $void_type->get_specifier, "void", "specifier defaults to 'void'" );
is( $void_type->to_c,          "void", "to_c" );
ok( $void_type->is_void, "is_void" );

$void_type = Clownfish::Type::Void->new(
    specifier => 'void',
    const     => 1,
);
ok( $void_type->const, "const" );
like( $void_type->to_c, qr/const/, "'const' in C representation" );

my $parser = Clownfish::Parser->new;

is( $parser->void_type_specifier('void'), 'void', 'void_type_specifier' );
isa_ok( $parser->void_type('void'),       "Clownfish::Type::Void" );
isa_ok( $parser->void_type('const void'), "Clownfish::Type::Void" );
ok( !$parser->void_type_specifier('voidable'),
    "void_type_specifier guards against partial word matches" );

