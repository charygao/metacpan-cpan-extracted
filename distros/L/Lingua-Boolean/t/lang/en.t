#!perl
use strict;
use warnings;
use 5.0100;
use Test::More 0.94 tests => 4;
use Test::Builder 0.94;
use experimental qw/smartmatch/;

use Lingua::Boolean;
my $lang = 'en';
my $bool = Lingua::Boolean->new($lang);

my @langs = $bool->langs();
ok($lang ~~ @langs, "$lang is available");

subtest 'yes' => sub {   #YES
    my @yes = (' y', 'yes ', 'ok', 'on', ' Y', 'YES', 'OK', 'ON', 'true', 1, 2);
    plan tests => scalar @yes * 2;

    foreach my $word (@yes) {
        ok($bool->boolean($word, $lang),    "$word is true - OO");
        ok(boolean($word, $lang),           "$word is true - functional");
    }
};

subtest 'no' => sub {   # NO
    my @no = ('n ', ' no', 'off', 'not ok', 'N', 'NO', 'OFF', 'NOTOK', 'FAlse', 0);
    plan tests => scalar @no * 2;

    foreach my $word (@no) {
        ok(! $bool->boolean($word, $lang),  "$word is false - OO");
        ok(!(boolean $word),                "$word is false - functional");
    }
};

subtest 'fail' => sub { # nonsense
    my @nonsense = qw(one two three);
    plan tests => scalar @nonsense * 2;

    foreach my $word (@nonsense) {
        { # OO
            eval {
                $bool->boolean($word, $lang);
            };
            like($@, qr{^'$word' isn't recognizable as either true or false}, "$word is nonsense - OO");
        }
        { # Functional
            eval {
                boolean($word, $lang);
            };
            like($@, qr{^'$word' isn't recognizable as either true or false}, "$word is nonsense - functional");
        }
    }
};
