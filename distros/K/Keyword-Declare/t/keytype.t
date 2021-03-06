use 5.012;
use Test::More;

use Keyword::Declare;

keytype ParamList is m{
    \(
        (?&Parameter) (?: (?&PerlOWS) , (?&PerlOWS) (?&Parameter) )*+
    \)

    (?(DEFINE)
        (?<Parameter>

            # TYPE...
            (?&TYPE_SPEC)?+

            # NAME...
            (?:
                (?&PerlOWS) : (?&IDENT) \( (?&PerlOWS)
                    [\$\@%] (?&IDENT) (?&PerlOWS)
                \)
            |
                :   [\$\@%] (?&IDENT)
            |
                \*
                (?:
                    [\@%] (?&IDENT)
                |
                    : (?&IDENT) \( (?&PerlOWS)
                        \@ (?&IDENT) (?&PerlOWS)
                    \)
                |
                    : \@ (?&IDENT)
                |
                    [\@%]
                )
            |
                [\$\@%] (?&IDENT)
            |
                [\$\@%]
            )

            # OPTIONAL OR REQUIRED...
            [?!]?+

            # READONLY OR ALIAS...
            (?: (?&PerlOWS) is (?&PerlOWS) (?: ro | alias ) )?+

            # DEFAULT VALUE...
            (?: (?&PerlOWS)?+ (?://|\|\|)? = (?&PerlOWS) (?&PerlExpression) )?+
        )

        (?<TYPE_SPEC>  (?&TYPE_NAME) (?: [&|] (?&TYPE_NAME) )*+ )
        (?<TYPE_NAME>  (?&QUAL_IDENT)  (?&TYPE_PARAM)?+         )
        (?<TYPE_PARAM> \[ (?: [^][]*+ | (?&TYPE_PARAM) )*+ \]   )
        (?<QUAL_IDENT> (?&IDENT) (?: :: (?&IDENT) )*+           )
        (?<IDENT>      [^\W\d] \w*+                             )
    )
}xms;

keyword complex (ParamList $p) {}

keytype HasVar is / .*? (?= [:;=] | \/\/= ) /x;

keyword hv (HasVar $hv) {{{}}}

keytype Nint is  /[+-]?\d+/;

keyword test ()              { q{pass 'test with no args'} }
keyword test (Nint $n)       { qq{ for my \$n (1..$n) { pass "counted test \$n" } } }
keyword test (Block $block)  {{{ subtest 'test with block' => sub <{$block}>; }}}

test;

test {
    pass 'test 1 in block';
    pass 'test 2 in block';
}

test 3;

{
    keyword test (Nint $n) {{{ for my $n (1..<{$n}>) { pass "nested counted test $n" } }}}

    test {
        pass 'test 1 in nested block';
        pass 'test 2 in nested block';
    }

    test 3;
}

test 3;

keytype $Name is 'name';
keytype $Rank is m{(?i)rank};

keyword nrs (Name $name, Rank $rank) {{{
    is q{«$name»}, q{«$Name»} => 'nrs Name';
    is q{«$rank»}, 'RANK'     => 'nrs Rank';
}}}

nrs name RANK;

BEGIN {
    is $Name, 'name'   => 'compile-time nrs $Name';
    like 'RANK', $Rank => 'compile-time nrs $Rank';
}

is $Name, 'name'   => 'runtime nrs $Name';
like 'RANK', $Rank => 'runtime nrs $Rank';

done_testing;
