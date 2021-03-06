#!perl -T
use Test::More;
use Test::Exception;
use ok( 'Locale::CLDR' );
my $locale;

diag( "Testing Locale::CLDR v0.34, Perl $], $^X" );
use ok Locale::CLDR::Locales::Kok, 'Can use locale file Locale::CLDR::Locales::Kok';
use ok Locale::CLDR::Locales::Kok::Any::In, 'Can use locale file Locale::CLDR::Locales::Kok::Any::In';
use ok Locale::CLDR::Locales::Kok::Any, 'Can use locale file Locale::CLDR::Locales::Kok::Any';

done_testing();
