use 5.010;
use utf8;
{ package STD::STD::P5;
use Moose ':all' => { -prefix => "moose_" };
use Encode;
moose_extends('STD');
our $ALLROLES = { 'STD::STD::P5', 1 };
our $REGEXES = {
ALL => [ qw/POST PRE arglist args babble backslash block blockoid capterm capture category charname charnames charspec comp_unit dec_number declarator def_module_name deflongname desigilname dottyop dottyopish eat_terminator endid escale escape fatarrow hexint hexints ident identifier infixish infixstopper integer label longname methodop modifier_expr morename name nibbler nofun nullterm nulltermish number numish octint octints p5circumfix p5comment p5dotty p5infix p5module_name p5multi_declarator p5number p5package_declarator p5postcircumfix p5postfix p5prefix p5quote p5regex_declarator p5routine_declarator p5rx_mods p5scope_declarator p5sigil p5special_variable p5statement_control p5statement_mod_cond p5statement_mod_loop p5statement_prefix p5term p5terminator p5tr_mods p5type_declarator p5value p5version package_def param_sep parensig pod_comment postop quasiquibble quibble quote radint regex_block routine_def scoped semiarglist semilist sibble signature spacey starter statement statementlist stdstopper stopper sublongname subshortname termish trait tribble type_constraint typename unitstopper unsp unspacey unv variable variable_declarator vnum vws ws xblock/ ],
category => [ qw/category__S_000category__PEEK category__S_001p5sigil__PEEK category__S_002p5special_variable__PEEK category__S_003p5comment__PEEK category__S_004p5version__PEEK category__S_005p5module_name__PEEK category__S_006p5value__PEEK category__S_007p5term__PEEK category__S_008p5number__PEEK category__S_009p5quote__PEEK category__S_010p5prefix__PEEK category__S_011p5infix__PEEK category__S_012p5postfix__PEEK category__S_013p5dotty__PEEK category__S_014p5circumfix__PEEK category__S_015p5postcircumfix__PEEK category__S_016p5type_declarator__PEEK category__S_017p5scope_declarator__PEEK category__S_018p5package_declarator__PEEK category__S_019p5routine_declarator__PEEK category__S_020p5regex_declarator__PEEK category__S_021p5statement_prefix__PEEK category__S_022p5statement_control__PEEK category__S_023p5statement_mod_cond__PEEK category__S_024p5statement_mod_loop__PEEK category__S_025p5terminator__PEEK/ ],
escape => [ qw/escape__S_117none__PEEK/ ],
number => [ qw/number__S_116numish__PEEK/ ],
p5circumfix => [ qw/p5circumfix__S_120Lt_Gt__PEEK p5circumfix__S_132sigil__PEEK p5circumfix__S_133Paren_Thesis__PEEK p5circumfix__S_134Bra_Ket__PEEK p5circumfix__S_139Cur_Ly__PEEK/ ],
p5comment => [ qw/p5comment__S_026Sharp__PEEK/ ],
p5dotty => [ qw/p5dotty__S_135MinusGt__PEEK/ ],
p5infix => [ qw/p5infix__S_145StarStar__PEEK p5infix__S_150BangTilde__PEEK p5infix__S_151EqualTilde__PEEK p5infix__S_152Star__PEEK p5infix__S_153Slash__PEEK p5infix__S_154Percent__PEEK p5infix__S_155LtLt__PEEK p5infix__S_156GtGt__PEEK p5infix__S_157x__PEEK p5infix__S_158Dot__PEEK p5infix__S_159Plus__PEEK p5infix__S_160Minus__PEEK p5infix__S_161Amp__PEEK p5infix__S_162also__PEEK p5infix__S_163Vert__PEEK p5infix__S_164Caret__PEEK p5infix__S_169LtEqualGt__PEEK p5infix__S_170cmp__PEEK p5infix__S_171Lt__PEEK p5infix__S_172LtEqual__PEEK p5infix__S_173Gt__PEEK p5infix__S_174GtEqual__PEEK p5infix__S_175eq__PEEK p5infix__S_176ne__PEEK p5infix__S_177lt__PEEK p5infix__S_178le__PEEK p5infix__S_179gt__PEEK p5infix__S_180ge__PEEK p5infix__S_181EqualEqual__PEEK p5infix__S_182BangEqual__PEEK p5infix__S_183AmpAmp__PEEK p5infix__S_184VertVert__PEEK p5infix__S_185CaretCaret__PEEK p5infix__S_186SlashSlash__PEEK p5infix__S_187DotDot__PEEK p5infix__S_188DotDotDot__PEEK p5infix__S_189Question_Colon__PEEK p5infix__S_190Equal__PEEK p5infix__S_191Comma__PEEK p5infix__S_192EqualGt__PEEK p5infix__S_196and__PEEK p5infix__S_197andthen__PEEK p5infix__S_198or__PEEK p5infix__S_199orelse__PEEK p5infix__S_200xor__PEEK/ ],
p5module_name => [ qw/p5module_name__S_047normal__PEEK/ ],
p5multi_declarator => [ qw/p5multi_declarator__S_054null__PEEK/ ],
p5package_declarator => [ qw/p5package_declarator__S_052package__PEEK p5package_declarator__S_053require__PEEK/ ],
p5postcircumfix => [ qw/p5postcircumfix__S_136Paren_Thesis__PEEK p5postcircumfix__S_137Bra_Ket__PEEK p5postcircumfix__S_138Cur_Ly__PEEK/ ],
p5postfix => [ qw/p5postfix__S_140MinusGt__PEEK p5postfix__S_141PlusPlus__PEEK p5postfix__S_142MinusMinus__PEEK/ ],
p5prefix => [ qw/p5prefix__S_143PlusPlus__PEEK p5prefix__S_144MinusMinus__PEEK p5prefix__S_146Bang__PEEK p5prefix__S_147Plus__PEEK p5prefix__S_148Minus__PEEK p5prefix__S_149Tilde__PEEK p5prefix__S_165sleep__PEEK p5prefix__S_166abs__PEEK p5prefix__S_167let__PEEK p5prefix__S_168temp__PEEK/ ],
p5quote => [ qw/p5quote__S_118Single_Single__PEEK p5quote__S_119Double_Double__PEEK p5quote__S_121Slash_Slash__PEEK/ ],
p5routine_declarator => [ qw/p5routine_declarator__S_055sub__PEEK/ ],
p5scope_declarator => [ qw/p5scope_declarator__S_049my__PEEK p5scope_declarator__S_050our__PEEK p5scope_declarator__S_051state__PEEK/ ],
p5sigil => [ qw/p5sigil__S_109Dollar__PEEK p5sigil__S_110At__PEEK p5sigil__S_111Percent__PEEK p5sigil__S_112Amp__PEEK/ ],
p5special_variable => [ qw/p5special_variable__S_066DollarBang__PEEK p5special_variable__S_067DollarBangCur_Ly__PEEK p5special_variable__S_068DollarSlash__PEEK p5special_variable__S_069DollarTilde__PEEK p5special_variable__S_070DollarGrave__PEEK p5special_variable__S_071DollarAt__PEEK p5special_variable__S_072DollarSharp__PEEK p5special_variable__S_073DollarDollar__PEEK p5special_variable__S_074DollarPercent__PEEK p5special_variable__S_075DollarCaretX__PEEK p5special_variable__S_076DollarCaret__PEEK p5special_variable__S_077DollarAmp__PEEK p5special_variable__S_078DollarStar__PEEK p5special_variable__S_079DollarThesis__PEEK p5special_variable__S_080DollarMinus__PEEK p5special_variable__S_081DollarEqual__PEEK p5special_variable__S_082AtPlus__PEEK p5special_variable__S_083PercentPlus__PEEK p5special_variable__S_084DollarPlusBra_Ket__PEEK p5special_variable__S_085AtPlusBra_Ket__PEEK p5special_variable__S_086AtPlusCur_Ly__PEEK p5special_variable__S_087AtMinus__PEEK p5special_variable__S_088PercentMinus__PEEK p5special_variable__S_089DollarMinusBra_Ket__PEEK p5special_variable__S_090AtMinusBra_Ket__PEEK p5special_variable__S_091PercentMinusCur_Ly__PEEK p5special_variable__S_092DollarPlus__PEEK p5special_variable__S_093DollarCurCaret_Ly__PEEK p5special_variable__S_094ColonColonCur_Ly__PEEK p5special_variable__S_095DollarCur_Ly__PEEK p5special_variable__S_096DollarBra__PEEK p5special_variable__S_097DollarKet__PEEK p5special_variable__S_098DollarBack__PEEK p5special_variable__S_099DollarVert__PEEK p5special_variable__S_100DollarColon__PEEK p5special_variable__S_101DollarSemi__PEEK p5special_variable__S_102DollarSingle__PEEK p5special_variable__S_103DollarDouble__PEEK p5special_variable__S_104DollarComma__PEEK p5special_variable__S_105DollarLt__PEEK p5special_variable__S_106DollarGt__PEEK p5special_variable__S_107DollarDot__PEEK p5special_variable__S_108DollarQuestion__PEEK/ ],
p5statement_control => [ qw/p5statement_control__S_027use__PEEK p5statement_control__S_028no__PEEK p5statement_control__S_029if__PEEK p5statement_control__S_030while__PEEK p5statement_control__S_031until__PEEK p5statement_control__S_032for__PEEK p5statement_control__S_033given__PEEK p5statement_control__S_034when__PEEK p5statement_control__S_035default__PEEK p5statement_control__S_039END__PEEK/ ],
p5statement_mod_cond => [ qw/p5statement_mod_cond__S_040if__PEEK p5statement_mod_cond__S_041unless__PEEK p5statement_mod_cond__S_042when__PEEK/ ],
p5statement_mod_loop => [ qw/p5statement_mod_loop__S_043while__PEEK p5statement_mod_loop__S_044until__PEEK p5statement_mod_loop__S_045for__PEEK p5statement_mod_loop__S_046given__PEEK/ ],
p5statement_prefix => [ qw/p5statement_prefix__S_036BEGIN__PEEK p5statement_prefix__S_037CHECK__PEEK p5statement_prefix__S_038INIT__PEEK p5statement_prefix__S_128do__PEEK p5statement_prefix__S_129eval__PEEK/ ],
p5term => [ qw/p5term__S_056fatarrow__PEEK p5term__S_057variable__PEEK p5term__S_058package_declarator__PEEK p5term__S_059scope_declarator__PEEK p5term__S_060routine_declarator__PEEK p5term__S_061circumfix__PEEK p5term__S_062dotty__PEEK p5term__S_063value__PEEK p5term__S_064capterm__PEEK p5term__S_065statement_prefix__PEEK p5term__S_130undef__PEEK p5term__S_131continue__PEEK p5term__S_193identifier__PEEK p5term__S_194opfunc__PEEK p5term__S_195name__PEEK/ ],
p5terminator => [ qw/p5terminator__S_201Semi__PEEK p5terminator__S_202if__PEEK p5terminator__S_203unless__PEEK p5terminator__S_204while__PEEK p5terminator__S_205until__PEEK p5terminator__S_206for__PEEK p5terminator__S_207given__PEEK p5terminator__S_208when__PEEK p5terminator__S_209Thesis__PEEK p5terminator__S_210Ket__PEEK p5terminator__S_211Ly__PEEK p5terminator__S_212Colon__PEEK/ ],
p5value => [ qw/p5value__S_113quote__PEEK p5value__S_114number__PEEK p5value__S_115version__PEEK/ ],
p5version => [ qw/p5version__S_048v__PEEK/ ],
quote => [ qw/quote__S_122qq__PEEK quote__S_123q__PEEK quote__S_124qr__PEEK quote__S_125m__PEEK quote__S_126s__PEEK quote__S_127tr__PEEK/ ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

$retree = YAML::XS::Load(Encode::encode_utf8(<<'RETREE_END'));
---
POST: !!perl/hash:RE_ast
  dba: postfix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_assertion
      assert: '!'
      re: !!perl/hash:RE_method
        name: stdstopper
        rest: ''
    - !!perl/hash:RE_assertion
      assert: '!'
      re: !!perl/hash:RE_block
        nobind: 1
    - !!perl/hash:RE_bracket
      re: &1 !!perl/hash:RE_any
        altname: POST_0
        dba: postfix
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_sequence
          alt: POST_0 0
          zyg:
          - !!perl/hash:RE_bindnamed
            atom: !!perl/hash:RE_method
              name: p5dotty
              rest: ''
          - !!perl/hash:RE_block {}
        - !!perl/hash:RE_sequence
          alt: POST_0 1
          zyg:
          - !!perl/hash:RE_method
            name: postop
            rest: ''
          - !!perl/hash:RE_block {}
POST_0: *1
PRE: !!perl/hash:RE_ast
  dba: prefix or meta-prefix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_sequence
        zyg:
        - !!perl/hash:RE_bindnamed
          atom: !!perl/hash:RE_method
            name: p5prefix
            rest: ''
        - !!perl/hash:RE_block {}
    - !!perl/hash:RE_method
      name: ws
      rest: ''
arglist: !!perl/hash:RE_ast
  dba: argument list
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_bracket
      re: &2 !!perl/hash:RE_any
        altname: arglist_0
        dba: argument list
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_assertion
          alt: arglist_0 0
          assert: '?'
          re: !!perl/hash:RE_method
            name: stdstopper
            rest: ''
        - !!perl/hash:RE_sequence
          alt: arglist_0 1
          zyg:
          - !!perl/hash:RE_method
            name: EXPR
            rest: 1
          - !!perl/hash:RE_block {}
arglist_0: *2
args: !!perl/hash:RE_ast
  dba: 'extra arglist after (...):'
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bracket
      re: &3 !!perl/hash:RE_any
        altname: args_0
        dba: argument list
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_bracket
          alt: args_0 0
          re: !!perl/hash:RE_sequence
            zyg:
            - !!perl/hash:RE_string
              i: 0
              text: (
            - !!perl/hash:RE_block {}
            - !!perl/hash:RE_method
              name: semiarglist
              rest: ''
            - !!perl/hash:RE_bracket
              re: !!perl/hash:RE_first
                zyg:
                - !!perl/hash:RE_string
                  i: 0
                  text: )
                - !!perl/hash:RE_method
                  name: FAILGOAL
                  rest: 1
        - !!perl/hash:RE_sequence
          alt: args_0 1
          zyg:
          - !!perl/hash:RE_method
            name: unsp
            rest: ''
          - !!perl/hash:RE_bracket
            re: !!perl/hash:RE_sequence
              zyg:
              - !!perl/hash:RE_string
                i: 0
                text: (
              - !!perl/hash:RE_block {}
              - !!perl/hash:RE_method
                name: semiarglist
                rest: ''
              - !!perl/hash:RE_bracket
                re: !!perl/hash:RE_first
                  zyg:
                  - !!perl/hash:RE_string
                    i: 0
                    text: )
                  - !!perl/hash:RE_method
                    name: FAILGOAL
                    rest: 1
        - !!perl/hash:RE_sequence
          alt: args_0 2
          zyg:
          - !!perl/hash:RE_block {}
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_bracket
              re: !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_assertion
                  assert: '?'
                  re: !!perl/hash:RE_method_re
                    name: before
                    nobind: 1
                    re: !!perl/hash:RE_meta
                      min: 1
                      text: \s
                - !!perl/hash:RE_assertion
                  assert: '!'
                  re: !!perl/hash:RE_block
                    nobind: 1
                - !!perl/hash:RE_method
                  name: ws
                  rest: ''
                - !!perl/hash:RE_assertion
                  assert: '!'
                  re: !!perl/hash:RE_method
                    name: infixstopper
                    rest: ''
                - !!perl/hash:RE_method
                  name: arglist
                  rest: ''
            quant:
            - '?'
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_first
        zyg:
        - !!perl/hash:RE_assertion
          assert: '?'
          re: !!perl/hash:RE_block
            nobind: 1
        - !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_string
            i: 0
            text: ':'
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_method_re
              name: before
              nobind: 1
              re: !!perl/hash:RE_meta
                min: 1
                text: \s
          - !!perl/hash:RE_bindnamed
            atom: !!perl/hash:RE_method
              name: arglist
              rest: ''
        - !!perl/hash:RE_block {}
args_0: *3
babble: !!perl/hash:RE_ast
  dba: babble
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_method
            name: quotepair
            rest: ''
          - !!perl/hash:RE_method
            name: ws
            rest: ''
          - !!perl/hash:RE_block {}
      quant:
      - '*'
    - !!perl/hash:RE_block {}
backslash:*:
  dic: STD::STD::P5
block: !!perl/hash:RE_ast
  dba: scoped block
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_first
        zyg:
        - !!perl/hash:RE_assertion
          assert: '?'
          re: !!perl/hash:RE_method_re
            name: before
            nobind: 1
            re: !!perl/hash:RE_string
              i: 0
              text: '{'
        - !!perl/hash:RE_method
          name: panic
          rest: 1
    - !!perl/hash:RE_method
      name: newlex
      rest: ''
    - !!perl/hash:RE_method
      name: blockoid
      rest: ''
blockoid: !!perl/hash:RE_ast
  dba: blockoid
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: finishlex
      rest: ''
    - !!perl/hash:RE_bracket
      re: &4 !!perl/hash:RE_any
        altname: blockoid_0
        dba: block
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_bracket
          alt: blockoid_0 0
          re: !!perl/hash:RE_sequence
            zyg:
            - !!perl/hash:RE_string
              i: 0
              text: '{'
            - !!perl/hash:RE_block {}
            - !!perl/hash:RE_method
              name: statementlist
              rest: ''
            - !!perl/hash:RE_bracket
              re: !!perl/hash:RE_first
                zyg:
                - !!perl/hash:RE_string
                  i: 0
                  text: '}'
                - !!perl/hash:RE_method
                  name: FAILGOAL
                  rest: 1
        - !!perl/hash:RE_sequence
          alt: blockoid_0 1
          zyg:
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_method
              name: terminator
              rest: ''
          - !!perl/hash:RE_method
            name: panic
            rest: 1
        - !!perl/hash:RE_sequence
          alt: blockoid_0 2
          zyg:
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_noop
              nobind: 1
          - !!perl/hash:RE_method
            name: panic
            rest: 1
    - !!perl/hash:RE_bracket
      re: &5 !!perl/hash:RE_any
        altname: blockoid_1
        dba: blockoid
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_sequence
          alt: blockoid_1 0
          zyg:
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_method_re
              name: before
              nobind: 1
              re: !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_meta
                    min: 1
                    text: \h
                  quant:
                  - '*'
                - !!perl/hash:RE_meta
                  text: $$
          - !!perl/hash:RE_block {}
        - !!perl/hash:RE_sequence
          alt: blockoid_1 1
          zyg:
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_meta
              min: 1
              text: \h
            quant:
            - '*'
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_method_re
              name: before
              nobind: 1
              re: !!perl/hash:RE_cclass
                i: 0
                text: '[\\,:]'
        - !!perl/hash:RE_sequence
          alt: blockoid_1 2
          zyg:
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_method
              name: unv
              rest: ''
            quant:
            - '?'
          - !!perl/hash:RE_meta
            text: $$
          - !!perl/hash:RE_block {}
        - !!perl/hash:RE_sequence
          alt: blockoid_1 3
          zyg:
          - !!perl/hash:RE_block {}
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_method
              name: unsp
              rest: ''
            quant:
            - '?'
          - !!perl/hash:RE_block {}
blockoid_0: *4
blockoid_1: *5
capterm: !!perl/hash:RE_ast
  dba: capterm
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: \
    - !!perl/hash:RE_bracket
      re: &6 !!perl/hash:RE_any
        altname: capterm_0
        dba: capterm
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_sequence
          alt: capterm_0 0
          zyg:
          - !!perl/hash:RE_string
            i: 0
            text: (
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_method
              name: capture
              rest: ''
            quant:
            - '?'
          - !!perl/hash:RE_string
            i: 0
            text: )
        - !!perl/hash:RE_sequence
          alt: capterm_0 1
          zyg:
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_method_re
              name: before
              nobind: 1
              re: !!perl/hash:RE_meta
                min: 1
                text: \S
          - !!perl/hash:RE_method
            name: termish
            rest: ''
capterm_0: *6
capture: !!perl/hash:RE_ast
  dba: capture
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: EXPR
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
category:*:
  dic: STD::STD::P5
category__S_000category: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: category
category__S_001p5sigil: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5sigil
category__S_002p5special_variable: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5special_variable
category__S_003p5comment: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5comment
category__S_004p5version: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5version
category__S_005p5module_name: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5module_name
category__S_006p5value: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5value
category__S_007p5term: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5term
category__S_008p5number: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5number
category__S_009p5quote: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5quote
category__S_010p5prefix: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5prefix
category__S_011p5infix: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5infix
category__S_012p5postfix: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5postfix
category__S_013p5dotty: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5dotty
category__S_014p5circumfix: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5circumfix
category__S_015p5postcircumfix: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5postcircumfix
category__S_016p5type_declarator: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5type_declarator
category__S_017p5scope_declarator: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5scope_declarator
category__S_018p5package_declarator: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5package_declarator
category__S_019p5routine_declarator: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5routine_declarator
category__S_020p5regex_declarator: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5regex_declarator
category__S_021p5statement_prefix: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5statement_prefix
category__S_022p5statement_control: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5statement_control
category__S_023p5statement_mod_cond: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5statement_mod_cond
category__S_024p5statement_mod_loop: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5statement_mod_loop
category__S_025p5terminator: !!perl/hash:RE_ast
  dba: category
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5terminator
charname: !!perl/hash:RE_ast
  dba: charname
  dic: STD::STD::P5
  re: !!perl/hash:RE_first
    zyg:
    - !!perl/hash:RE_bracket
      re: &7 !!perl/hash:RE_any
        altname: charname_0
        dba: charname
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_method
          alt: charname_0 0
          name: radint
          rest: ''
        - !!perl/hash:RE_sequence
          alt: charname_0 1
          zyg:
          - !!perl/hash:RE_cclass
            i: 0
            text: '[a..z A..Z]'
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_cclass
              i: 0
              text: -[ \] , \# ]
            quant:
            - '*'
          - !!perl/hash:RE_cclass
            i: 0
            text: '[a..z A..Z ) ]'
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_method_re
              name: before
              nobind: 1
              re: !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_meta
                    min: 1
                    text: \s
                  quant:
                  - '*'
                - !!perl/hash:RE_cclass
                  i: 0
                  text: '[ \] , \# ]'
    - !!perl/hash:RE_method
      name: panic
      rest: 1
charname_0: *7
charnames: !!perl/hash:RE_ast
  dba: charnames
  dic: STD::STD::P5
  re: !!perl/hash:RE_quantified_atom
    atom: !!perl/hash:RE_bracket
      re: !!perl/hash:RE_sequence
        zyg:
        - !!perl/hash:RE_method
          name: ws
          rest: ''
        - !!perl/hash:RE_method
          name: charname
          rest: ''
        - !!perl/hash:RE_method
          name: ws
          rest: ''
    quant:
    - '**'
    - ':'
    - !!perl/hash:RE_string
      a: 0
      dba: charnames
      dic: STD::STD::P5
      i: 0
      i_needed: 1
      r: 1
      s: 0
      text: ','
charspec: !!perl/hash:RE_ast
  dba: charspec
  dic: STD::STD::P5
  re: !!perl/hash:RE_bracket
    re: &8 !!perl/hash:RE_any
      altname: charspec_0
      dba: character name
      dic: STD::STD::P5
      zyg:
      - !!perl/hash:RE_bracket
        alt: charspec_0 0
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_string
            i: 0
            text: '['
          - !!perl/hash:RE_block {}
          - !!perl/hash:RE_method
            name: charnames
            rest: ''
          - !!perl/hash:RE_bracket
            re: !!perl/hash:RE_first
              zyg:
              - !!perl/hash:RE_string
                i: 0
                text: ']'
              - !!perl/hash:RE_method
                name: FAILGOAL
                rest: 1
      - !!perl/hash:RE_quantified_atom
        alt: charspec_0 1
        atom: !!perl/hash:RE_meta
          min: 1
          text: \d
        quant:
        - +
      - !!perl/hash:RE_cclass
        alt: charspec_0 2
        i: 0
        text: '[ ?..Z \\.._ ]'
      - !!perl/hash:RE_sequence
        alt: charspec_0 3
        zyg:
        - !!perl/hash:RE_assertion
          assert: '?'
          re: !!perl/hash:RE_noop
            nobind: 1
        - !!perl/hash:RE_method
          name: panic
          rest: 1
charspec_0: *8
comp_unit: !!perl/hash:RE_ast
  dba: comp_unit
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_method
      name: statementlist
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_first
        zyg:
        - !!perl/hash:RE_assertion
          assert: '?'
          re: !!perl/hash:RE_method
            name: unitstopper
            rest: ''
        - !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_method
            name: panic
            rest: 1
          - !!perl/hash:RE_method
            name: ws
            rest: ''
    - !!perl/hash:RE_block {}
dec_number: !!perl/hash:RE_ast
  dba: decimal number
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bracket
      re: &9 !!perl/hash:RE_any
        altname: dec_number_0
        dba: decimal number
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_sequence
          alt: dec_number_0 0
          zyg:
          - !!perl/hash:RE_bindnamed
            atom: !!perl/hash:RE_bracket
              re: !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_string
                  i: 0
                  text: .
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_meta
                    min: 1
                    text: \d
                  quant:
                  - +
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_bracket
                    re: !!perl/hash:RE_sequence
                      zyg:
                      - !!perl/hash:RE_string
                        i: 0
                        text: _
                      - !!perl/hash:RE_quantified_atom
                        atom: !!perl/hash:RE_meta
                          min: 1
                          text: \d
                        quant:
                        - +
                  quant:
                  - '*'
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_method
              name: escale
              rest: ''
            quant:
            - '?'
        - !!perl/hash:RE_sequence
          alt: dec_number_0 1
          zyg:
          - !!perl/hash:RE_bindnamed
            atom: !!perl/hash:RE_bracket
              re: !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_meta
                    min: 1
                    text: \d
                  quant:
                  - +
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_bracket
                    re: !!perl/hash:RE_sequence
                      zyg:
                      - !!perl/hash:RE_string
                        i: 0
                        text: _
                      - !!perl/hash:RE_quantified_atom
                        atom: !!perl/hash:RE_meta
                          min: 1
                          text: \d
                        quant:
                        - +
                  quant:
                  - '*'
                - !!perl/hash:RE_string
                  i: 0
                  text: .
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_meta
                    min: 1
                    text: \d
                  quant:
                  - +
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_bracket
                    re: !!perl/hash:RE_sequence
                      zyg:
                      - !!perl/hash:RE_string
                        i: 0
                        text: _
                      - !!perl/hash:RE_quantified_atom
                        atom: !!perl/hash:RE_meta
                          min: 1
                          text: \d
                        quant:
                        - +
                  quant:
                  - '*'
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_method
              name: escale
              rest: ''
            quant:
            - '?'
        - !!perl/hash:RE_sequence
          alt: dec_number_0 2
          zyg:
          - !!perl/hash:RE_bindnamed
            atom: !!perl/hash:RE_bracket
              re: !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_meta
                    min: 1
                    text: \d
                  quant:
                  - +
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_bracket
                    re: !!perl/hash:RE_sequence
                      zyg:
                      - !!perl/hash:RE_string
                        i: 0
                        text: _
                      - !!perl/hash:RE_quantified_atom
                        atom: !!perl/hash:RE_meta
                          min: 1
                          text: \d
                        quant:
                        - +
                  quant:
                  - '*'
          - !!perl/hash:RE_method
            name: escale
            rest: ''
    - !!perl/hash:RE_assertion
      assert: '!'
      re: !!perl/hash:RE_assertion
        assert: '!'
        nobind: 1
        re: !!perl/hash:RE_method_re
          name: before
          nobind: 1
          re: !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_bracket
              re: !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_string
                  i: 0
                  text: .
                - !!perl/hash:RE_assertion
                  assert: '?'
                  re: !!perl/hash:RE_method_re
                    name: before
                    nobind: 1
                    re: !!perl/hash:RE_meta
                      min: 1
                      text: \d
                - !!perl/hash:RE_method
                  name: panic
                  rest: 1
            quant:
            - '?'
dec_number_0: *9
declarator: !!perl/hash:RE_ast
  dba: declarator
  dic: STD::STD::P5
  re: !!perl/hash:RE_bracket
    re: &10 !!perl/hash:RE_any
      altname: declarator_0
      dba: declarator
      dic: STD::STD::P5
      zyg:
      - !!perl/hash:RE_method
        alt: declarator_0 0
        name: constant_declarator
        rest: ''
      - !!perl/hash:RE_method
        alt: declarator_0 1
        name: variable_declarator
        rest: ''
      - !!perl/hash:RE_sequence
        alt: declarator_0 2
        zyg:
        - !!perl/hash:RE_bracket
          re: !!perl/hash:RE_sequence
            zyg:
            - !!perl/hash:RE_string
              i: 0
              text: (
            - !!perl/hash:RE_block {}
            - !!perl/hash:RE_method
              name: signature
              rest: ''
            - !!perl/hash:RE_bracket
              re: !!perl/hash:RE_first
                zyg:
                - !!perl/hash:RE_string
                  i: 0
                  text: )
                - !!perl/hash:RE_method
                  name: FAILGOAL
                  rest: 1
        - !!perl/hash:RE_quantified_atom
          atom: !!perl/hash:RE_method
            name: trait
            rest: ''
          quant:
          - '*'
      - !!perl/hash:RE_bindnamed
        alt: declarator_0 3
        atom: !!perl/hash:RE_method
          name: p5routine_declarator
          rest: ''
      - !!perl/hash:RE_bindnamed
        alt: declarator_0 4
        atom: !!perl/hash:RE_method
          name: p5regex_declarator
          rest: ''
      - !!perl/hash:RE_bindnamed
        alt: declarator_0 5
        atom: !!perl/hash:RE_method
          name: p5type_declarator
          rest: ''
declarator_0: *10
def_module_name: !!perl/hash:RE_ast
  dba: def_module_name
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: longname
      rest: ''
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_method_re
              name: before
              nobind: 1
              re: !!perl/hash:RE_string
                i: 0
                text: '['
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_block
              nobind: 1
          - !!perl/hash:RE_method
            name: newlex
            rest: ''
          - !!perl/hash:RE_bracket
            re: !!perl/hash:RE_sequence
              zyg:
              - !!perl/hash:RE_string
                i: 0
                text: '['
              - !!perl/hash:RE_block {}
              - !!perl/hash:RE_method
                name: signature
                rest: ''
              - !!perl/hash:RE_bracket
                re: !!perl/hash:RE_first
                  zyg:
                  - !!perl/hash:RE_string
                    i: 0
                    text: ']'
                  - !!perl/hash:RE_method
                    name: FAILGOAL
                    rest: 1
          - !!perl/hash:RE_block {}
          - !!perl/hash:RE_method
            name: finishlex
            rest: ''
      quant:
      - '?'
deflongname: !!perl/hash:RE_ast
  dba: new name to be defined
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: name
      rest: ''
    - !!perl/hash:RE_bracket
      re: &11 !!perl/hash:RE_any
        altname: deflongname_0
        dba: new name to be defined
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_sequence
          alt: deflongname_0 0
          zyg:
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_method
              name: colonpair
              rest: ''
            quant:
            - +
          - !!perl/hash:RE_block {}
        - !!perl/hash:RE_block
          alt: deflongname_0 1
deflongname_0: *11
desigilname: !!perl/hash:RE_ast
  dba: desigilname
  dic: STD::STD::P5
  re: !!perl/hash:RE_bracket
    re: &12 !!perl/hash:RE_any
      altname: desigilname_0
      dba: desigilname
      dic: STD::STD::P5
      zyg:
      - !!perl/hash:RE_sequence
        alt: desigilname_0 0
        zyg:
        - !!perl/hash:RE_assertion
          assert: '?'
          re: !!perl/hash:RE_method_re
            name: before
            nobind: 1
            re: !!perl/hash:RE_string
              i: 0
              text: $
        - !!perl/hash:RE_method
          name: variable
          rest: ''
        - !!perl/hash:RE_block {}
      - !!perl/hash:RE_method
        alt: desigilname_0 1
        name: longname
        rest: ''
desigilname_0: *12
dottyop: !!perl/hash:RE_ast
  dba: dotty method or postfix
  dic: STD::STD::P5
  re: !!perl/hash:RE_bracket
    re: &13 !!perl/hash:RE_any
      altname: dottyop_0
      dba: dotty method or postfix
      dic: STD::STD::P5
      zyg:
      - !!perl/hash:RE_method
        alt: dottyop_0 0
        name: methodop
        rest: ''
      - !!perl/hash:RE_sequence
        alt: dottyop_0 1
        zyg:
        - !!perl/hash:RE_assertion
          assert: '!'
          re: !!perl/hash:RE_method
            name: alpha
            rest: ''
        - !!perl/hash:RE_bindnamed
          atom: !!perl/hash:RE_method
            name: p5postcircumfix
            rest: ''
        - !!perl/hash:RE_block {}
dottyop_0: *13
dottyopish: !!perl/hash:RE_ast
  dba: dottyopish
  dic: STD::STD::P5
  re: !!perl/hash:RE_bindnamed
    atom: !!perl/hash:RE_method
      name: dottyop
      rest: ''
eat_terminator: !!perl/hash:RE_ast
  dba: eat_terminator
  dic: STD::STD::P5
  re: !!perl/hash:RE_bracket
    re: !!perl/hash:RE_first
      zyg:
      - !!perl/hash:RE_sequence
        zyg:
        - !!perl/hash:RE_string
          i: 0
          text: ;
        - !!perl/hash:RE_quantified_atom
          atom: !!perl/hash:RE_bracket
            re: !!perl/hash:RE_sequence
              zyg:
              - !!perl/hash:RE_assertion
                assert: '?'
                re: !!perl/hash:RE_method_re
                  name: before
                  nobind: 1
                  re: !!perl/hash:RE_meta
                    text: $
              - !!perl/hash:RE_block {}
          quant:
          - '?'
      - !!perl/hash:RE_sequence
        zyg:
        - !!perl/hash:RE_assertion
          assert: '?'
          re: !!perl/hash:RE_block
            nobind: 1
        - !!perl/hash:RE_method
          name: ws
          rest: ''
      - !!perl/hash:RE_assertion
        assert: '?'
        re: !!perl/hash:RE_method
          name: terminator
          rest: ''
      - !!perl/hash:RE_meta
        text: $
      - !!perl/hash:RE_sequence
        zyg:
        - !!perl/hash:RE_block {}
        - !!perl/hash:RE_method
          name: panic
          rest: 1
endid: !!perl/hash:RE_ast
  dba: endid
  dic: STD::STD::P5
  re: !!perl/hash:RE_assertion
    assert: '?'
    re: !!perl/hash:RE_method_re
      name: before
      nobind: 1
      re: !!perl/hash:RE_cclass
        i: 0
        text: -[ \- \' \w ]
escale: !!perl/hash:RE_ast
  dba: escale
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_cclass
      i: 0
      text: '[Ee]'
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_cclass
        i: 0
        text: '[+\-]'
      quant:
      - '?'
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_meta
        min: 1
        text: \d
      quant:
      - +
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_string
            i: 0
            text: _
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_meta
              min: 1
              text: \d
            quant:
            - +
      quant:
      - '*'
escape:*:
  dic: STD::STD::P5
escape__S_117none: !!perl/hash:RE_ast
  dba: escape
  dic: STD::STD::P5
  re: !!perl/hash:RE_assertion
    assert: '!'
    re: !!perl/hash:RE_noop
      nobind: 1
fatarrow: !!perl/hash:RE_ast
  dba: fatarrow
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: identifier
        rest: ''
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_meta
        min: 1
        text: \h
      quant:
      - '*'
    - !!perl/hash:RE_string
      i: 0
      text: =>
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: EXPR
        rest: 1
hexint: !!perl/hash:RE_ast
  dba: hexint
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_cclass
        i: 0
        text: '[ 0..9 a..f A..F ]'
      quant:
      - +
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_string
            i: 0
            text: _
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_cclass
              i: 0
              text: '[ 0..9 a..f A..F ]'
            quant:
            - +
      quant:
      - '*'
hexints: !!perl/hash:RE_ast
  dba: hexints
  dic: STD::STD::P5
  re: !!perl/hash:RE_quantified_atom
    atom: !!perl/hash:RE_bracket
      re: !!perl/hash:RE_sequence
        zyg:
        - !!perl/hash:RE_method
          name: ws
          rest: ''
        - !!perl/hash:RE_method
          name: hexint
          rest: ''
        - !!perl/hash:RE_method
          name: ws
          rest: ''
    quant:
    - '**'
    - ':'
    - !!perl/hash:RE_string
      a: 0
      dba: hexints
      dic: STD::STD::P5
      i: 0
      i_needed: 1
      r: 1
      s: 0
      text: ','
ident: !!perl/hash:RE_ast
  dba: ident
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: alpha
      rest: ''
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_meta
        min: 1
        text: \w
      quant:
      - '*'
identifier: !!perl/hash:RE_ast
  dba: identifier
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: alpha
      rest: ''
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_meta
        min: 1
        text: \w
      quant:
      - '*'
infixish: !!perl/hash:RE_ast
  dba: infix or meta-infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_assertion
      assert: '!'
      re: !!perl/hash:RE_method
        name: stdstopper
        rest: ''
    - !!perl/hash:RE_assertion
      assert: '!'
      re: !!perl/hash:RE_method
        name: infixstopper
        rest: ''
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: p5infix
        rest: ''
    - !!perl/hash:RE_block {}
infixstopper: !!perl/hash:RE_ast
  dba: infix stopper
  dic: STD::STD::P5
  re: !!perl/hash:RE_bracket
    re: &14 !!perl/hash:RE_any
      altname: infixstopper_0
      dba: infix stopper
      dic: STD::STD::P5
      zyg:
      - !!perl/hash:RE_assertion
        alt: infixstopper_0 0
        assert: '?'
        re: !!perl/hash:RE_method_re
          name: before
          nobind: 1
          re: !!perl/hash:RE_method
            name: stopper
            rest: ''
      - !!perl/hash:RE_sequence
        alt: infixstopper_0 1
        zyg:
        - !!perl/hash:RE_assertion
          assert: '?'
          re: !!perl/hash:RE_method_re
            name: before
            nobind: 1
            re: !!perl/hash:RE_string
              i: 0
              text: ':'
        - !!perl/hash:RE_assertion
          assert: '?'
          re: !!perl/hash:RE_block
            nobind: 1
      - !!perl/hash:RE_assertion
        alt: infixstopper_0 2
        assert: '?'
        re: !!perl/hash:RE_block
          nobind: 1
infixstopper_0: *14
integer: !!perl/hash:RE_ast
  dba: integer
  dic: STD::STD::P5
  re: !!perl/hash:RE_bracket
    re: &15 !!perl/hash:RE_any
      altname: integer_0
      dba: integer
      dic: STD::STD::P5
      zyg:
      - !!perl/hash:RE_sequence
        alt: integer_0 0
        zyg:
        - !!perl/hash:RE_string
          i: 0
          text: '0'
        - !!perl/hash:RE_bracket
          re: &16 !!perl/hash:RE_any
            altname: integer_1
            dba: integer
            dic: STD::STD::P5
            zyg:
            - !!perl/hash:RE_sequence
              alt: integer_1 0
              zyg:
              - !!perl/hash:RE_string
                i: 0
                text: b
              - !!perl/hash:RE_quantified_atom
                atom: !!perl/hash:RE_cclass
                  i: 0
                  text: '[01]'
                quant:
                - +
              - !!perl/hash:RE_quantified_atom
                atom: !!perl/hash:RE_bracket
                  re: !!perl/hash:RE_sequence
                    zyg:
                    - !!perl/hash:RE_string
                      i: 0
                      text: _
                    - !!perl/hash:RE_quantified_atom
                      atom: !!perl/hash:RE_cclass
                        i: 0
                        text: '[01]'
                      quant:
                      - +
                quant:
                - '*'
            - !!perl/hash:RE_sequence
              alt: integer_1 1
              zyg:
              - !!perl/hash:RE_string
                i: 0
                text: o
              - !!perl/hash:RE_quantified_atom
                atom: !!perl/hash:RE_cclass
                  i: 0
                  text: '[0..7]'
                quant:
                - +
              - !!perl/hash:RE_quantified_atom
                atom: !!perl/hash:RE_bracket
                  re: !!perl/hash:RE_sequence
                    zyg:
                    - !!perl/hash:RE_string
                      i: 0
                      text: _
                    - !!perl/hash:RE_quantified_atom
                      atom: !!perl/hash:RE_cclass
                        i: 0
                        text: '[0..7]'
                      quant:
                      - +
                quant:
                - '*'
            - !!perl/hash:RE_sequence
              alt: integer_1 2
              zyg:
              - !!perl/hash:RE_string
                i: 0
                text: x
              - !!perl/hash:RE_quantified_atom
                atom: !!perl/hash:RE_cclass
                  i: 0
                  text: '[0..9a..fA..F]'
                quant:
                - +
              - !!perl/hash:RE_quantified_atom
                atom: !!perl/hash:RE_bracket
                  re: !!perl/hash:RE_sequence
                    zyg:
                    - !!perl/hash:RE_string
                      i: 0
                      text: _
                    - !!perl/hash:RE_quantified_atom
                      atom: !!perl/hash:RE_cclass
                        i: 0
                        text: '[0..9a..fA..F]'
                      quant:
                      - +
                quant:
                - '*'
            - !!perl/hash:RE_sequence
              alt: integer_1 3
              zyg:
              - !!perl/hash:RE_string
                i: 0
                text: d
              - !!perl/hash:RE_quantified_atom
                atom: !!perl/hash:RE_meta
                  min: 1
                  text: \d
                quant:
                - +
              - !!perl/hash:RE_quantified_atom
                atom: !!perl/hash:RE_bracket
                  re: !!perl/hash:RE_sequence
                    zyg:
                    - !!perl/hash:RE_string
                      i: 0
                      text: _
                    - !!perl/hash:RE_quantified_atom
                      atom: !!perl/hash:RE_meta
                        min: 1
                        text: \d
                      quant:
                      - +
                quant:
                - '*'
            - !!perl/hash:RE_sequence
              alt: integer_1 4
              zyg:
              - !!perl/hash:RE_quantified_atom
                atom: !!perl/hash:RE_meta
                  min: 1
                  text: \d
                quant:
                - +
              - !!perl/hash:RE_quantified_atom
                atom: !!perl/hash:RE_bracket
                  re: !!perl/hash:RE_sequence
                    zyg:
                    - !!perl/hash:RE_string
                      i: 0
                      text: _
                    - !!perl/hash:RE_quantified_atom
                      atom: !!perl/hash:RE_meta
                        min: 1
                        text: \d
                      quant:
                      - +
                quant:
                - '*'
              - !!perl/hash:RE_assertion
                assert: '!'
                re: !!perl/hash:RE_assertion
                  assert: '!'
                  nobind: 1
                  re: !!perl/hash:RE_block
                    nobind: 1
      - !!perl/hash:RE_sequence
        alt: integer_0 1
        zyg:
        - !!perl/hash:RE_quantified_atom
          atom: !!perl/hash:RE_meta
            min: 1
            text: \d
          quant:
          - +
        - !!perl/hash:RE_quantified_atom
          atom: !!perl/hash:RE_bracket
            re: !!perl/hash:RE_sequence
              zyg:
              - !!perl/hash:RE_string
                i: 0
                text: _
              - !!perl/hash:RE_quantified_atom
                atom: !!perl/hash:RE_meta
                  min: 1
                  text: \d
                quant:
                - +
          quant:
          - '*'
integer_0: *15
integer_1: *16
label: !!perl/hash:RE_ast
  dba: label
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: identifier
      rest: ''
    - !!perl/hash:RE_string
      i: 0
      text: ':'
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_meta
          min: 1
          text: \s
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_block
              nobind: 1
          - !!perl/hash:RE_method
            name: sorry
            rest: 1
      quant:
      - '?'
    - !!perl/hash:RE_block {}
longname: !!perl/hash:RE_ast
  dba: longname
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: name
      rest: ''
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_method
        name: colonpair
        rest: ''
      quant:
      - '*'
methodop: !!perl/hash:RE_ast
  dba: method arguments
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bracket
      re: &17 !!perl/hash:RE_any
        altname: methodop_0
        dba: methodop
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_method
          alt: methodop_0 0
          name: longname
          rest: ''
        - !!perl/hash:RE_sequence
          alt: methodop_0 1
          zyg:
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_method_re
              name: before
              nobind: 1
              re: &18 !!perl/hash:RE_any
                altname: methodop_1
                dba: methodop
                dic: STD::STD::P5
                zyg:
                - !!perl/hash:RE_string
                  alt: methodop_1 0
                  i: 0
                  text: $
                - !!perl/hash:RE_string
                  alt: methodop_1 1
                  i: 0
                  text: '@'
                - !!perl/hash:RE_string
                  alt: methodop_1 2
                  i: 0
                  text: '&'
          - !!perl/hash:RE_method
            name: variable
            rest: ''
          - !!perl/hash:RE_block {}
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_cclass
              i: 0
              nobind: 1
              text: '[\\(]'
          - !!perl/hash:RE_method
            name: args
            rest: ''
      quant:
      - '?'
methodop_0: *17
methodop_1: *18
modifier_expr: !!perl/hash:RE_ast
  dba: modifier_expr
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: EXPR
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
morename: !!perl/hash:RE_ast
  dba: morename
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: '::'
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_method_re
              name: before
              nobind: 1
              re: &19 !!perl/hash:RE_any
                altname: morename_0
                dba: morename
                dic: STD::STD::P5
                zyg:
                - !!perl/hash:RE_string
                  alt: morename_0 0
                  i: 0
                  text: (
                - !!perl/hash:RE_method
                  alt: morename_0 1
                  name: alpha
                  rest: ''
          - !!perl/hash:RE_bracket
            re: &20 !!perl/hash:RE_any
              altname: morename_1
              dba: indirect name
              dic: STD::STD::P5
              zyg:
              - !!perl/hash:RE_method
                alt: morename_1 0
                name: identifier
                rest: ''
              - !!perl/hash:RE_bracket
                alt: morename_1 1
                re: !!perl/hash:RE_sequence
                  zyg:
                  - !!perl/hash:RE_string
                    i: 0
                    text: (
                  - !!perl/hash:RE_block {}
                  - !!perl/hash:RE_method
                    name: EXPR
                    rest: ''
                  - !!perl/hash:RE_bracket
                    re: !!perl/hash:RE_first
                      zyg:
                      - !!perl/hash:RE_string
                        i: 0
                        text: )
                      - !!perl/hash:RE_method
                        name: FAILGOAL
                        rest: 1
      quant:
      - '?'
morename_0: *19
morename_1: *20
name: !!perl/hash:RE_ast
  dba: name
  dic: STD::STD::P5
  re: !!perl/hash:RE_bracket
    re: &21 !!perl/hash:RE_any
      altname: name_0
      dba: name
      dic: STD::STD::P5
      zyg:
      - !!perl/hash:RE_sequence
        alt: name_0 0
        zyg:
        - !!perl/hash:RE_method
          name: identifier
          rest: ''
        - !!perl/hash:RE_quantified_atom
          atom: !!perl/hash:RE_method
            name: morename
            rest: ''
          quant:
          - '*'
      - !!perl/hash:RE_quantified_atom
        alt: name_0 1
        atom: !!perl/hash:RE_method
          name: morename
          rest: ''
        quant:
        - +
name_0: *21
nibbler: !!perl/hash:RE_ast
  dba: nibbler
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_assertion
            assert: '!'
            re: !!perl/hash:RE_method_re
              name: before
              nobind: 1
              re: !!perl/hash:RE_method
                name: stopper
                rest: ''
          - !!perl/hash:RE_bracket
            re: !!perl/hash:RE_first
              zyg:
              - !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_method
                  name: starter
                  rest: ''
                - !!perl/hash:RE_method
                  name: nibbler
                  rest: ''
                - !!perl/hash:RE_method
                  name: stopper
                  rest: ''
                - !!perl/hash:RE_block {}
              - !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_method
                  name: escape
                  rest: ''
                - !!perl/hash:RE_block {}
              - !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_meta
                  min: 1
                  text: .
                - !!perl/hash:RE_block {}
      quant:
      - '*'
    - !!perl/hash:RE_block {}
nofun: !!perl/hash:RE_ast
  dba: nofun
  dic: STD::STD::P5
  re: !!perl/hash:RE_assertion
    assert: '!'
    re: !!perl/hash:RE_method_re
      name: before
      nobind: 1
      re: &22 !!perl/hash:RE_any
        altname: nofun_0
        dba: nofun
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_string
          alt: nofun_0 0
          i: 0
          text: (
        - !!perl/hash:RE_string
          alt: nofun_0 1
          i: 0
          text: .(
        - !!perl/hash:RE_string
          alt: nofun_0 2
          i: 0
          text: \
        - !!perl/hash:RE_string
          alt: nofun_0 3
          i: 0
          text: ''''
        - !!perl/hash:RE_string
          alt: nofun_0 4
          i: 0
          text: '-'
        - !!perl/hash:RE_double
          alt: nofun_0 5
          i: 0
          text: ''''
        - !!perl/hash:RE_meta
          alt: nofun_0 6
          min: 1
          text: \w
nofun_0: *22
nullterm: !!perl/hash:RE_ast
  dba: nullterm
  dic: STD::STD::P5
  re: !!perl/hash:RE_assertion
    assert: '?'
    re: !!perl/hash:RE_noop
      nobind: 1
nulltermish: !!perl/hash:RE_ast
  dba: null term
  dic: STD::STD::P5
  re: !!perl/hash:RE_bracket
    re: &23 !!perl/hash:RE_any
      altname: nulltermish_0
      dba: null term
      dic: STD::STD::P5
      zyg:
      - !!perl/hash:RE_assertion
        alt: nulltermish_0 0
        assert: '?'
        re: !!perl/hash:RE_method
          name: stdstopper
          rest: ''
      - !!perl/hash:RE_sequence
        alt: nulltermish_0 1
        zyg:
        - !!perl/hash:RE_bindnamed
          atom: !!perl/hash:RE_method
            name: termish
            rest: ''
        - !!perl/hash:RE_block {}
      - !!perl/hash:RE_assertion
        alt: nulltermish_0 2
        assert: '?'
        re: !!perl/hash:RE_noop
          nobind: 1
nulltermish_0: *23
number__S_116numish: !!perl/hash:RE_ast
  dba: number
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    name: numish
    rest: ''
numish: !!perl/hash:RE_ast
  dba: numish
  dic: STD::STD::P5
  re: !!perl/hash:RE_bracket
    re: &24 !!perl/hash:RE_any
      altname: numish_0
      dba: numish
      dic: STD::STD::P5
      zyg:
      - !!perl/hash:RE_method
        alt: numish_0 0
        name: integer
        rest: ''
      - !!perl/hash:RE_method
        alt: numish_0 1
        name: dec_number
        rest: ''
      - !!perl/hash:RE_method
        alt: numish_0 2
        name: rad_number
        rest: ''
      - !!perl/hash:RE_sequence
        alt: numish_0 3
        zyg:
        - !!perl/hash:RE_string
          i: 0
          text: 'NaN'
        - !!perl/hash:RE_meta
          text: »
      - !!perl/hash:RE_sequence
        alt: numish_0 4
        zyg:
        - !!perl/hash:RE_string
          i: 0
          text: 'Inf'
        - !!perl/hash:RE_meta
          text: »
      - !!perl/hash:RE_sequence
        alt: numish_0 5
        zyg:
        - !!perl/hash:RE_string
          i: 0
          text: '+Inf'
        - !!perl/hash:RE_meta
          text: »
      - !!perl/hash:RE_sequence
        alt: numish_0 6
        zyg:
        - !!perl/hash:RE_string
          i: 0
          text: '-Inf'
        - !!perl/hash:RE_meta
          text: »
numish_0: *24
octint: !!perl/hash:RE_ast
  dba: octint
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_cclass
        i: 0
        text: '[ 0..7 ]'
      quant:
      - +
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_string
            i: 0
            text: _
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_cclass
              i: 0
              text: '[ 0..7 ]'
            quant:
            - +
      quant:
      - '*'
octints: !!perl/hash:RE_ast
  dba: octints
  dic: STD::STD::P5
  re: !!perl/hash:RE_quantified_atom
    atom: !!perl/hash:RE_bracket
      re: !!perl/hash:RE_sequence
        zyg:
        - !!perl/hash:RE_method
          name: ws
          rest: ''
        - !!perl/hash:RE_method
          name: octint
          rest: ''
        - !!perl/hash:RE_method
          name: ws
          rest: ''
    quant:
    - '**'
    - ':'
    - !!perl/hash:RE_string
      a: 0
      dba: octints
      dic: STD::STD::P5
      i: 0
      i_needed: 1
      r: 1
      s: 0
      text: ','
p5circumfix:*:
  dic: STD::STD::P5
p5circumfix__S_120Lt_Gt: !!perl/hash:RE_ast
  dba: p5circumfix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: <
    - !!perl/hash:RE_method
      name: nibble
      rest: 1
    - !!perl/hash:RE_string
      i: 0
      text: '>'
p5circumfix__S_132sigil: !!perl/hash:RE_ast
  dba: contextualizer
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: p5sigil
        rest: ''
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_sequence
        zyg:
        - !!perl/hash:RE_string
          i: 0
          text: (
        - !!perl/hash:RE_block {}
        - !!perl/hash:RE_method
          name: semilist
          rest: ''
        - !!perl/hash:RE_bracket
          re: !!perl/hash:RE_first
            zyg:
            - !!perl/hash:RE_string
              i: 0
              text: )
            - !!perl/hash:RE_method
              name: FAILGOAL
              rest: 1
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5circumfix__S_133Paren_Thesis: !!perl/hash:RE_ast
  dba: parenthesized expression
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_sequence
        zyg:
        - !!perl/hash:RE_string
          i: 0
          text: (
        - !!perl/hash:RE_block {}
        - !!perl/hash:RE_method
          name: semilist
          rest: ''
        - !!perl/hash:RE_bracket
          re: !!perl/hash:RE_first
            zyg:
            - !!perl/hash:RE_string
              i: 0
              text: )
            - !!perl/hash:RE_method
              name: FAILGOAL
              rest: 1
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5circumfix__S_134Bra_Ket: !!perl/hash:RE_ast
  dba: array composer
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_sequence
        zyg:
        - !!perl/hash:RE_string
          i: 0
          text: '['
        - !!perl/hash:RE_block {}
        - !!perl/hash:RE_method
          name: semilist
          rest: ''
        - !!perl/hash:RE_bracket
          re: !!perl/hash:RE_first
            zyg:
            - !!perl/hash:RE_string
              i: 0
              text: ']'
            - !!perl/hash:RE_method
              name: FAILGOAL
              rest: 1
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5circumfix__S_139Cur_Ly: !!perl/hash:RE_ast
  dba: p5circumfix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_string
          i: 0
          text: '{'
    - !!perl/hash:RE_method
      name: pblock
      rest: ''
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5comment:*:
  dic: STD::STD::P5
p5comment__S_026Sharp: !!perl/hash:RE_ast
  dba: p5comment
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: '#'
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_meta
        min: 1
        text: \N
      quant:
      - '*'
p5dotty:*:
  dic: STD::STD::P5
p5dotty__S_135MinusGt: !!perl/hash:RE_ast
  dba: p5dotty
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: unspacey
      i: 0
      name: sym
      rest: ''
      sym: ->
    - !!perl/hash:RE_method
      name: unspacey
      rest: ''
    - !!perl/hash:RE_method
      name: dottyop
      rest: ''
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix:*:
  dic: STD::STD::P5
p5infix__S_145StarStar: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '**'
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_150BangTilde: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '!~'
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_151EqualTilde: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: =~
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_152Star: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '*'
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_153Slash: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: /
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_154Percent: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '%'
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_155LtLt: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: <<
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_156GtGt: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '>>'
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_157x: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: x
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_158Dot: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: .
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_159Plus: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: +
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_160Minus: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '-'
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_161Amp: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '&'
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_162also: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: also
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_163Vert: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '|'
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_164Caret: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: ^
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_169LtEqualGt: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: <=>
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_block
        nobind: 1
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_170cmp: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: cmp
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_block
        nobind: 1
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_171Lt: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: <
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_172LtEqual: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: <=
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_173Gt: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '>'
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_174GtEqual: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '>='
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_175eq: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: eq
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_176ne: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: ne
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_177lt: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: lt
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_178le: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: le
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_179gt: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: gt
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_180ge: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: ge
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_181EqualEqual: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: ==
    - !!perl/hash:RE_assertion
      assert: '!'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_string
          i: 0
          text: =
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_182BangEqual: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '!='
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_meta
          min: 1
          text: \s
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_183AmpAmp: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '&&'
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_184VertVert: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '||'
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_185CaretCaret: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: ^^
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_186SlashSlash: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: //
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_187DotDot: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: ..
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_188DotDotDot: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '...'
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_189Question_Colon: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: '?'
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: EXPR
      rest: 1
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_first
        zyg:
        - !!perl/hash:RE_string
          i: 0
          text: ':'
        - !!perl/hash:RE_bracket
          re: !!perl/hash:RE_first
            zyg:
            - !!perl/hash:RE_sequence
              zyg:
              - !!perl/hash:RE_assertion
                assert: '?'
                re: !!perl/hash:RE_method_re
                  name: before
                  nobind: 1
                  re: !!perl/hash:RE_string
                    i: 0
                    text: =
              - !!perl/hash:RE_method
                name: panic
                rest: 1
            - !!perl/hash:RE_sequence
              zyg:
              - !!perl/hash:RE_assertion
                assert: '?'
                re: !!perl/hash:RE_method_re
                  name: before
                  nobind: 1
                  re: !!perl/hash:RE_string
                    i: 0
                    text: '!!'
              - !!perl/hash:RE_method
                name: panic
                rest: 1
            - !!perl/hash:RE_sequence
              zyg:
              - !!perl/hash:RE_assertion
                assert: '?'
                re: !!perl/hash:RE_method_re
                  name: before
                  nobind: 1
                  re: !!perl/hash:RE_method
                    name: infixish
                    rest: ''
              - !!perl/hash:RE_method
                name: panic
                rest: 1
            - !!perl/hash:RE_method
              name: panic
              rest: 1
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_190Equal: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: =
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_191Comma: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: ','
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_192EqualGt: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: =>
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_196and: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: and
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_197andthen: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: andthen
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_198or: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: or
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_199orelse: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: orelse
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5infix__S_200xor: !!perl/hash:RE_ast
  dba: p5infix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: xor
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5module_name:*:
  dic: STD::STD::P5
p5module_name__S_047normal: !!perl/hash:RE_ast
  dba: p5module_name
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: longname
      rest: ''
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_method_re
              name: before
              nobind: 1
              re: !!perl/hash:RE_string
                i: 0
                text: '['
          - !!perl/hash:RE_bracket
            re: !!perl/hash:RE_sequence
              zyg:
              - !!perl/hash:RE_string
                i: 0
                text: '['
              - !!perl/hash:RE_block {}
              - !!perl/hash:RE_method
                name: arglist
                rest: ''
              - !!perl/hash:RE_bracket
                re: !!perl/hash:RE_first
                  zyg:
                  - !!perl/hash:RE_string
                    i: 0
                    text: ']'
                  - !!perl/hash:RE_method
                    name: FAILGOAL
                    rest: 1
      quant:
      - '?'
p5multi_declarator__S_054null: !!perl/hash:RE_ast
  dba: p5multi_declarator
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    name: declarator
    rest: ''
p5number:*:
  dic: STD::STD::P5
p5package_declarator:*:
  dic: STD::STD::P5
p5package_declarator__S_052package: !!perl/hash:RE_ast
  dba: p5package_declarator
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: spacey
      i: 0
      name: sym
      rest: ''
      sym: package
    - !!perl/hash:RE_method
      name: spacey
      rest: ''
    - !!perl/hash:RE_method
      name: package_def
      rest: ''
p5package_declarator__S_053require: !!perl/hash:RE_ast
  dba: p5package_declarator
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: spacey
      i: 0
      name: sym
      rest: ''
      sym: require
    - !!perl/hash:RE_method
      name: spacey
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_first
        zyg:
        - !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_bindnamed
            atom: !!perl/hash:RE_method
              name: p5module_name
              rest: ''
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_method
              name: EXPR
              rest: ''
            quant:
            - '?'
        - !!perl/hash:RE_method
          name: EXPR
          rest: ''
p5postcircumfix:*:
  dic: STD::STD::P5
p5postcircumfix__S_136Paren_Thesis: !!perl/hash:RE_ast
  dba: argument list
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_sequence
        zyg:
        - !!perl/hash:RE_string
          i: 0
          text: (
        - !!perl/hash:RE_block {}
        - !!perl/hash:RE_method
          name: semiarglist
          rest: ''
        - !!perl/hash:RE_bracket
          re: !!perl/hash:RE_first
            zyg:
            - !!perl/hash:RE_string
              i: 0
              text: )
            - !!perl/hash:RE_method
              name: FAILGOAL
              rest: 1
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5postcircumfix__S_137Bra_Ket: !!perl/hash:RE_ast
  dba: subscript
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_sequence
        zyg:
        - !!perl/hash:RE_string
          i: 0
          text: '['
        - !!perl/hash:RE_block {}
        - !!perl/hash:RE_method
          name: semilist
          rest: ''
        - !!perl/hash:RE_bracket
          re: !!perl/hash:RE_first
            zyg:
            - !!perl/hash:RE_string
              i: 0
              text: ']'
            - !!perl/hash:RE_method
              name: FAILGOAL
              rest: 1
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5postcircumfix__S_138Cur_Ly: !!perl/hash:RE_ast
  dba: subscript
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_sequence
        zyg:
        - !!perl/hash:RE_string
          i: 0
          text: '{'
        - !!perl/hash:RE_block {}
        - !!perl/hash:RE_method
          name: semilist
          rest: ''
        - !!perl/hash:RE_bracket
          re: !!perl/hash:RE_first
            zyg:
            - !!perl/hash:RE_string
              i: 0
              text: '}'
            - !!perl/hash:RE_method
              name: FAILGOAL
              rest: 1
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5postfix:*:
  dic: STD::STD::P5
p5postfix__S_140MinusGt: !!perl/hash:RE_ast
  dba: p5postfix
  dic: STD::STD::P5
  re: !!perl/hash:RE_string
    i: 0
    text: ->
p5postfix__S_141PlusPlus: !!perl/hash:RE_ast
  dba: p5postfix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: ++
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5postfix__S_142MinusMinus: !!perl/hash:RE_ast
  dba: p5postfix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: --
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5prefix:*:
  dic: STD::STD::P5
p5prefix__S_143PlusPlus: !!perl/hash:RE_ast
  dba: p5prefix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: ++
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5prefix__S_144MinusMinus: !!perl/hash:RE_ast
  dba: p5prefix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: --
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5prefix__S_146Bang: !!perl/hash:RE_ast
  dba: p5prefix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '!'
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5prefix__S_147Plus: !!perl/hash:RE_ast
  dba: p5prefix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: +
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5prefix__S_148Minus: !!perl/hash:RE_ast
  dba: p5prefix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '-'
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5prefix__S_149Tilde: !!perl/hash:RE_ast
  dba: p5prefix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '~'
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5prefix__S_165sleep: !!perl/hash:RE_ast
  dba: p5prefix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: sleep
    - !!perl/hash:RE_meta
      text: »
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_quantified_atom
          atom: !!perl/hash:RE_meta
            min: 1
            text: \s
          quant:
          - '*'
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5prefix__S_166abs: !!perl/hash:RE_ast
  dba: p5prefix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: abs
    - !!perl/hash:RE_meta
      text: »
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_quantified_atom
          atom: !!perl/hash:RE_meta
            min: 1
            text: \s
          quant:
          - '*'
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5prefix__S_167let: !!perl/hash:RE_ast
  dba: p5prefix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: let
    - !!perl/hash:RE_meta
      text: »
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_quantified_atom
          atom: !!perl/hash:RE_meta
            min: 1
            text: \s
          quant:
          - '*'
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5prefix__S_168temp: !!perl/hash:RE_ast
  dba: p5prefix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: temp
    - !!perl/hash:RE_meta
      text: »
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_quantified_atom
          atom: !!perl/hash:RE_meta
            min: 1
            text: \s
          quant:
          - '*'
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5quote:*:
  dic: STD::STD::P5
p5quote__S_118Single_Single: !!perl/hash:RE_ast
  dba: p5quote
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_double
      i: 0
      text: ''''
    - !!perl/hash:RE_method
      name: nibble
      rest: 1
    - !!perl/hash:RE_double
      i: 0
      text: ''''
p5quote__S_119Double_Double: !!perl/hash:RE_ast
  dba: p5quote
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: '"'
    - !!perl/hash:RE_method
      name: nibble
      rest: 1
    - !!perl/hash:RE_string
      i: 0
      text: '"'
p5quote__S_121Slash_Slash: !!perl/hash:RE_ast
  dba: p5quote
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: /
    - !!perl/hash:RE_method
      name: nibble
      rest: 1
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_first
        zyg:
        - !!perl/hash:RE_string
          i: 0
          text: /
        - !!perl/hash:RE_method
          name: panic
          rest: 1
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_method
        name: p5rx_mods
        rest: ''
      quant:
      - '?'
p5regex_declarator:*:
  dic: STD::STD::P5
p5routine_declarator:*:
  dic: STD::STD::P5
p5routine_declarator__S_055sub: !!perl/hash:RE_ast
  dba: p5routine_declarator
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: nofun
      i: 0
      name: sym
      rest: ''
      sym: sub
    - !!perl/hash:RE_method
      name: nofun
      rest: ''
    - !!perl/hash:RE_method
      name: routine_def
      rest: ''
p5rx_mods: !!perl/hash:RE_ast
  dba: p5rx_mods
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_assertion
      assert: '!'
      re: !!perl/hash:RE_method_re
        name: after
        nobind: 1
        re: !!perl/hash:RE_meta
          min: 1
          text: \s
    - !!perl/hash:RE_bindpos
      atom: !!perl/hash:RE_paren
        re: !!perl/hash:RE_quantified_atom
          atom: !!perl/hash:RE_qw
            min: 1
            text: < i g s m x c e >
          quant:
          - +
p5scope_declarator:*:
  dic: STD::STD::P5
p5scope_declarator__S_049my: !!perl/hash:RE_ast
  dba: p5scope_declarator
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: nofun
      i: 0
      name: sym
      rest: ''
      sym: my
    - !!perl/hash:RE_method
      name: nofun
      rest: ''
    - !!perl/hash:RE_method
      name: scoped
      rest: 1
p5scope_declarator__S_050our: !!perl/hash:RE_ast
  dba: p5scope_declarator
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: nofun
      i: 0
      name: sym
      rest: ''
      sym: our
    - !!perl/hash:RE_method
      name: nofun
      rest: ''
    - !!perl/hash:RE_method
      name: scoped
      rest: 1
p5scope_declarator__S_051state: !!perl/hash:RE_ast
  dba: p5scope_declarator
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: nofun
      i: 0
      name: sym
      rest: ''
      sym: state
    - !!perl/hash:RE_method
      name: nofun
      rest: ''
    - !!perl/hash:RE_method
      name: scoped
      rest: 1
p5sigil:*:
  dic: STD::STD::P5
p5sigil__S_109Dollar: !!perl/hash:RE_ast
  dba: p5sigil
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $
p5sigil__S_110At: !!perl/hash:RE_ast
  dba: p5sigil
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: '@'
p5sigil__S_111Percent: !!perl/hash:RE_ast
  dba: p5sigil
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: '%'
p5sigil__S_112Amp: !!perl/hash:RE_ast
  dba: p5sigil
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: '&'
p5special_variable:*:
  dic: STD::STD::P5
p5special_variable__S_066DollarBang: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: $!
    - !!perl/hash:RE_assertion
      assert: '!'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_meta
          min: 1
          text: \w
p5special_variable__S_067DollarBangCur_Ly: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_bracket
    re: !!perl/hash:RE_sequence
      zyg:
      - !!perl/hash:RE_string
        i: 0
        text: $!{
      - !!perl/hash:RE_block {}
      - !!perl/hash:RE_method
        name: EXPR
        rest: ''
      - !!perl/hash:RE_bracket
        re: !!perl/hash:RE_first
          zyg:
          - !!perl/hash:RE_string
            i: 0
            text: '}'
          - !!perl/hash:RE_method
            name: FAILGOAL
            rest: 1
p5special_variable__S_068DollarSlash: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $/
p5special_variable__S_069DollarTilde: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $~
p5special_variable__S_070DollarGrave: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $`
p5special_variable__S_071DollarAt: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $@
p5special_variable__S_072DollarSharp: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $#
p5special_variable__S_073DollarDollar: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: $$
    - !!perl/hash:RE_assertion
      assert: '!'
      re: !!perl/hash:RE_method
        name: alpha
        rest: ''
p5special_variable__S_074DollarPercent: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $%
p5special_variable__S_075DollarCaretX: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: p5sigil
        rest: ''
    - !!perl/hash:RE_string
      i: 0
      text: ^
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_cclass
          i: 0
          text: '[A..Z]'
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_meta
          min: 1
          text: \W
p5special_variable__S_076DollarCaret: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $^
p5special_variable__S_077DollarAmp: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $&
p5special_variable__S_078DollarStar: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $*
p5special_variable__S_079DollarThesis: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $)
p5special_variable__S_080DollarMinus: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $-
p5special_variable__S_081DollarEqual: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $=
p5special_variable__S_082AtPlus: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: '@+'
p5special_variable__S_083PercentPlus: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: '%+'
p5special_variable__S_084DollarPlusBra_Ket: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_string
    i: 0
    text: $+[
p5special_variable__S_085AtPlusBra_Ket: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_string
    i: 0
    text: '@+['
p5special_variable__S_086AtPlusCur_Ly: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_string
    i: 0
    text: '@+{'
p5special_variable__S_087AtMinus: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: '@-'
p5special_variable__S_088PercentMinus: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: '%-'
p5special_variable__S_089DollarMinusBra_Ket: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_string
    i: 0
    text: $-[
p5special_variable__S_090AtMinusBra_Ket: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_string
    i: 0
    text: '@-['
p5special_variable__S_091PercentMinusCur_Ly: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_string
    i: 0
    text: '@-{'
p5special_variable__S_092DollarPlus: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $+
p5special_variable__S_093DollarCurCaret_Ly: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: p5sigil
        rest: ''
    - !!perl/hash:RE_string
      i: 0
      text: '{^'
    - !!perl/hash:RE_meta
      text: '::'
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_meta
          text: .*?
    - !!perl/hash:RE_string
      i: 0
      text: '}'
p5special_variable__S_094ColonColonCur_Ly: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: '::'
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_string
          i: 0
          text: '{'
p5special_variable__S_095DollarCur_Ly: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: p5sigil
        rest: ''
    - !!perl/hash:RE_string
      i: 0
      text: '{'
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_meta
          text: .*?
    - !!perl/hash:RE_string
      i: 0
      text: '}'
p5special_variable__S_096DollarBra: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $[
p5special_variable__S_097DollarKet: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $]
p5special_variable__S_098DollarBack: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $\
p5special_variable__S_099DollarVert: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $|
p5special_variable__S_100DollarColon: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: '$:'
p5special_variable__S_101DollarSemi: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $;
p5special_variable__S_102DollarSingle: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $'
p5special_variable__S_103DollarDouble: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: $"
    - !!perl/hash:RE_assertion
      assert: '!'
      re: !!perl/hash:RE_block
        nobind: 1
p5special_variable__S_104DollarComma: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $,
p5special_variable__S_105DollarLt: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $<
p5special_variable__S_106DollarGt: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $>
p5special_variable__S_107DollarDot: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $.
p5special_variable__S_108DollarQuestion: !!perl/hash:RE_ast
  dba: p5special_variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: $?
p5statement_control:*:
  dic: STD::STD::P5
p5statement_control__S_027use: !!perl/hash:RE_ast
  dba: p5statement_control
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: spacey
      i: 0
      name: sym
      rest: ''
      sym: use
    - !!perl/hash:RE_method
      name: spacey
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_bracket
      re: &25 !!perl/hash:RE_any
        altname: p5statement_control__S_027use_0
        dba: p5statement_control
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_bindnamed
          alt: p5statement_control__S_027use_0 0
          atom: !!perl/hash:RE_method
            name: p5version
            rest: ''
        - !!perl/hash:RE_sequence
          alt: p5statement_control__S_027use_0 1
          zyg:
          - !!perl/hash:RE_bindnamed
            atom: !!perl/hash:RE_method
              name: p5module_name
              rest: ''
          - !!perl/hash:RE_block {}
          - !!perl/hash:RE_bracket
            re: !!perl/hash:RE_first
              zyg:
              - !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_method
                  name: spacey
                  rest: ''
                - !!perl/hash:RE_method
                  name: arglist
                  rest: ''
                - !!perl/hash:RE_block {}
              - !!perl/hash:RE_block {}
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5statement_control__S_027use_0: *25
p5statement_control__S_028no: !!perl/hash:RE_ast
  dba: p5statement_control
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: spacey
      i: 0
      name: sym
      rest: ''
      sym: no
    - !!perl/hash:RE_method
      name: spacey
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: p5module_name
        rest: ''
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_method
            name: spacey
            rest: ''
          - !!perl/hash:RE_method
            name: arglist
            rest: ''
      quant:
      - '?'
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5statement_control__S_029if: !!perl/hash:RE_ast
  dba: p5statement_control
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_bracket
        re: &26 !!perl/hash:RE_any
          altname: p5statement_control__S_029if_0
          dba: p5statement_control
          dic: STD::STD::P5
          zyg:
          - !!perl/hash:RE_string
            alt: p5statement_control__S_029if_0 0
            i: 0
            text: if
          - !!perl/hash:RE_string
            alt: p5statement_control__S_029if_0 1
            i: 0
            text: unless
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: xblock
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_method
            name: ws
            rest: ''
          - !!perl/hash:RE_bracket
            re: !!perl/hash:RE_first
              zyg:
              - !!perl/hash:RE_assertion
                assert: '!'
                re: !!perl/hash:RE_method_re
                  name: before
                  nobind: 1
                  re: !!perl/hash:RE_sequence
                    zyg:
                    - !!perl/hash:RE_method
                      name: ws
                      rest: ''
                    - !!perl/hash:RE_string
                      i: 0
                      text: else
                    - !!perl/hash:RE_quantified_atom
                      atom: !!perl/hash:RE_meta
                        min: 1
                        text: \s
                      quant:
                      - '*'
                    - !!perl/hash:RE_string
                      i: 0
                      text: if
              - !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_method
                  name: panic
                  rest: 1
                - !!perl/hash:RE_method
                  name: ws
                  rest: ''
          - !!perl/hash:RE_string
            i: 0
            text: elsif
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_method
              name: spacey
              rest: ''
          - !!perl/hash:RE_method
            name: ws
            rest: ''
          - !!perl/hash:RE_bindnamed
            atom: !!perl/hash:RE_method
              name: xblock
              rest: ''
          - !!perl/hash:RE_method
            name: ws
            rest: ''
      quant:
      - '*'
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_method
            name: ws
            rest: ''
          - !!perl/hash:RE_string
            i: 0
            text: else
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_method
              name: spacey
              rest: ''
          - !!perl/hash:RE_method
            name: ws
            rest: ''
          - !!perl/hash:RE_bindnamed
            atom: !!perl/hash:RE_method
              name: pblock
              rest: ''
          - !!perl/hash:RE_method
            name: ws
            rest: ''
      quant:
      - '?'
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5statement_control__S_029if_0: *26
p5statement_control__S_030while: !!perl/hash:RE_ast
  dba: p5statement_control
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: spacey
      i: 0
      name: sym
      rest: ''
      sym: while
    - !!perl/hash:RE_method
      name: spacey
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: xblock
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5statement_control__S_031until: !!perl/hash:RE_ast
  dba: p5statement_control
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: spacey
      i: 0
      name: sym
      rest: ''
      sym: until
    - !!perl/hash:RE_method
      name: spacey
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: xblock
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5statement_control__S_032for: !!perl/hash:RE_ast
  dba: p5statement_control
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bracket
      re: &27 !!perl/hash:RE_any
        altname: p5statement_control__S_032for_0
        dba: p5statement_control
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_string
          alt: p5statement_control__S_032for_0 0
          i: 0
          text: for
        - !!perl/hash:RE_string
          alt: p5statement_control__S_032for_0 1
          i: 0
          text: foreach
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_quantified_atom
        atom: !!perl/hash:RE_paren
          re: !!perl/hash:RE_sequence
            zyg:
            - !!perl/hash:RE_string
              i: 0
              text: (
            - !!perl/hash:RE_bracket
              re: !!perl/hash:RE_first
                zyg:
                - !!perl/hash:RE_sequence
                  zyg:
                  - !!perl/hash:RE_method
                    name: ws
                    rest: ''
                  - !!perl/hash:RE_quantified_atom
                    atom: !!perl/hash:RE_bindnamed
                      atom: !!perl/hash:RE_method
                        name: EXPR
                        rest: ''
                    quant:
                    - '?'
                  - !!perl/hash:RE_method
                    name: ws
                    rest: ''
                  - !!perl/hash:RE_string
                    i: 0
                    text: ;
                  - !!perl/hash:RE_method
                    name: ws
                    rest: ''
                  - !!perl/hash:RE_quantified_atom
                    atom: !!perl/hash:RE_bindnamed
                      atom: !!perl/hash:RE_method
                        name: EXPR
                        rest: ''
                    quant:
                    - '?'
                  - !!perl/hash:RE_method
                    name: ws
                    rest: ''
                  - !!perl/hash:RE_string
                    i: 0
                    text: ;
                  - !!perl/hash:RE_method
                    name: ws
                    rest: ''
                  - !!perl/hash:RE_quantified_atom
                    atom: !!perl/hash:RE_bindnamed
                      atom: !!perl/hash:RE_method
                        name: EXPR
                        rest: ''
                    quant:
                    - '?'
                  - !!perl/hash:RE_method
                    name: ws
                    rest: ''
                  - !!perl/hash:RE_string
                    i: 0
                    text: )
                - !!perl/hash:RE_method
                  name: panic
                  rest: 1
        quant:
        - '?'
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: block
      rest: ''
p5statement_control__S_032for_0: *27
p5statement_control__S_033given: !!perl/hash:RE_ast
  dba: p5statement_control
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: spacey
      i: 0
      name: sym
      rest: ''
      sym: given
    - !!perl/hash:RE_method
      name: spacey
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: xblock
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5statement_control__S_034when: !!perl/hash:RE_ast
  dba: p5statement_control
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: spacey
      i: 0
      name: sym
      rest: ''
      sym: when
    - !!perl/hash:RE_method
      name: spacey
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: xblock
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5statement_control__S_035default: !!perl/hash:RE_ast
  dba: p5statement_control
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: spacey
      i: 0
      name: sym
      rest: ''
      sym: default
    - !!perl/hash:RE_method
      name: spacey
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: block
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5statement_control__S_039END: !!perl/hash:RE_ast
  dba: p5statement_control
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: spacey
      i: 0
      name: sym
      rest: ''
      sym: END
    - !!perl/hash:RE_method
      name: spacey
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: block
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5statement_mod_cond:*:
  dic: STD::STD::P5
p5statement_mod_cond__S_040if: !!perl/hash:RE_ast
  dba: p5statement_mod_cond
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: nofun
      i: 0
      name: sym
      rest: ''
      sym: if
    - !!perl/hash:RE_method
      name: nofun
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: modifier_expr
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5statement_mod_cond__S_041unless: !!perl/hash:RE_ast
  dba: p5statement_mod_cond
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: nofun
      i: 0
      name: sym
      rest: ''
      sym: unless
    - !!perl/hash:RE_method
      name: nofun
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: modifier_expr
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5statement_mod_cond__S_042when: !!perl/hash:RE_ast
  dba: p5statement_mod_cond
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: nofun
      i: 0
      name: sym
      rest: ''
      sym: when
    - !!perl/hash:RE_method
      name: nofun
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: modifier_expr
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5statement_mod_loop:*:
  dic: STD::STD::P5
p5statement_mod_loop__S_043while: !!perl/hash:RE_ast
  dba: p5statement_mod_loop
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: nofun
      i: 0
      name: sym
      rest: ''
      sym: while
    - !!perl/hash:RE_method
      name: nofun
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: modifier_expr
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5statement_mod_loop__S_044until: !!perl/hash:RE_ast
  dba: p5statement_mod_loop
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: nofun
      i: 0
      name: sym
      rest: ''
      sym: until
    - !!perl/hash:RE_method
      name: nofun
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: modifier_expr
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5statement_mod_loop__S_045for: !!perl/hash:RE_ast
  dba: p5statement_mod_loop
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: nofun
      i: 0
      name: sym
      rest: ''
      sym: for
    - !!perl/hash:RE_method
      name: nofun
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: modifier_expr
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5statement_mod_loop__S_046given: !!perl/hash:RE_ast
  dba: p5statement_mod_loop
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      endsym: nofun
      i: 0
      name: sym
      rest: ''
      sym: given
    - !!perl/hash:RE_method
      name: nofun
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: modifier_expr
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5statement_prefix:*:
  dic: STD::STD::P5
p5statement_prefix__S_036BEGIN: !!perl/hash:RE_ast
  dba: p5statement_prefix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: BEGIN
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: block
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5statement_prefix__S_037CHECK: !!perl/hash:RE_ast
  dba: p5statement_prefix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: CHECK
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: block
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5statement_prefix__S_038INIT: !!perl/hash:RE_ast
  dba: p5statement_prefix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: INIT
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: block
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5statement_prefix__S_128do: !!perl/hash:RE_ast
  dba: p5statement_prefix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: do
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: block
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5statement_prefix__S_129eval: !!perl/hash:RE_ast
  dba: p5statement_prefix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: eval
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: block
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5term:*:
  dic: STD::STD::P5
p5term__S_056fatarrow: !!perl/hash:RE_ast
  dba: p5term
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    name: fatarrow
    rest: ''
p5term__S_057variable: !!perl/hash:RE_ast
  dba: p5term
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: variable
      rest: ''
    - !!perl/hash:RE_block {}
p5term__S_058package_declarator: !!perl/hash:RE_ast
  dba: p5term
  dic: STD::STD::P5
  re: !!perl/hash:RE_bindnamed
    atom: !!perl/hash:RE_method
      name: p5package_declarator
      rest: ''
p5term__S_059scope_declarator: !!perl/hash:RE_ast
  dba: p5term
  dic: STD::STD::P5
  re: !!perl/hash:RE_bindnamed
    atom: !!perl/hash:RE_method
      name: p5scope_declarator
      rest: ''
p5term__S_060routine_declarator: !!perl/hash:RE_ast
  dba: p5term
  dic: STD::STD::P5
  re: !!perl/hash:RE_bindnamed
    atom: !!perl/hash:RE_method
      name: p5routine_declarator
      rest: ''
p5term__S_061circumfix: !!perl/hash:RE_ast
  dba: p5term
  dic: STD::STD::P5
  re: !!perl/hash:RE_bindnamed
    atom: !!perl/hash:RE_method
      name: p5circumfix
      rest: ''
p5term__S_062dotty: !!perl/hash:RE_ast
  dba: p5term
  dic: STD::STD::P5
  re: !!perl/hash:RE_bindnamed
    atom: !!perl/hash:RE_method
      name: p5dotty
      rest: ''
p5term__S_063value: !!perl/hash:RE_ast
  dba: p5term
  dic: STD::STD::P5
  re: !!perl/hash:RE_bindnamed
    atom: !!perl/hash:RE_method
      name: p5value
      rest: ''
p5term__S_064capterm: !!perl/hash:RE_ast
  dba: p5term
  dic: STD::STD::P5
  re: !!perl/hash:RE_method
    name: capterm
    rest: ''
p5term__S_065statement_prefix: !!perl/hash:RE_ast
  dba: p5term
  dic: STD::STD::P5
  re: !!perl/hash:RE_bindnamed
    atom: !!perl/hash:RE_method
      name: p5statement_prefix
      rest: ''
p5term__S_130undef: !!perl/hash:RE_ast
  dba: p5term
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: undef
    - !!perl/hash:RE_meta
      text: »
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5term__S_131continue: !!perl/hash:RE_ast
  dba: p5term
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: continue
    - !!perl/hash:RE_meta
      text: »
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5term__S_193identifier: !!perl/hash:RE_ast
  dba: p5term
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: identifier
      rest: ''
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_quantified_atom
          atom: !!perl/hash:RE_bracket
            re: &28 !!perl/hash:RE_any
              altname: p5term__S_193identifier_0
              dba: p5term
              dic: STD::STD::P5
              zyg:
              - !!perl/hash:RE_method
                alt: p5term__S_193identifier_0 0
                name: unsp
                rest: ''
              - !!perl/hash:RE_string
                alt: p5term__S_193identifier_0 1
                i: 0
                text: (
          quant:
          - '?'
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_method
      name: args
      rest: 1
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5term__S_193identifier_0: *28
p5term__S_194opfunc: !!perl/hash:RE_ast
  dba: p5term
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: category
      rest: ''
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_method
        name: colonpair
        rest: ''
      quant:
      - +
    - !!perl/hash:RE_method
      name: args
      rest: ''
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5term__S_195name: !!perl/hash:RE_ast
  dba: p5term
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: longname
      rest: ''
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_first
        zyg:
        - !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_block
              nobind: 1
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_method
              name: unsp
              rest: ''
            quant:
            - '?'
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_bracket
              re: !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_assertion
                  assert: '?'
                  re: !!perl/hash:RE_method_re
                    name: before
                    nobind: 1
                    re: !!perl/hash:RE_string
                      i: 0
                      text: '['
                - !!perl/hash:RE_bindnamed
                  atom: !!perl/hash:RE_method
                    name: p5postcircumfix
                    rest: ''
            quant:
            - '?'
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_bracket
              re: !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_string
                  i: 0
                  text: '::'
                - !!perl/hash:RE_assertion
                  assert: '?'
                  re: !!perl/hash:RE_method_re
                    name: before
                    nobind: 1
                    re: !!perl/hash:RE_bracket
                      re: &29 !!perl/hash:RE_any
                        altname: p5term__S_195name_0
                        dba: type parameter
                        dic: STD::STD::P5
                        zyg:
                        - !!perl/hash:RE_string
                          alt: p5term__S_195name_0 0
                          i: 0
                          text: «
                        - !!perl/hash:RE_string
                          alt: p5term__S_195name_0 1
                          i: 0
                          text: <
                        - !!perl/hash:RE_string
                          alt: p5term__S_195name_0 2
                          i: 0
                          text: '{'
                        - !!perl/hash:RE_string
                          alt: p5term__S_195name_0 3
                          i: 0
                          text: <<
                - !!perl/hash:RE_bindnamed
                  atom: !!perl/hash:RE_method
                    name: p5postcircumfix
                    rest: ''
            quant:
            - '?'
        - !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_method
            name: args
            rest: ''
          - !!perl/hash:RE_block {}
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5term__S_195name_0: *29
p5terminator:*:
  dic: STD::STD::P5
p5terminator__S_201Semi: !!perl/hash:RE_ast
  dba: p5terminator
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: ;
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5terminator__S_202if: !!perl/hash:RE_ast
  dba: p5terminator
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: if
    - !!perl/hash:RE_meta
      text: »
    - !!perl/hash:RE_method
      name: nofun
      rest: ''
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5terminator__S_203unless: !!perl/hash:RE_ast
  dba: p5terminator
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: unless
    - !!perl/hash:RE_meta
      text: »
    - !!perl/hash:RE_method
      name: nofun
      rest: ''
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5terminator__S_204while: !!perl/hash:RE_ast
  dba: p5terminator
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: while
    - !!perl/hash:RE_meta
      text: »
    - !!perl/hash:RE_method
      name: nofun
      rest: ''
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5terminator__S_205until: !!perl/hash:RE_ast
  dba: p5terminator
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: until
    - !!perl/hash:RE_meta
      text: »
    - !!perl/hash:RE_method
      name: nofun
      rest: ''
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5terminator__S_206for: !!perl/hash:RE_ast
  dba: p5terminator
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: for
    - !!perl/hash:RE_meta
      text: »
    - !!perl/hash:RE_method
      name: nofun
      rest: ''
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5terminator__S_207given: !!perl/hash:RE_ast
  dba: p5terminator
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: given
    - !!perl/hash:RE_meta
      text: »
    - !!perl/hash:RE_method
      name: nofun
      rest: ''
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5terminator__S_208when: !!perl/hash:RE_ast
  dba: p5terminator
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: when
    - !!perl/hash:RE_meta
      text: »
    - !!perl/hash:RE_method
      name: nofun
      rest: ''
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5terminator__S_209Thesis: !!perl/hash:RE_ast
  dba: p5terminator
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: )
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5terminator__S_210Ket: !!perl/hash:RE_ast
  dba: p5terminator
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: ']'
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5terminator__S_211Ly: !!perl/hash:RE_ast
  dba: p5terminator
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: '}'
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5terminator__S_212Colon: !!perl/hash:RE_ast
  dba: p5terminator
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: ':'
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_block
        nobind: 1
    - !!perl/hash:RE_method
      name: O
      rest: 1
p5tr_mods: !!perl/hash:RE_ast
  dba: p5tr_mods
  dic: STD::STD::P5
  re: !!perl/hash:RE_bindpos
    atom: !!perl/hash:RE_paren
      re: !!perl/hash:RE_quantified_atom
        atom: !!perl/hash:RE_qw
          min: 1
          text: < c d s ] >
        quant:
        - +
p5type_declarator:*:
  dic: STD::STD::P5
p5value:*:
  dic: STD::STD::P5
p5value__S_113quote: !!perl/hash:RE_ast
  dba: p5value
  dic: STD::STD::P5
  re: !!perl/hash:RE_bindnamed
    atom: !!perl/hash:RE_method
      name: p5quote
      rest: ''
p5value__S_114number: !!perl/hash:RE_ast
  dba: p5value
  dic: STD::STD::P5
  re: !!perl/hash:RE_bindnamed
    atom: !!perl/hash:RE_method
      name: p5number
      rest: ''
p5value__S_115version: !!perl/hash:RE_ast
  dba: p5value
  dic: STD::STD::P5
  re: !!perl/hash:RE_bindnamed
    atom: !!perl/hash:RE_method
      name: p5version
      rest: ''
p5version:*:
  dic: STD::STD::P5
p5version__S_048v: !!perl/hash:RE_ast
  dba: p5version
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: v
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_quantified_atom
          atom: !!perl/hash:RE_meta
            min: 1
            text: \d
          quant:
          - +
    - !!perl/hash:RE_meta
      text: '::'
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_method
        name: vnum
        rest: ''
      quant:
      - '**'
      - ':'
      - !!perl/hash:RE_string
        a: 0
        dba: p5version
        dic: STD::STD::P5
        i: 0
        i_needed: 1
        r: 1
        s: 0
        text: .
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_string
        i: 0
        text: +
      quant:
      - '?'
package_def: !!perl/hash:RE_ast
  dba: package_def
  dic: STD::STD::P5
  re: !!perl/hash:RE_first
    zyg:
    - !!perl/hash:RE_sequence
      zyg:
      - !!perl/hash:RE_method
        name: ws
        rest: ''
      - !!perl/hash:RE_block {}
      - !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_bracket
              re: !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_method
                  name: ws
                  rest: ''
                - !!perl/hash:RE_method
                  name: def_module_name
                  rest: ''
                - !!perl/hash:RE_block {}
                - !!perl/hash:RE_method
                  name: ws
                  rest: ''
            quant:
            - '?'
          - !!perl/hash:RE_method
            name: ws
            rest: ''
          - !!perl/hash:RE_bracket
            re: !!perl/hash:RE_first
              zyg:
              - !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_assertion
                  assert: '?'
                  re: !!perl/hash:RE_method_re
                    name: before
                    nobind: 1
                    re: !!perl/hash:RE_sequence
                      zyg:
                      - !!perl/hash:RE_method
                        name: ws
                        rest: ''
                      - !!perl/hash:RE_string
                        i: 0
                        text: ;
                - !!perl/hash:RE_block {}
              - !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_method
                  name: panic
                  rest: 1
                - !!perl/hash:RE_method
                  name: ws
                  rest: ''
    - !!perl/hash:RE_sequence
      zyg:
      - !!perl/hash:RE_method
        name: ws
        rest: ''
      - !!perl/hash:RE_method
        name: panic
        rest: 1
      - !!perl/hash:RE_method
        name: ws
        rest: ''
param_sep: !!perl/hash:RE_ast
  dba: param_sep
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_bracket
      re: &30 !!perl/hash:RE_any
        altname: param_sep_0
        dba: param_sep
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_string
          alt: param_sep_0 0
          i: 0
          text: ','
        - !!perl/hash:RE_string
          alt: param_sep_0 1
          i: 0
          text: ':'
        - !!perl/hash:RE_string
          alt: param_sep_0 2
          i: 0
          text: ;
        - !!perl/hash:RE_string
          alt: param_sep_0 3
          i: 0
          text: ;;
    - !!perl/hash:RE_method
      name: ws
      rest: ''
param_sep_0: *30
parensig: !!perl/hash:RE_ast
  dba: signature
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_sequence
        zyg:
        - !!perl/hash:RE_string
          i: 0
          text: (
        - !!perl/hash:RE_block {}
        - !!perl/hash:RE_method
          name: signature
          rest: 1
        - !!perl/hash:RE_bracket
          re: !!perl/hash:RE_first
            zyg:
            - !!perl/hash:RE_string
              i: 0
              text: )
            - !!perl/hash:RE_method
              name: FAILGOAL
              rest: 1
    - !!perl/hash:RE_method
      name: ws
      rest: ''
pod_comment: !!perl/hash:RE_ast
  dba: pod_comment
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_meta
      text: ^^
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_meta
        min: 1
        text: \h
      quant:
      - '*'
    - !!perl/hash:RE_string
      i: 0
      text: =
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_method
        name: unsp
        rest: ''
      quant:
      - '?'
    - !!perl/hash:RE_bracket
      re: &31 !!perl/hash:RE_any
        altname: pod_comment_0
        dba: pod_comment
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_sequence
          alt: pod_comment_0 0
          zyg:
          - !!perl/hash:RE_string
            i: 0
            text: begin
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_meta
              min: 1
              text: \h
            quant:
            - +
          - !!perl/hash:RE_method
            name: identifier
            rest: ''
          - !!perl/hash:RE_meta
            text: '::'
          - !!perl/hash:RE_bracket
            re: !!perl/hash:RE_first
              zyg:
              - !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_meta
                  text: .*?
                - !!perl/hash:RE_double
                  i: 0
                  text: '

'
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_meta
                    min: 1
                    text: \h
                  quant:
                  - '*'
                - !!perl/hash:RE_string
                  i: 0
                  text: =
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_method
                    name: unsp
                    rest: ''
                  quant:
                  - '?'
                - !!perl/hash:RE_string
                  i: 0
                  text: end
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_meta
                    min: 1
                    text: \h
                  quant:
                  - +
                - !!perl/hash:RE_var
                  var: $M->{'identifier'}
                - !!perl/hash:RE_meta
                  text: »
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_meta
                    min: 1
                    text: \N
                  quant:
                  - '*'
              - !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_assertion
                  assert: '?'
                  re: !!perl/hash:RE_block
                    nobind: 1
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_meta
                    min: 1
                    text: .
                  quant:
                  - '*'
              - !!perl/hash:RE_block {}
        - !!perl/hash:RE_sequence
          alt: pod_comment_0 1
          zyg:
          - !!perl/hash:RE_string
            i: 0
            text: begin
          - !!perl/hash:RE_meta
            text: »
          - !!perl/hash:RE_meta
            text: '::'
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_meta
              min: 1
              text: \h
            quant:
            - '*'
          - !!perl/hash:RE_bracket
            re: !!perl/hash:RE_first
              zyg:
              - !!perl/hash:RE_meta
                text: $$
              - !!perl/hash:RE_string
                i: 0
                text: '#'
              - !!perl/hash:RE_method
                name: panic
                rest: 1
          - !!perl/hash:RE_bracket
            re: !!perl/hash:RE_first
              zyg:
              - !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_meta
                  text: .*?
                - !!perl/hash:RE_double
                  i: 0
                  text: '

'
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_meta
                    min: 1
                    text: \h
                  quant:
                  - '*'
                - !!perl/hash:RE_string
                  i: 0
                  text: =
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_method
                    name: unsp
                    rest: ''
                  quant:
                  - '?'
                - !!perl/hash:RE_string
                  i: 0
                  text: end
                - !!perl/hash:RE_meta
                  text: »
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_meta
                    min: 1
                    text: \N
                  quant:
                  - '*'
              - !!perl/hash:RE_block {}
        - !!perl/hash:RE_sequence
          alt: pod_comment_0 2
          zyg:
          - !!perl/hash:RE_string
            i: 0
            text: for
          - !!perl/hash:RE_meta
            text: »
          - !!perl/hash:RE_meta
            text: '::'
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_meta
              min: 1
              text: \h
            quant:
            - '*'
          - !!perl/hash:RE_bracket
            re: !!perl/hash:RE_first
              zyg:
              - !!perl/hash:RE_method
                name: identifier
                rest: ''
              - !!perl/hash:RE_meta
                text: $$
              - !!perl/hash:RE_string
                i: 0
                text: '#'
              - !!perl/hash:RE_method
                name: panic
                rest: 1
          - !!perl/hash:RE_bracket
            re: !!perl/hash:RE_first
              zyg:
              - !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_meta
                  text: .*?
                - !!perl/hash:RE_meta
                  text: ^^
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_meta
                    min: 1
                    text: \h
                  quant:
                  - '*'
                - !!perl/hash:RE_meta
                  text: $$
              - !!perl/hash:RE_quantified_atom
                atom: !!perl/hash:RE_meta
                  min: 1
                  text: .
                quant:
                - '*'
        - !!perl/hash:RE_sequence
          alt: pod_comment_0 3
          zyg:
          - !!perl/hash:RE_meta
            text: '::'
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_bracket
              re: !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_assertion
                  assert: '?'
                  re: !!perl/hash:RE_method_re
                    name: before
                    nobind: 1
                    re: !!perl/hash:RE_sequence
                      zyg:
                      - !!perl/hash:RE_meta
                        text: .*?
                      - !!perl/hash:RE_meta
                        text: ^^
                      - !!perl/hash:RE_string
                        i: 0
                        text: =cut
                      - !!perl/hash:RE_meta
                        text: »
                - !!perl/hash:RE_method
                  name: panic
                  rest: 1
            quant:
            - '?'
          - !!perl/hash:RE_bracket
            re: !!perl/hash:RE_first
              zyg:
              - !!perl/hash:RE_method
                name: alpha
                rest: ''
              - !!perl/hash:RE_meta
                min: 1
                text: \s
              - !!perl/hash:RE_method
                name: panic
                rest: 1
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_meta
              min: 1
              text: \N
            quant:
            - '*'
pod_comment_0: *31
postop: !!perl/hash:RE_ast
  dba: postop
  dic: STD::STD::P5
  re: &32 !!perl/hash:RE_any
    altname: postop_0
    dba: postop
    dic: STD::STD::P5
    zyg:
    - !!perl/hash:RE_sequence
      alt: postop_0 0
      zyg:
      - !!perl/hash:RE_bindnamed
        atom: !!perl/hash:RE_method
          name: p5postfix
          rest: ''
      - !!perl/hash:RE_block {}
    - !!perl/hash:RE_sequence
      alt: postop_0 1
      zyg:
      - !!perl/hash:RE_bindnamed
        atom: !!perl/hash:RE_method
          name: p5postcircumfix
          rest: ''
      - !!perl/hash:RE_block {}
postop_0: *32
quasiquibble: !!perl/hash:RE_ast
  dba: quasiquibble
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: babble
      rest: 1
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_first
        zyg:
        - !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_block
              nobind: 1
          - !!perl/hash:RE_bracket
            re: !!perl/hash:RE_sequence
              zyg:
              - !!perl/hash:RE_decl {}
              - !!perl/hash:RE_method
                name: block
                rest: ''
        - !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_var
            var: $start
          - !!perl/hash:RE_bracket
            re: !!perl/hash:RE_sequence
              zyg:
              - !!perl/hash:RE_decl {}
              - !!perl/hash:RE_method
                name: statementlist
                rest: ''
          - !!perl/hash:RE_bracket
            re: !!perl/hash:RE_first
              zyg:
              - !!perl/hash:RE_var
                var: $stop
              - !!perl/hash:RE_method
                name: panic
                rest: 1
quibble: !!perl/hash:RE_ast
  dba: quibble
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: babble
      rest: 1
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_var
      var: $start
    - !!perl/hash:RE_method
      name: nibble
      rest: 1
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_first
        zyg:
        - !!perl/hash:RE_var
          var: $stop
        - !!perl/hash:RE_method
          name: panic
          rest: 1
    - !!perl/hash:RE_block {}
quote__S_122qq: !!perl/hash:RE_ast
  dba: quote
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: qq
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_sequence
        zyg:
        - !!perl/hash:RE_meta
          text: »
        - !!perl/hash:RE_method
          name: ws
          rest: ''
        - !!perl/hash:RE_method
          name: quibble
          rest: 1
quote__S_123q: !!perl/hash:RE_ast
  dba: quote
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: q
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_sequence
        zyg:
        - !!perl/hash:RE_meta
          text: »
        - !!perl/hash:RE_method
          name: ws
          rest: ''
        - !!perl/hash:RE_method
          name: quibble
          rest: 1
quote__S_124qr: !!perl/hash:RE_ast
  dba: quote
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: qr
    - !!perl/hash:RE_meta
      text: »
    - !!perl/hash:RE_assertion
      assert: '!'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_string
          i: 0
          text: (
    - !!perl/hash:RE_method
      name: quibble
      rest: 1
    - !!perl/hash:RE_method
      name: p5rx_mods
      rest: ''
quote__S_125m: !!perl/hash:RE_ast
  dba: quote
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: m
    - !!perl/hash:RE_meta
      text: »
    - !!perl/hash:RE_assertion
      assert: '!'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_string
          i: 0
          text: (
    - !!perl/hash:RE_method
      name: quibble
      rest: 1
    - !!perl/hash:RE_method
      name: p5rx_mods
      rest: ''
quote__S_126s: !!perl/hash:RE_ast
  dba: quote
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: s
    - !!perl/hash:RE_meta
      text: »
    - !!perl/hash:RE_assertion
      assert: '!'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_string
          i: 0
          text: (
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: sibble
        rest: 1
    - !!perl/hash:RE_method
      name: p5rx_mods
      rest: ''
quote__S_127tr: !!perl/hash:RE_ast
  dba: quote
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: tr
    - !!perl/hash:RE_meta
      text: »
    - !!perl/hash:RE_assertion
      assert: '!'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_string
          i: 0
          text: (
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: tribble
        rest: 1
    - !!perl/hash:RE_method
      name: p5tr_mods
      rest: ''
radint: !!perl/hash:RE_ast
  dba: radint
  dic: STD::STD::P5
  re: !!perl/hash:RE_bracket
    re: &33 !!perl/hash:RE_any
      altname: radint_0
      dba: radint
      dic: STD::STD::P5
      zyg:
      - !!perl/hash:RE_method
        alt: radint_0 0
        name: integer
        rest: ''
      - !!perl/hash:RE_sequence
        alt: radint_0 1
        zyg:
        - !!perl/hash:RE_assertion
          assert: '?'
          re: !!perl/hash:RE_method_re
            name: before
            nobind: 1
            re: !!perl/hash:RE_string
              i: 0
              text: ':'
        - !!perl/hash:RE_method
          name: rad_number
          rest: ''
        - !!perl/hash:RE_assertion
          assert: '?'
          re: !!perl/hash:RE_block
            nobind: 1
radint_0: *33
regex_block: !!perl/hash:RE_ast
  dba: regex_block
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_method
            name: quotepair
            rest: ''
          - !!perl/hash:RE_method
            name: ws
            rest: ''
          - !!perl/hash:RE_block {}
      quant:
      - '*'
    - !!perl/hash:RE_string
      i: 0
      text: '{'
    - !!perl/hash:RE_method
      name: nibble
      rest: 1
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_first
        zyg:
        - !!perl/hash:RE_string
          i: 0
          text: '}'
        - !!perl/hash:RE_method
          name: panic
          rest: 1
    - !!perl/hash:RE_bracket
      re: &34 !!perl/hash:RE_any
        altname: regex_block_0
        dba: regex_block
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_sequence
          alt: regex_block_0 0
          zyg:
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_method_re
              name: before
              nobind: 1
              re: !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_meta
                    min: 1
                    text: \h
                  quant:
                  - '*'
                - !!perl/hash:RE_meta
                  text: $$
          - !!perl/hash:RE_block {}
        - !!perl/hash:RE_sequence
          alt: regex_block_0 1
          zyg:
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_meta
              min: 1
              text: \h
            quant:
            - '*'
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_method_re
              name: before
              nobind: 1
              re: !!perl/hash:RE_cclass
                i: 0
                text: '[\\,:]'
        - !!perl/hash:RE_sequence
          alt: regex_block_0 2
          zyg:
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_method
              name: unv
              rest: ''
            quant:
            - '?'
          - !!perl/hash:RE_meta
            text: $$
          - !!perl/hash:RE_block {}
        - !!perl/hash:RE_sequence
          alt: regex_block_0 3
          zyg:
          - !!perl/hash:RE_block {}
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_method
              name: unsp
              rest: ''
            quant:
            - '?'
          - !!perl/hash:RE_block {}
regex_block_0: *34
routine_def: !!perl/hash:RE_ast
  dba: routine_def
  dic: STD::STD::P5
  re: !!perl/hash:RE_first
    zyg:
    - !!perl/hash:RE_sequence
      zyg:
      - !!perl/hash:RE_method
        name: ws
        rest: ''
      - !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_bracket
              re: &35 !!perl/hash:RE_any
                altname: routine_def_0
                dba: routine_def
                dic: STD::STD::P5
                zyg:
                - !!perl/hash:RE_sequence
                  alt: routine_def_0 0
                  zyg:
                  - !!perl/hash:RE_method
                    name: ws
                    rest: ''
                  - !!perl/hash:RE_string
                    i: 0
                    text: '&'
                  - !!perl/hash:RE_quantified_atom
                    atom: !!perl/hash:RE_method
                      name: deflongname
                      rest: ''
                    quant:
                    - '?'
                  - !!perl/hash:RE_method
                    name: ws
                    rest: ''
                - !!perl/hash:RE_sequence
                  alt: routine_def_0 1
                  zyg:
                  - !!perl/hash:RE_method
                    name: ws
                    rest: ''
                  - !!perl/hash:RE_method
                    name: deflongname
                    rest: ''
                  - !!perl/hash:RE_method
                    name: ws
                    rest: ''
            quant:
            - '?'
          - !!perl/hash:RE_method
            name: ws
            rest: ''
          - !!perl/hash:RE_method
            name: newlex
            rest: 1
          - !!perl/hash:RE_method
            name: ws
            rest: ''
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_method
              name: parensig
              rest: ''
            quant:
            - '?'
          - !!perl/hash:RE_method
            name: ws
            rest: ''
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_method
              name: trait
              rest: ''
            quant:
            - '*'
          - !!perl/hash:RE_method
            name: ws
            rest: ''
          - !!perl/hash:RE_assertion
            assert: '!'
            re: !!perl/hash:RE_block
              nobind: 1
          - !!perl/hash:RE_method
            name: blockoid
            rest: ''
          - !!perl/hash:RE_method
            name: checkyada
            rest: ''
          - !!perl/hash:RE_method
            name: getsig
            rest: ''
      - !!perl/hash:RE_method
        name: ws
        rest: ''
    - !!perl/hash:RE_sequence
      zyg:
      - !!perl/hash:RE_method
        name: ws
        rest: ''
      - !!perl/hash:RE_method
        name: panic
        rest: 1
      - !!perl/hash:RE_method
        name: ws
        rest: ''
routine_def_0: *35
scoped: !!perl/hash:RE_ast
  dba: scoped declarator
  dic: STD::STD::P5
  re: !!perl/hash:RE_first
    zyg:
    - !!perl/hash:RE_sequence
      zyg:
      - !!perl/hash:RE_method
        name: ws
        rest: ''
      - !!perl/hash:RE_bracket
        re: &36 !!perl/hash:RE_any
          altname: scoped_0
          dba: scoped declarator
          dic: STD::STD::P5
          zyg:
          - !!perl/hash:RE_sequence
            alt: scoped_0 0
            zyg:
            - !!perl/hash:RE_method
              name: declarator
              rest: ''
            - !!perl/hash:RE_method
              name: ws
              rest: ''
          - !!perl/hash:RE_sequence
            alt: scoped_0 1
            zyg:
            - !!perl/hash:RE_bindnamed
              atom: !!perl/hash:RE_method
                name: p5regex_declarator
                rest: ''
            - !!perl/hash:RE_method
              name: ws
              rest: ''
          - !!perl/hash:RE_sequence
            alt: scoped_0 2
            zyg:
            - !!perl/hash:RE_bindnamed
              atom: !!perl/hash:RE_method
                name: p5package_declarator
                rest: ''
            - !!perl/hash:RE_method
              name: ws
              rest: ''
    - !!perl/hash:RE_sequence
      zyg:
      - !!perl/hash:RE_method
        name: ws
        rest: ''
      - !!perl/hash:RE_assertion
        assert: '?'
        re: !!perl/hash:RE_method_re
          name: before
          nobind: 1
          re: !!perl/hash:RE_sequence
            zyg:
            - !!perl/hash:RE_method
              name: ws
              rest: ''
            - !!perl/hash:RE_cclass
              i: 0
              text: '[A..Z]'
      - !!perl/hash:RE_method
        name: longname
        rest: ''
      - !!perl/hash:RE_block {}
      - !!perl/hash:RE_method
        name: ws
        rest: ''
      - !!perl/hash:RE_assertion
        assert: '!'
        re: !!perl/hash:RE_noop
          nobind: 1
    - !!perl/hash:RE_sequence
      zyg:
      - !!perl/hash:RE_method
        name: ws
        rest: ''
      - !!perl/hash:RE_method
        name: panic
        rest: 1
      - !!perl/hash:RE_method
        name: ws
        rest: ''
scoped_0: *36
semiarglist: !!perl/hash:RE_ast
  dba: semiarglist
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_method
        name: arglist
        rest: ''
      quant:
      - '**'
      - ':'
      - !!perl/hash:RE_string
        a: 0
        dba: semiarglist
        dic: STD::STD::P5
        i: 0
        i_needed: 1
        r: 1
        s: 0
        text: ;
    - !!perl/hash:RE_method
      name: ws
      rest: ''
semilist: !!perl/hash:RE_ast
  dba: semicolon list
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_bracket
      re: &37 !!perl/hash:RE_any
        altname: semilist_0
        dba: semicolon list
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_assertion
          alt: semilist_0 0
          assert: '?'
          re: !!perl/hash:RE_method_re
            name: before
            nobind: 1
            re: !!perl/hash:RE_sequence
              zyg:
              - !!perl/hash:RE_method
                name: ws
                rest: ''
              - !!perl/hash:RE_cclass
                i: 0
                text: '[\)\]\}]'
              - !!perl/hash:RE_method
                name: ws
                rest: ''
        - !!perl/hash:RE_sequence
          alt: semilist_0 1
          zyg:
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_bracket
              re: !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_method
                  name: statement
                  rest: ''
                - !!perl/hash:RE_method
                  name: eat_terminator
                  rest: ''
                - !!perl/hash:RE_method
                  name: ws
                  rest: ''
            quant:
            - '*'
          - !!perl/hash:RE_method
            name: ws
            rest: ''
semilist_0: *37
sibble: !!perl/hash:RE_ast
  dba: sibble
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: babble
      rest: 1
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_var
      var: $start
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: nibble
        rest: 1
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_first
        zyg:
        - !!perl/hash:RE_var
          var: $stop
        - !!perl/hash:RE_method
          name: panic
          rest: 1
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_first
        zyg:
        - !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_block
              nobind: 1
          - !!perl/hash:RE_method
            name: ws
            rest: ''
          - !!perl/hash:RE_method
            name: quibble
            rest: 1
        - !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_block {}
          - !!perl/hash:RE_bindnamed
            atom: !!perl/hash:RE_method
              name: nibble
              rest: 1
          - !!perl/hash:RE_var
            var: $stop
signature: !!perl/hash:RE_ast
  dba: signature
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: &38 !!perl/hash:RE_any
          altname: signature_0
          dba: signature
          dic: STD::STD::P5
          zyg:
          - !!perl/hash:RE_assertion
            alt: signature_0 0
            assert: '?'
            re: !!perl/hash:RE_method_re
              name: before
              nobind: 1
              re: &39 !!perl/hash:RE_any
                altname: signature_1
                dba: signature
                dic: STD::STD::P5
                zyg:
                - !!perl/hash:RE_string
                  alt: signature_1 0
                  i: 0
                  text: -->
                - !!perl/hash:RE_string
                  alt: signature_1 1
                  i: 0
                  text: )
                - !!perl/hash:RE_string
                  alt: signature_1 2
                  i: 0
                  text: ']'
                - !!perl/hash:RE_string
                  alt: signature_1 3
                  i: 0
                  text: '{'
                - !!perl/hash:RE_sequence
                  alt: signature_1 4
                  zyg:
                  - !!perl/hash:RE_string
                    i: 0
                    text: ':'
                  - !!perl/hash:RE_meta
                    min: 1
                    text: \s
          - !!perl/hash:RE_bracket
            alt: signature_0 1
            re: !!perl/hash:RE_first
              zyg:
              - !!perl/hash:RE_method
                name: parameter
                rest: ''
              - !!perl/hash:RE_method
                name: panic
                rest: 1
      quant:
      - '**'
      - ':'
      - !!perl/hash:RE_method
        a: 0
        dba: signature
        dic: STD::STD::P5
        i: 0
        name: param_sep
        need_match: 0
        r: 1
        rest: ~
        s: 0
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_string
            i: 0
            text: -->
          - !!perl/hash:RE_method
            name: ws
            rest: ''
          - !!perl/hash:RE_method
            name: typename
            rest: ''
      quant:
      - '?'
    - !!perl/hash:RE_block {}
signature_0: *38
signature_1: *39
spacey: !!perl/hash:RE_ast
  dba: spacey
  dic: STD::STD::P5
  re: !!perl/hash:RE_assertion
    assert: '?'
    re: !!perl/hash:RE_method_re
      name: before
      nobind: 1
      re: !!perl/hash:RE_cclass
        i: 0
        text: '[ \s \# ]'
starter: !!perl/hash:RE_ast
  dba: starter
  dic: STD::STD::P5
  re: !!perl/hash:RE_assertion
    assert: '!'
    re: !!perl/hash:RE_noop
      nobind: 1
statement: !!perl/hash:RE_ast
  dba: statement
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_assertion
      assert: '!'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_cclass
          i: 0
          text: '[\)\]\}]'
    - !!perl/hash:RE_assertion
      assert: '!'
      re: !!perl/hash:RE_assertion
        assert: '!'
        nobind: 1
        re: !!perl/hash:RE_block
          nobind: 1
    - !!perl/hash:RE_bracket
      re: &40 !!perl/hash:RE_any
        altname: statement_0
        dba: statement modifier
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_sequence
          alt: statement_0 0
          zyg:
          - !!perl/hash:RE_method
            name: label
            rest: ''
          - !!perl/hash:RE_method
            name: statement
            rest: ''
        - !!perl/hash:RE_bindnamed
          alt: statement_0 1
          atom: !!perl/hash:RE_method
            name: p5statement_control
            rest: ''
        - !!perl/hash:RE_sequence
          alt: statement_0 2
          zyg:
          - !!perl/hash:RE_method
            name: EXPR
            rest: ''
          - !!perl/hash:RE_method
            name: ws
            rest: ''
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_bracket
              re: &41 !!perl/hash:RE_any
                altname: statement_1
                dba: statement modifier
                dic: STD::STD::P5
                zyg:
                - !!perl/hash:RE_bindnamed
                  alt: statement_1 0
                  atom: !!perl/hash:RE_method
                    name: p5statement_mod_loop
                    rest: ''
                - !!perl/hash:RE_bindnamed
                  alt: statement_1 1
                  atom: !!perl/hash:RE_method
                    name: p5statement_mod_cond
                    rest: ''
            quant:
            - '?'
        - !!perl/hash:RE_assertion
          alt: statement_0 3
          assert: '?'
          re: !!perl/hash:RE_method_re
            name: before
            nobind: 1
            re: !!perl/hash:RE_string
              i: 0
              text: ;
statement_0: *40
statement_1: *41
statementlist: !!perl/hash:RE_ast
  dba: statement list
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_bracket
      re: &42 !!perl/hash:RE_any
        altname: statementlist_0
        dba: statement list
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_sequence
          alt: statementlist_0 0
          zyg:
          - !!perl/hash:RE_meta
            text: $
          - !!perl/hash:RE_method
            name: ws
            rest: ''
        - !!perl/hash:RE_assertion
          alt: statementlist_0 1
          assert: '?'
          re: !!perl/hash:RE_method_re
            name: before
            nobind: 1
            re: !!perl/hash:RE_sequence
              zyg:
              - !!perl/hash:RE_method
                name: ws
                rest: ''
              - !!perl/hash:RE_cclass
                i: 0
                text: '[\)\]\}]'
              - !!perl/hash:RE_method
                name: ws
                rest: ''
        - !!perl/hash:RE_sequence
          alt: statementlist_0 2
          zyg:
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_bracket
              re: !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_method
                  name: statement
                  rest: ''
                - !!perl/hash:RE_method
                  name: eat_terminator
                  rest: ''
                - !!perl/hash:RE_method
                  name: ws
                  rest: ''
            quant:
            - '*'
          - !!perl/hash:RE_method
            name: ws
            rest: ''
statementlist_0: *42
stdstopper: !!perl/hash:RE_ast
  dba: standard stopper
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bracket
      re: &43 !!perl/hash:RE_any
        altname: stdstopper_0
        dba: standard stopper
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_assertion
          alt: stdstopper_0 0
          assert: '?'
          re: !!perl/hash:RE_method
            name: terminator
            rest: ''
        - !!perl/hash:RE_assertion
          alt: stdstopper_0 1
          assert: '?'
          re: !!perl/hash:RE_method
            name: unitstopper
            rest: ''
        - !!perl/hash:RE_meta
          alt: stdstopper_0 2
          text: $
    - !!perl/hash:RE_block {}
stdstopper_0: *43
stopper: !!perl/hash:RE_ast
  dba: stopper
  dic: STD::STD::P5
  re: !!perl/hash:RE_assertion
    assert: '!'
    re: !!perl/hash:RE_noop
      nobind: 1
sublongname: !!perl/hash:RE_ast
  dba: sublongname
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: subshortname
      rest: ''
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_method
        name: sigterm
        rest: ''
      quant:
      - '?'
subshortname: !!perl/hash:RE_ast
  dba: subshortname
  dic: STD::STD::P5
  re: !!perl/hash:RE_bracket
    re: &44 !!perl/hash:RE_any
      altname: subshortname_0
      dba: subshortname
      dic: STD::STD::P5
      zyg:
      - !!perl/hash:RE_sequence
        alt: subshortname_0 0
        zyg:
        - !!perl/hash:RE_method
          name: category
          rest: ''
        - !!perl/hash:RE_quantified_atom
          atom: !!perl/hash:RE_bracket
            re: !!perl/hash:RE_sequence
              zyg:
              - !!perl/hash:RE_quantified_atom
                atom: !!perl/hash:RE_method
                  name: colonpair
                  rest: ''
                quant:
                - +
              - !!perl/hash:RE_block {}
          quant:
          - '?'
      - !!perl/hash:RE_method
        alt: subshortname_0 1
        name: desigilname
        rest: ''
subshortname_0: *44
termish: !!perl/hash:RE_ast
  dba: postfix
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bracket
      re: &45 !!perl/hash:RE_any
        altname: termish_0
        dba: prefix or term
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_sequence
          alt: termish_0 0
          zyg:
          - !!perl/hash:RE_method
            name: PRE
            rest: ''
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_bracket
              re: !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_assertion
                  assert: '!'
                  re: !!perl/hash:RE_block
                    nobind: 1
                - !!perl/hash:RE_method
                  name: PRE
                  rest: ''
            quant:
            - '*'
          - !!perl/hash:RE_bracket
            re: !!perl/hash:RE_first
              zyg:
              - !!perl/hash:RE_assertion
                assert: '?'
                re: !!perl/hash:RE_block
                  nobind: 1
              - !!perl/hash:RE_method
                name: term
                rest: ''
        - !!perl/hash:RE_bindnamed
          alt: termish_0 1
          atom: !!perl/hash:RE_method
            name: p5term
            rest: ''
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_first
        zyg:
        - !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_block
              nobind: 1
          - !!perl/hash:RE_bracket
            re: !!perl/hash:RE_first
              zyg:
              - !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_assertion
                  assert: '?'
                  re: !!perl/hash:RE_block
                    nobind: 1
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_bracket
                    re: !!perl/hash:RE_sequence
                      zyg:
                      - !!perl/hash:RE_quantified_atom
                        atom: !!perl/hash:RE_method
                          name: POST
                          rest: ''
                        quant:
                        - +
                      - !!perl/hash:RE_assertion
                        assert: '?'
                        re: !!perl/hash:RE_method_re
                          name: after
                          nobind: 1
                          re: !!perl/hash:RE_cclass
                            i: 0
                            text: '[ \] } > ) ]'
                  quant:
                  - '?'
              - !!perl/hash:RE_sequence
                zyg:
                - !!perl/hash:RE_quantified_atom
                  atom: !!perl/hash:RE_method
                    name: POST
                    rest: ''
                  quant:
                  - +
                - !!perl/hash:RE_assertion
                  assert: '?'
                  re: !!perl/hash:RE_method_re
                    name: after
                    nobind: 1
                    re: !!perl/hash:RE_cclass
                      i: 0
                      text: '[ \] } > ) ]'
              - !!perl/hash:RE_block {}
        - !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_assertion
            assert: '!'
            re: !!perl/hash:RE_block
              nobind: 1
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_method
              name: POST
              rest: ''
            quant:
            - '*'
    - !!perl/hash:RE_block {}
termish_0: *45
trait: !!perl/hash:RE_ast
  dba: trait
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_string
      i: 0
      text: ':'
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: EXPR
      rest: 1
    - !!perl/hash:RE_method
      name: ws
      rest: ''
tribble: !!perl/hash:RE_ast
  dba: tribble
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: babble
      rest: 1
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_var
      var: $start
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: nibble
        rest: 1
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_first
        zyg:
        - !!perl/hash:RE_var
          var: $stop
        - !!perl/hash:RE_method
          name: panic
          rest: 1
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_first
        zyg:
        - !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_block
              nobind: 1
          - !!perl/hash:RE_method
            name: ws
            rest: ''
          - !!perl/hash:RE_method
            name: quibble
            rest: 1
        - !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_block {}
          - !!perl/hash:RE_bindnamed
            atom: !!perl/hash:RE_method
              name: nibble
              rest: 1
          - !!perl/hash:RE_var
            var: $stop
type_constraint: !!perl/hash:RE_ast
  dba: type_constraint
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: typename
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
typename: !!perl/hash:RE_ast
  dba: typename
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bracket
      re: &46 !!perl/hash:RE_any
        altname: typename_0
        dba: typename
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_sequence
          alt: typename_0 0
          zyg:
          - !!perl/hash:RE_string
            i: 0
            text: ::?
          - !!perl/hash:RE_method
            name: identifier
            rest: ''
        - !!perl/hash:RE_sequence
          alt: typename_0 1
          zyg:
          - !!perl/hash:RE_method
            name: longname
            rest: ''
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_block
              nobind: 1
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_method
        name: unsp
        rest: ''
      quant:
      - '?'
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_method_re
              name: before
              nobind: 1
              re: !!perl/hash:RE_string
                i: 0
                text: '['
          - !!perl/hash:RE_bindnamed
            atom: !!perl/hash:RE_method
              name: p5postcircumfix
              rest: ''
      quant:
      - '?'
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_string
            i: 0
            text: of
          - !!perl/hash:RE_method
            name: ws
            rest: ''
          - !!perl/hash:RE_method
            name: typename
            rest: ''
      quant:
      - '?'
typename_0: *46
unitstopper: !!perl/hash:RE_ast
  dba: unitstopper
  dic: STD::STD::P5
  re: !!perl/hash:RE_meta
    text: $
unsp: !!perl/hash:RE_ast
  dba: unsp
  dic: STD::STD::P5
  re: !!perl/hash:RE_assertion
    assert: '!'
    re: !!perl/hash:RE_noop
      nobind: 1
unspacey: !!perl/hash:RE_ast
  dba: unspacey
  dic: STD::STD::P5
  re: !!perl/hash:RE_quantified_atom
    atom: !!perl/hash:RE_method
      name: unsp
      rest: ''
    quant:
    - '?'
unv: !!perl/hash:RE_ast
  dba: horizontal whitespace
  dic: STD::STD::P5
  re: !!perl/hash:RE_bracket
    re: &47 !!perl/hash:RE_any
      altname: unv_0
      dba: horizontal whitespace
      dic: STD::STD::P5
      zyg:
      - !!perl/hash:RE_quantified_atom
        alt: unv_0 0
        atom: !!perl/hash:RE_meta
          min: 1
          text: \h
        quant:
        - +
      - !!perl/hash:RE_sequence
        alt: unv_0 1
        zyg:
        - !!perl/hash:RE_assertion
          assert: '?'
          re: !!perl/hash:RE_method_re
            name: before
            nobind: 1
            re: !!perl/hash:RE_sequence
              zyg:
              - !!perl/hash:RE_quantified_atom
                atom: !!perl/hash:RE_meta
                  min: 1
                  text: \h
                quant:
                - '*'
              - !!perl/hash:RE_string
                i: 0
                text: =
              - !!perl/hash:RE_bracket
                re: &48 !!perl/hash:RE_any
                  altname: unv_1
                  dba: horizontal whitespace
                  dic: STD::STD::P5
                  zyg:
                  - !!perl/hash:RE_meta
                    alt: unv_1 0
                    min: 1
                    text: \w
                  - !!perl/hash:RE_string
                    alt: unv_1 1
                    i: 0
                    text: \
        - !!perl/hash:RE_meta
          text: ^^
        - !!perl/hash:RE_method
          name: pod_comment
          rest: ''
      - !!perl/hash:RE_sequence
        alt: unv_0 2
        zyg:
        - !!perl/hash:RE_quantified_atom
          atom: !!perl/hash:RE_meta
            min: 1
            text: \h
          quant:
          - '*'
        - !!perl/hash:RE_bindnamed
          atom: !!perl/hash:RE_method
            name: p5comment
            rest: ''
unv_0: *47
unv_1: *48
variable: !!perl/hash:RE_ast
  dba: variable
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_bindnamed
            atom: !!perl/hash:RE_method
              name: p5sigil
              rest: ''
          - !!perl/hash:RE_block {}
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_first
        zyg:
        - !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_string
            i: 0
            text: '&'
          - !!perl/hash:RE_bracket
            re: &49 !!perl/hash:RE_any
              altname: variable_0
              dba: infix noun
              dic: STD::STD::P5
              zyg:
              - !!perl/hash:RE_sequence
                alt: variable_0 0
                zyg:
                - !!perl/hash:RE_method
                  name: sublongname
                  rest: ''
                - !!perl/hash:RE_block {}
              - !!perl/hash:RE_bracket
                alt: variable_0 1
                re: !!perl/hash:RE_sequence
                  zyg:
                  - !!perl/hash:RE_string
                    i: 0
                    text: '['
                  - !!perl/hash:RE_block {}
                  - !!perl/hash:RE_method
                    name: infixish
                    rest: 1
                  - !!perl/hash:RE_bracket
                    re: !!perl/hash:RE_first
                      zyg:
                      - !!perl/hash:RE_string
                        i: 0
                        text: ']'
                      - !!perl/hash:RE_method
                        name: FAILGOAL
                        rest: 1
        - !!perl/hash:RE_bracket
          re: &50 !!perl/hash:RE_any
            altname: variable_1
            dba: variable
            dic: STD::STD::P5
            zyg:
            - !!perl/hash:RE_sequence
              alt: variable_1 0
              zyg:
              - !!perl/hash:RE_bindnamed
                atom: !!perl/hash:RE_method
                  name: p5sigil
                  rest: ''
              - !!perl/hash:RE_method
                name: desigilname
                rest: ''
              - !!perl/hash:RE_block {}
            - !!perl/hash:RE_bindnamed
              alt: variable_1 1
              atom: !!perl/hash:RE_method
                name: p5special_variable
                rest: ''
            - !!perl/hash:RE_sequence
              alt: variable_1 2
              zyg:
              - !!perl/hash:RE_bindnamed
                atom: !!perl/hash:RE_method
                  name: p5sigil
                  rest: ''
              - !!perl/hash:RE_bindnamed
                atom: !!perl/hash:RE_bracket
                  re: !!perl/hash:RE_quantified_atom
                    atom: !!perl/hash:RE_meta
                      min: 1
                      text: \d
                    quant:
                    - +
            - !!perl/hash:RE_sequence
              alt: variable_1 3
              zyg:
              - !!perl/hash:RE_bindnamed
                atom: !!perl/hash:RE_method
                  name: p5sigil
                  rest: ''
              - !!perl/hash:RE_assertion
                assert: '?'
                re: !!perl/hash:RE_method_re
                  name: before
                  nobind: 1
                  re: &51 !!perl/hash:RE_any
                    altname: variable_2
                    dba: variable
                    dic: STD::STD::P5
                    zyg:
                    - !!perl/hash:RE_string
                      alt: variable_2 0
                      i: 0
                      text: <
                    - !!perl/hash:RE_string
                      alt: variable_2 1
                      i: 0
                      text: (
              - !!perl/hash:RE_bindnamed
                atom: !!perl/hash:RE_method
                  name: p5postcircumfix
                  rest: ''
            - !!perl/hash:RE_sequence
              alt: variable_1 4
              zyg:
              - !!perl/hash:RE_bindnamed
                atom: !!perl/hash:RE_method
                  name: p5sigil
                  rest: ''
              - !!perl/hash:RE_assertion
                assert: '?'
                re: !!perl/hash:RE_block
                  nobind: 1
            - !!perl/hash:RE_sequence
              alt: variable_1 5
              zyg:
              - !!perl/hash:RE_assertion
                assert: '?'
                re: !!perl/hash:RE_noop
                  nobind: 1
              - !!perl/hash:RE_block {}
variable_0: *49
variable_1: *50
variable_2: *51
variable_declarator: !!perl/hash:RE_ast
  dba: variable_declarator
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: variable
      rest: ''
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_method
              name: unsp
              rest: ''
            quant:
            - '?'
          - !!perl/hash:RE_bindnamed
            atom: !!perl/hash:RE_quantified_atom
              atom: !!perl/hash:RE_bracket
                re: &52 !!perl/hash:RE_any
                  altname: variable_declarator_0
                  dba: shape definition
                  dic: STD::STD::P5
                  zyg:
                  - !!perl/hash:RE_bracket
                    alt: variable_declarator_0 0
                    re: !!perl/hash:RE_sequence
                      zyg:
                      - !!perl/hash:RE_string
                        i: 0
                        text: (
                      - !!perl/hash:RE_block {}
                      - !!perl/hash:RE_method
                        name: signature
                        rest: ''
                      - !!perl/hash:RE_bracket
                        re: !!perl/hash:RE_first
                          zyg:
                          - !!perl/hash:RE_string
                            i: 0
                            text: )
                          - !!perl/hash:RE_method
                            name: FAILGOAL
                            rest: 1
                  - !!perl/hash:RE_bracket
                    alt: variable_declarator_0 1
                    re: !!perl/hash:RE_sequence
                      zyg:
                      - !!perl/hash:RE_string
                        i: 0
                        text: '['
                      - !!perl/hash:RE_block {}
                      - !!perl/hash:RE_method
                        name: semilist
                        rest: ''
                      - !!perl/hash:RE_bracket
                        re: !!perl/hash:RE_first
                          zyg:
                          - !!perl/hash:RE_string
                            i: 0
                            text: ']'
                          - !!perl/hash:RE_method
                            name: FAILGOAL
                            rest: 1
                  - !!perl/hash:RE_bracket
                    alt: variable_declarator_0 2
                    re: !!perl/hash:RE_sequence
                      zyg:
                      - !!perl/hash:RE_string
                        i: 0
                        text: '{'
                      - !!perl/hash:RE_block {}
                      - !!perl/hash:RE_method
                        name: semilist
                        rest: ''
                      - !!perl/hash:RE_bracket
                        re: !!perl/hash:RE_first
                          zyg:
                          - !!perl/hash:RE_string
                            i: 0
                            text: '}'
                          - !!perl/hash:RE_method
                            name: FAILGOAL
                            rest: 1
                  - !!perl/hash:RE_sequence
                    alt: variable_declarator_0 3
                    zyg:
                    - !!perl/hash:RE_assertion
                      assert: '?'
                      re: !!perl/hash:RE_method_re
                        name: before
                        nobind: 1
                        re: !!perl/hash:RE_string
                          i: 0
                          text: <
                    - !!perl/hash:RE_bindnamed
                      atom: !!perl/hash:RE_method
                        name: p5postcircumfix
                        rest: ''
              quant:
              - '*'
      quant:
      - '?'
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_method
        name: trait
        rest: ''
      quant:
      - '*'
variable_declarator_0: *52
vnum: !!perl/hash:RE_ast
  dba: vnum
  dic: STD::STD::P5
  re: &53 !!perl/hash:RE_any
    altname: vnum_0
    dba: vnum
    dic: STD::STD::P5
    zyg:
    - !!perl/hash:RE_quantified_atom
      alt: vnum_0 0
      atom: !!perl/hash:RE_meta
        min: 1
        text: \d
      quant:
      - +
    - !!perl/hash:RE_string
      alt: vnum_0 1
      i: 0
      text: '*'
vnum_0: *53
vws: !!perl/hash:RE_ast
  dba: vertical whitespace
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_meta
      min: 1
      text: \v
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_string
            i: 0
            text: '#DEBUG -1'
          - !!perl/hash:RE_block {}
      quant:
      - '?'
ws: !!perl/hash:RE_ast
  dba: whitespace
  dic: STD::STD::P5
  re: !!perl/hash:RE_first
    zyg:
    - !!perl/hash:RE_bracket
      re: &54 !!perl/hash:RE_any
        altname: ws_0
        dba: whitespace
        dic: STD::STD::P5
        zyg:
        - !!perl/hash:RE_sequence
          alt: ws_0 0
          zyg:
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_meta
              min: 1
              text: \h
            quant:
            - +
          - !!perl/hash:RE_assertion
            assert: '!'
            re: !!perl/hash:RE_cclass
              i: 0
              nobind: 1
              text: '[\#\s\\]'
          - !!perl/hash:RE_block {}
        - !!perl/hash:RE_sequence
          alt: ws_0 1
          zyg:
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_method_re
              name: before
              nobind: 1
              re: !!perl/hash:RE_meta
                min: 1
                text: \w
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_method_re
              name: after
              nobind: 1
              re: !!perl/hash:RE_meta
                min: 1
                text: \w
          - !!perl/hash:RE_meta
            text: ':::'
          - !!perl/hash:RE_block {}
          - !!perl/hash:RE_method
            name: panic
            rest: 1
    - !!perl/hash:RE_sequence
      zyg:
      - !!perl/hash:RE_quantified_atom
        atom: !!perl/hash:RE_bracket
          re: &55 !!perl/hash:RE_any
            altname: ws_1
            dba: whitespace
            dic: STD::STD::P5
            zyg:
            - !!perl/hash:RE_method
              alt: ws_1 0
              name: unsp
              rest: ''
            - !!perl/hash:RE_sequence
              alt: ws_1 1
              zyg:
              - !!perl/hash:RE_method
                name: vws
                rest: ''
              - !!perl/hash:RE_method
                name: heredoc
                rest: ''
            - !!perl/hash:RE_method
              alt: ws_1 2
              name: unv
              rest: ''
            - !!perl/hash:RE_sequence
              alt: ws_1 3
              zyg:
              - !!perl/hash:RE_meta
                text: $
              - !!perl/hash:RE_block {}
        quant:
        - '*'
      - !!perl/hash:RE_block {}
ws_0: *54
ws_1: *55
xblock: !!perl/hash:RE_ast
  dba: block expression
  dic: STD::STD::P5
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_sequence
        zyg:
        - !!perl/hash:RE_string
          i: 0
          text: (
        - !!perl/hash:RE_block {}
        - !!perl/hash:RE_method
          name: EXPR
          rest: ''
        - !!perl/hash:RE_bracket
          re: !!perl/hash:RE_first
            zyg:
            - !!perl/hash:RE_string
              i: 0
              text: )
            - !!perl/hash:RE_method
              name: FAILGOAL
              rest: 1
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: block
      rest: ''
RETREE_END
;
use DEBUG;
## method TOP ($STOP?)
sub TOP {
no warnings 'recursion';
my $self = shift;
my $STOP = @_ ? shift() : undef;
if (defined $STOP) {
local $::GOAL = $STOP;
$self->unitstop($STOP)->comp_unit;
}
else {
$self->comp_unit}};
our %term            = ('dba' => ('term')            , 'prec' => 'z=');
our %methodcall      = ('dba' => ('methodcall')      , 'prec' => 'y=', 'assoc' => 'unary', 'uassoc' => 'left', 'fiddly' => 1);
our %autoincrement   = ('dba' => ('autoincrement')   , 'prec' => 'x=', 'assoc' => 'unary', 'uassoc' => 'non');
our %exponentiation  = ('dba' => ('exponentiation')  , 'prec' => 'w=', 'assoc' => 'right');
our %symbolic_unary  = ('dba' => ('symbolic unary')  , 'prec' => 'v=', 'assoc' => 'unary', 'uassoc' => 'left');
our %binding         = ('dba' => ('binding')         , 'prec' => 'u=', 'assoc' => 'unary', 'uassoc' => 'left');
our %multiplicative  = ('dba' => ('multiplicative')  , 'prec' => 't=', 'assoc' => 'left');
our %additive        = ('dba' => ('additive')        , 'prec' => 's=', 'assoc' => 'left');
our %shift           = ('dba' => ('shift')           , 'prec' => 'r=', 'assoc' => 'left');
our %named_unary     = ('dba' => ('named unary')     , 'prec' => 'q=', 'assoc' => 'unary', 'uassoc' => 'left');
our %comparison      = ('dba' => ('comparison')      , 'prec' => 'p=', 'assoc' => 'non', 'diffy' => 1);
our %equality        = ('dba' => ('equality')        , 'prec' => 'o=', 'assoc' => 'chain', 'diffy' => 1, 'iffy' => 1);
our %bitwise_and     = ('dba' => ('bitwise and')     , 'prec' => 'n=', 'assoc' => 'left');
our %bitwise_or      = ('dba' => ('bitwise or')      , 'prec' => 'm=', 'assoc' => 'left');
our %tight_and       = ('dba' => ('tight and')       , 'prec' => 'l=', 'assoc' => 'left');
our %tight_or        = ('dba' => ('tight or')        , 'prec' => 'k=', 'assoc' => 'left');
our %range           = ('dba' => ('range')           , 'prec' => 'j=', 'assoc' => 'right', 'fiddly' => 1);
our %conditional     = ('dba' => ('conditional')     , 'prec' => 'i=', 'assoc' => 'right', 'fiddly' => 1);
our %assignment      = ('dba' => ('assignment')      , 'prec' => 'h=', 'assoc' => 'right');
our %comma           = ('dba' => ('comma operator')  , 'prec' => 'g=', 'assoc' => 'left', 'nextterm' => 'nulltermish', 'fiddly' => 1);
our %listop          = ('dba' => ('list operator')   , 'prec' => 'f=', 'assoc' => 'unary', 'uassoc' => 'left');
our %loose_not       = ('dba' => ('not operator')    , 'prec' => 'e=', 'assoc' => 'unary', 'uassoc' => 'left');
our %loose_and       = ('dba' => ('loose and')       , 'prec' => 'd=', 'assoc' => 'left');
our %loose_or        = ('dba' => ('loose or')        , 'prec' => 'c=', 'assoc' => 'left');
our %LOOSEST         = ('dba' => ('LOOSEST')         , 'prec' => 'a=!');
our %terminator      = ('dba' => ('terminator')      , 'prec' => 'a=', 'assoc' => 'list');
our $LOOSEST = "a=!";
local $::endsym = "null";
local $::endargs = -1;
## token category { <...> }
sub category__PEEK { $_[0]->_AUTOLEXpeek('category:*',$retree); }
sub category {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE category');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'category') {
$C->deb("Fate passed to category: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT category';
}
else {
$x = 'ALTLTM category';
}
}
else {
$x = 'ALTLTM category';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'category:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("category trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "category", @gather);
};
@result;
}
;
## token category:category { <sym> }
sub category__S_000category__PEEK { $_[0]->_AUTOLEXpeek('category__S_000category', $retree) }
sub category__S_000category {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_000category");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "category";
$self->_MATCHIFYr($S, "category__S_000category", $C->_EXACT("category"));
}
;
## token category:p5sigil { <sym> }
sub category__S_001p5sigil__PEEK { $_[0]->_AUTOLEXpeek('category__S_001p5sigil', $retree) }
sub category__S_001p5sigil {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_001p5sigil");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5sigil";
$self->_MATCHIFYr($S, "category__S_001p5sigil", $C->_EXACT("p5sigil"));
}
;
## token p5sigil { <...> }
sub p5sigil__PEEK { $_[0]->_AUTOLEXpeek('p5sigil:*',$retree); }
sub p5sigil {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5sigil');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5sigil') {
$C->deb("Fate passed to p5sigil: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5sigil';
}
else {
$x = 'ALTLTM p5sigil';
}
}
else {
$x = 'ALTLTM p5sigil';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5sigil:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5sigil trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5sigil", @gather);
};
@result;
}
;
## token category:p5special_variable { <sym> }
sub category__S_002p5special_variable__PEEK { $_[0]->_AUTOLEXpeek('category__S_002p5special_variable', $retree) }
sub category__S_002p5special_variable {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_002p5special_variable");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5special_variable";
$self->_MATCHIFYr($S, "category__S_002p5special_variable", $C->_EXACT("p5special_variable"));
}
;
## token p5special_variable { <...> }
sub p5special_variable__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable:*',$retree); }
sub p5special_variable {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5special_variable');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5special_variable') {
$C->deb("Fate passed to p5special_variable: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5special_variable';
}
else {
$x = 'ALTLTM p5special_variable';
}
}
else {
$x = 'ALTLTM p5special_variable';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5special_variable:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5special_variable trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5special_variable", @gather);
};
@result;
}
;
## token category:p5comment { <sym> }
sub category__S_003p5comment__PEEK { $_[0]->_AUTOLEXpeek('category__S_003p5comment', $retree) }
sub category__S_003p5comment {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_003p5comment");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5comment";
$self->_MATCHIFYr($S, "category__S_003p5comment", $C->_EXACT("p5comment"));
}
;
## token p5comment { <...> }
sub p5comment__PEEK { $_[0]->_AUTOLEXpeek('p5comment:*',$retree); }
sub p5comment {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5comment');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5comment') {
$C->deb("Fate passed to p5comment: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5comment';
}
else {
$x = 'ALTLTM p5comment';
}
}
else {
$x = 'ALTLTM p5comment';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5comment:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5comment trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5comment", @gather);
};
@result;
}
;
## token category:p5version { <sym> }
sub category__S_004p5version__PEEK { $_[0]->_AUTOLEXpeek('category__S_004p5version', $retree) }
sub category__S_004p5version {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_004p5version");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5version";
$self->_MATCHIFYr($S, "category__S_004p5version", $C->_EXACT("p5version"));
}
;
## token p5version { <...> }
sub p5version__PEEK { $_[0]->_AUTOLEXpeek('p5version:*',$retree); }
sub p5version {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5version');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5version') {
$C->deb("Fate passed to p5version: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5version';
}
else {
$x = 'ALTLTM p5version';
}
}
else {
$x = 'ALTLTM p5version';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5version:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5version trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5version", @gather);
};
@result;
}
;
## token category:p5module_name { <sym> }
sub category__S_005p5module_name__PEEK { $_[0]->_AUTOLEXpeek('category__S_005p5module_name', $retree) }
sub category__S_005p5module_name {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_005p5module_name");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5module_name";
$self->_MATCHIFYr($S, "category__S_005p5module_name", $C->_EXACT("p5module_name"));
}
;
## token p5module_name { <...> }
sub p5module_name__PEEK { $_[0]->_AUTOLEXpeek('p5module_name:*',$retree); }
sub p5module_name {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5module_name');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5module_name') {
$C->deb("Fate passed to p5module_name: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5module_name';
}
else {
$x = 'ALTLTM p5module_name';
}
}
else {
$x = 'ALTLTM p5module_name';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5module_name:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5module_name trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5module_name", @gather);
};
@result;
}
;
## token category:p5value { <sym> }
sub category__S_006p5value__PEEK { $_[0]->_AUTOLEXpeek('category__S_006p5value', $retree) }
sub category__S_006p5value {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_006p5value");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5value";
$self->_MATCHIFYr($S, "category__S_006p5value", $C->_EXACT("p5value"));
}
;
## token p5value { <...> }
sub p5value__PEEK { $_[0]->_AUTOLEXpeek('p5value:*',$retree); }
sub p5value {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5value');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5value') {
$C->deb("Fate passed to p5value: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5value';
}
else {
$x = 'ALTLTM p5value';
}
}
else {
$x = 'ALTLTM p5value';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5value:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5value trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5value", @gather);
};
@result;
}
;
## token category:p5term { <sym> }
sub category__S_007p5term__PEEK { $_[0]->_AUTOLEXpeek('category__S_007p5term', $retree) }
sub category__S_007p5term {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_007p5term");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5term";
$self->_MATCHIFYr($S, "category__S_007p5term", $C->_EXACT("p5term"));
}
;
## token p5term { <...> }
sub p5term__PEEK { $_[0]->_AUTOLEXpeek('p5term:*',$retree); }
sub p5term {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5term');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5term') {
$C->deb("Fate passed to p5term: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5term';
}
else {
$x = 'ALTLTM p5term';
}
}
else {
$x = 'ALTLTM p5term';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5term:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5term trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5term", @gather);
};
@result;
}
;
## token category:p5number { <sym> }
sub category__S_008p5number__PEEK { $_[0]->_AUTOLEXpeek('category__S_008p5number', $retree) }
sub category__S_008p5number {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_008p5number");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5number";
$self->_MATCHIFYr($S, "category__S_008p5number", $C->_EXACT("p5number"));
}
;
## token p5number { <...> }
sub p5number__PEEK { $_[0]->_AUTOLEXpeek('p5number:*',$retree); }
sub p5number {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5number');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5number') {
$C->deb("Fate passed to p5number: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5number';
}
else {
$x = 'ALTLTM p5number';
}
}
else {
$x = 'ALTLTM p5number';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5number:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5number trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5number", @gather);
};
@result;
}
;
## token category:p5quote { <sym> }
sub category__S_009p5quote__PEEK { $_[0]->_AUTOLEXpeek('category__S_009p5quote', $retree) }
sub category__S_009p5quote {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_009p5quote");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5quote";
$self->_MATCHIFYr($S, "category__S_009p5quote", $C->_EXACT("p5quote"));
}
;
## token p5quote () { <...> }
sub p5quote__PEEK { $_[0]->_AUTOLEXpeek('p5quote:*',$retree); }
sub p5quote {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5quote');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5quote') {
$C->deb("Fate passed to p5quote: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5quote';
}
else {
$x = 'ALTLTM p5quote';
}
}
else {
$x = 'ALTLTM p5quote';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5quote:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5quote trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5quote", @gather);
};
@result;
}
;
## token category:p5prefix { <sym> }
sub category__S_010p5prefix__PEEK { $_[0]->_AUTOLEXpeek('category__S_010p5prefix', $retree) }
sub category__S_010p5prefix {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_010p5prefix");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5prefix";
$self->_MATCHIFYr($S, "category__S_010p5prefix", $C->_EXACT("p5prefix"));
}
;
## token p5prefix is unary is defequiv(%symbolic_unary) { <...> }
sub p5prefix__PEEK { $_[0]->_AUTOLEXpeek('p5prefix:*',$retree); }
sub p5prefix {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5prefix');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5prefix') {
$C->deb("Fate passed to p5prefix: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5prefix';
}
else {
$x = 'ALTLTM p5prefix';
}
}
else {
$x = 'ALTLTM p5prefix';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5prefix:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5prefix trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5prefix", @gather);
};
@result;
}
;
## token category:p5infix { <sym> }
sub category__S_011p5infix__PEEK { $_[0]->_AUTOLEXpeek('category__S_011p5infix', $retree) }
sub category__S_011p5infix {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_011p5infix");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5infix";
$self->_MATCHIFYr($S, "category__S_011p5infix", $C->_EXACT("p5infix"));
}
;
## token p5infix is binary is defequiv(%additive) { <...> }
sub p5infix__PEEK { $_[0]->_AUTOLEXpeek('p5infix:*',$retree); }
sub p5infix {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5infix');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5infix') {
$C->deb("Fate passed to p5infix: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5infix';
}
else {
$x = 'ALTLTM p5infix';
}
}
else {
$x = 'ALTLTM p5infix';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5infix:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5infix trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5infix", @gather);
};
@result;
}
;
## token category:p5postfix { <sym> }
sub category__S_012p5postfix__PEEK { $_[0]->_AUTOLEXpeek('category__S_012p5postfix', $retree) }
sub category__S_012p5postfix {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_012p5postfix");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5postfix";
$self->_MATCHIFYr($S, "category__S_012p5postfix", $C->_EXACT("p5postfix"));
}
;
## token p5postfix is unary is defequiv(%autoincrement) { <...> }
sub p5postfix__PEEK { $_[0]->_AUTOLEXpeek('p5postfix:*',$retree); }
sub p5postfix {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5postfix');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5postfix') {
$C->deb("Fate passed to p5postfix: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5postfix';
}
else {
$x = 'ALTLTM p5postfix';
}
}
else {
$x = 'ALTLTM p5postfix';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5postfix:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5postfix trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5postfix", @gather);
};
@result;
}
;
## token category:p5dotty { <sym> }
sub category__S_013p5dotty__PEEK { $_[0]->_AUTOLEXpeek('category__S_013p5dotty', $retree) }
sub category__S_013p5dotty {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_013p5dotty");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5dotty";
$self->_MATCHIFYr($S, "category__S_013p5dotty", $C->_EXACT("p5dotty"));
}
;
## token p5dotty (:$*endsym = 'unspacey') { <...> }
sub p5dotty__PEEK { $_[0]->_AUTOLEXpeek('p5dotty:*',$retree); }
sub p5dotty {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5dotty');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5dotty') {
$C->deb("Fate passed to p5dotty: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5dotty';
}
else {
$x = 'ALTLTM p5dotty';
}
}
else {
$x = 'ALTLTM p5dotty';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5dotty:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5dotty trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5dotty", @gather);
};
@result;
}
;
## token category:p5circumfix { <sym> }
sub category__S_014p5circumfix__PEEK { $_[0]->_AUTOLEXpeek('category__S_014p5circumfix', $retree) }
sub category__S_014p5circumfix {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_014p5circumfix");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5circumfix";
$self->_MATCHIFYr($S, "category__S_014p5circumfix", $C->_EXACT("p5circumfix"));
}
;
## token p5circumfix { <...> }
sub p5circumfix__PEEK { $_[0]->_AUTOLEXpeek('p5circumfix:*',$retree); }
sub p5circumfix {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5circumfix');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5circumfix') {
$C->deb("Fate passed to p5circumfix: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5circumfix';
}
else {
$x = 'ALTLTM p5circumfix';
}
}
else {
$x = 'ALTLTM p5circumfix';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5circumfix:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5circumfix trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5circumfix", @gather);
};
@result;
}
;
## token category:p5postcircumfix { <sym> }
sub category__S_015p5postcircumfix__PEEK { $_[0]->_AUTOLEXpeek('category__S_015p5postcircumfix', $retree) }
sub category__S_015p5postcircumfix {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_015p5postcircumfix");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5postcircumfix";
$self->_MATCHIFYr($S, "category__S_015p5postcircumfix", $C->_EXACT("p5postcircumfix"));
}
;
## token p5postcircumfix is unary { <...> }  # unary as far as EXPR knows...
sub p5postcircumfix__PEEK { $_[0]->_AUTOLEXpeek('p5postcircumfix:*',$retree); }
sub p5postcircumfix {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5postcircumfix');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5postcircumfix') {
$C->deb("Fate passed to p5postcircumfix: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5postcircumfix';
}
else {
$x = 'ALTLTM p5postcircumfix';
}
}
else {
$x = 'ALTLTM p5postcircumfix';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5postcircumfix:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5postcircumfix trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5postcircumfix", @gather);
};
@result;
}
;
## token category:p5type_declarator { <sym> }
sub category__S_016p5type_declarator__PEEK { $_[0]->_AUTOLEXpeek('category__S_016p5type_declarator', $retree) }
sub category__S_016p5type_declarator {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_016p5type_declarator");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5type_declarator";
$self->_MATCHIFYr($S, "category__S_016p5type_declarator", $C->_EXACT("p5type_declarator"));
}
;
## token p5type_declarator (:$*endsym = 'spacey') { <...> }
sub p5type_declarator__PEEK { $_[0]->_AUTOLEXpeek('p5type_declarator:*',$retree); }
sub p5type_declarator {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5type_declarator');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5type_declarator') {
$C->deb("Fate passed to p5type_declarator: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5type_declarator';
}
else {
$x = 'ALTLTM p5type_declarator';
}
}
else {
$x = 'ALTLTM p5type_declarator';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5type_declarator:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5type_declarator trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5type_declarator", @gather);
};
@result;
}
;
## token category:p5scope_declarator { <sym> }
sub category__S_017p5scope_declarator__PEEK { $_[0]->_AUTOLEXpeek('category__S_017p5scope_declarator', $retree) }
sub category__S_017p5scope_declarator {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_017p5scope_declarator");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5scope_declarator";
$self->_MATCHIFYr($S, "category__S_017p5scope_declarator", $C->_EXACT("p5scope_declarator"));
}
;
## token p5scope_declarator (:$*endsym = 'nofun') { <...> }
sub p5scope_declarator__PEEK { $_[0]->_AUTOLEXpeek('p5scope_declarator:*',$retree); }
sub p5scope_declarator {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5scope_declarator');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5scope_declarator') {
$C->deb("Fate passed to p5scope_declarator: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5scope_declarator';
}
else {
$x = 'ALTLTM p5scope_declarator';
}
}
else {
$x = 'ALTLTM p5scope_declarator';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5scope_declarator:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5scope_declarator trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5scope_declarator", @gather);
};
@result;
}
;
## token category:p5package_declarator { <sym> }
sub category__S_018p5package_declarator__PEEK { $_[0]->_AUTOLEXpeek('category__S_018p5package_declarator', $retree) }
sub category__S_018p5package_declarator {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_018p5package_declarator");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5package_declarator";
$self->_MATCHIFYr($S, "category__S_018p5package_declarator", $C->_EXACT("p5package_declarator"));
}
;
## token p5package_declarator (:$*endsym = 'spacey') { <...> }
sub p5package_declarator__PEEK { $_[0]->_AUTOLEXpeek('p5package_declarator:*',$retree); }
sub p5package_declarator {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5package_declarator');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5package_declarator') {
$C->deb("Fate passed to p5package_declarator: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5package_declarator';
}
else {
$x = 'ALTLTM p5package_declarator';
}
}
else {
$x = 'ALTLTM p5package_declarator';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5package_declarator:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5package_declarator trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5package_declarator", @gather);
};
@result;
}
;
## token category:p5routine_declarator { <sym> }
sub category__S_019p5routine_declarator__PEEK { $_[0]->_AUTOLEXpeek('category__S_019p5routine_declarator', $retree) }
sub category__S_019p5routine_declarator {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_019p5routine_declarator");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5routine_declarator";
$self->_MATCHIFYr($S, "category__S_019p5routine_declarator", $C->_EXACT("p5routine_declarator"));
}
;
## token p5routine_declarator (:$*endsym = 'nofun') { <...> }
sub p5routine_declarator__PEEK { $_[0]->_AUTOLEXpeek('p5routine_declarator:*',$retree); }
sub p5routine_declarator {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5routine_declarator');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5routine_declarator') {
$C->deb("Fate passed to p5routine_declarator: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5routine_declarator';
}
else {
$x = 'ALTLTM p5routine_declarator';
}
}
else {
$x = 'ALTLTM p5routine_declarator';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5routine_declarator:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5routine_declarator trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5routine_declarator", @gather);
};
@result;
}
;
## token category:p5regex_declarator { <sym> }
sub category__S_020p5regex_declarator__PEEK { $_[0]->_AUTOLEXpeek('category__S_020p5regex_declarator', $retree) }
sub category__S_020p5regex_declarator {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_020p5regex_declarator");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5regex_declarator";
$self->_MATCHIFYr($S, "category__S_020p5regex_declarator", $C->_EXACT("p5regex_declarator"));
}
;
## token p5regex_declarator (:$*endsym = 'spacey') { <...> }
sub p5regex_declarator__PEEK { $_[0]->_AUTOLEXpeek('p5regex_declarator:*',$retree); }
sub p5regex_declarator {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5regex_declarator');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5regex_declarator') {
$C->deb("Fate passed to p5regex_declarator: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5regex_declarator';
}
else {
$x = 'ALTLTM p5regex_declarator';
}
}
else {
$x = 'ALTLTM p5regex_declarator';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5regex_declarator:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5regex_declarator trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5regex_declarator", @gather);
};
@result;
}
;
## token category:p5statement_prefix { <sym> }
sub category__S_021p5statement_prefix__PEEK { $_[0]->_AUTOLEXpeek('category__S_021p5statement_prefix', $retree) }
sub category__S_021p5statement_prefix {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_021p5statement_prefix");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5statement_prefix";
$self->_MATCHIFYr($S, "category__S_021p5statement_prefix", $C->_EXACT("p5statement_prefix"));
}
;
## rule  p5statement_prefix () { <...> }
sub p5statement_prefix__PEEK { $_[0]->_AUTOLEXpeek('p5statement_prefix:*',$retree); }
sub p5statement_prefix {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5statement_prefix');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5statement_prefix') {
$C->deb("Fate passed to p5statement_prefix: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5statement_prefix';
}
else {
$x = 'ALTLTM p5statement_prefix';
}
}
else {
$x = 'ALTLTM p5statement_prefix';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5statement_prefix:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5statement_prefix trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5statement_prefix", @gather);
};
@result;
}
;
## token category:p5statement_control { <sym> }
sub category__S_022p5statement_control__PEEK { $_[0]->_AUTOLEXpeek('category__S_022p5statement_control', $retree) }
sub category__S_022p5statement_control {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_022p5statement_control");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5statement_control";
$self->_MATCHIFYr($S, "category__S_022p5statement_control", $C->_EXACT("p5statement_control"));
}
;
## rule  p5statement_control (:$*endsym = 'spacey') { <...> }
sub p5statement_control__PEEK { $_[0]->_AUTOLEXpeek('p5statement_control:*',$retree); }
sub p5statement_control {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5statement_control');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5statement_control') {
$C->deb("Fate passed to p5statement_control: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5statement_control';
}
else {
$x = 'ALTLTM p5statement_control';
}
}
else {
$x = 'ALTLTM p5statement_control';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5statement_control:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5statement_control trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5statement_control", @gather);
};
@result;
}
;
## token category:p5statement_mod_cond { <sym> }
sub category__S_023p5statement_mod_cond__PEEK { $_[0]->_AUTOLEXpeek('category__S_023p5statement_mod_cond', $retree) }
sub category__S_023p5statement_mod_cond {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_023p5statement_mod_cond");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5statement_mod_cond";
$self->_MATCHIFYr($S, "category__S_023p5statement_mod_cond", $C->_EXACT("p5statement_mod_cond"));
}
;
## rule  p5statement_mod_cond (:$*endsym = 'nofun') { <...> }
sub p5statement_mod_cond__PEEK { $_[0]->_AUTOLEXpeek('p5statement_mod_cond:*',$retree); }
sub p5statement_mod_cond {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5statement_mod_cond');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5statement_mod_cond') {
$C->deb("Fate passed to p5statement_mod_cond: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5statement_mod_cond';
}
else {
$x = 'ALTLTM p5statement_mod_cond';
}
}
else {
$x = 'ALTLTM p5statement_mod_cond';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5statement_mod_cond:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5statement_mod_cond trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5statement_mod_cond", @gather);
};
@result;
}
;
## token category:p5statement_mod_loop { <sym> }
sub category__S_024p5statement_mod_loop__PEEK { $_[0]->_AUTOLEXpeek('category__S_024p5statement_mod_loop', $retree) }
sub category__S_024p5statement_mod_loop {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_024p5statement_mod_loop");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5statement_mod_loop";
$self->_MATCHIFYr($S, "category__S_024p5statement_mod_loop", $C->_EXACT("p5statement_mod_loop"));
}
;
## rule  p5statement_mod_loop (:$*endsym = 'nofun') { <...> }
sub p5statement_mod_loop__PEEK { $_[0]->_AUTOLEXpeek('p5statement_mod_loop:*',$retree); }
sub p5statement_mod_loop {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5statement_mod_loop');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5statement_mod_loop') {
$C->deb("Fate passed to p5statement_mod_loop: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5statement_mod_loop';
}
else {
$x = 'ALTLTM p5statement_mod_loop';
}
}
else {
$x = 'ALTLTM p5statement_mod_loop';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5statement_mod_loop:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5statement_mod_loop trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5statement_mod_loop", @gather);
};
@result;
}
;
## token category:p5terminator { <sym> }
sub category__S_025p5terminator__PEEK { $_[0]->_AUTOLEXpeek('category__S_025p5terminator', $retree) }
sub category__S_025p5terminator {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_025p5terminator");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5terminator";
$self->_MATCHIFYr($S, "category__S_025p5terminator", $C->_EXACT("p5terminator"));
}
;
## token p5terminator { <...> }
sub p5terminator__PEEK { $_[0]->_AUTOLEXpeek('p5terminator:*',$retree); }
sub p5terminator {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5terminator');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5terminator') {
$C->deb("Fate passed to p5terminator: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5terminator';
}
else {
$x = 'ALTLTM p5terminator';
}
}
else {
$x = 'ALTLTM p5terminator';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5terminator:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5terminator trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5terminator", @gather);
};
@result;
}
;
## token unspacey { <.unsp>? }
sub unspacey__PEEK { $_[0]->_AUTOLEXpeek('unspacey', $retree) }
sub unspacey {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE unspacey");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "unspacey", $C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->unsp)) { ($C) } else { () }
}));
}
;
## token endid { <?before <-[ \- \' \w ]> > }
sub endid__PEEK { $_[0]->_AUTOLEXpeek('endid', $retree) }
sub endid {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE endid");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "endid", $C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G[^\-\'\w]/)
}))) { ($C) } else { () }
}));
}
;
## token spacey { <?before <[ \s \# ]> > }
sub spacey__PEEK { $_[0]->_AUTOLEXpeek('spacey', $retree) }
sub spacey {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE spacey");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "spacey", $C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G[\s\#]/)
}))) { ($C) } else { () }
}));
}
;
## token nofun { <!before '(' | '.(' | '\\' | '\'' | '-' | "'" | \w > }
sub nofun__PEEK { $_[0]->_AUTOLEXpeek('nofun', $retree) }
sub nofun {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE nofun");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "nofun", $C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = (do {
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'nofun_0') {
$C->deb("Fate passed to nofun_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT nofun_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM nofun_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'nofun_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("nofun_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_EXACT("\(")
},
sub {
my $C=shift;
$C->_EXACT("\.\(")
},
sub {
my $C=shift;
$C->_EXACT("\\")
},
sub {
my $C=shift;
$C->_EXACT("\'")
},
sub {
my $C=shift;
$C->_EXACT("\-")
},
sub {
my $C=shift;
$C->_EXACT("\'")
},
sub {
my $C=shift;
$C->_PATTERN(qr/\G\w/)
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};

})) { ($C) } else { () }
}))) { ($C) } else { () }
}));
}
;
## token ws {
sub ws__PEEK { $_[0]->_AUTOLEXpeek('ws', $retree) }
sub ws {
no warnings 'recursion';
my $self = shift;

local @::STUB = @::STUB = return $self if exists $::MEMOS[$self->{'_pos'}]->{'ws'};my $startpos = $self->{'_pos'};
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE ws");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "ws", do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'ws_0') {
$C->deb("Fate passed to ws_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT ws_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM ws_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'ws_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("ws_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (($C) = ($C->_PATTERN(qr/\G[\x20\t\r]++/))
and ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
$C->_PATTERN(qr/\G[\#\s\\]/)
}))) {
scalar(do {
$::MEMOS[$C->{'_pos'}]->{'ws'} = $startpos}, $C)
} else { () }
},
sub {
my $C=shift;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G\w/)
}))) { ($C) } else { () }
}))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->after(sub {
my $C=shift;
$C->_PATTERN(qr/\G(?<=\w)/)
}))) { ($C) } else { () }
}))
and ($C) = ($C->_COMMITRULE())
and ($C) = (scalar(do {
delete $::MEMOS[$startpos]->{'ws'}}, $C))
and ($C) = ($C->panic("Whitespace is required between alphanumeric tokens"))) {
$C
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) { ($C) } else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->_STARr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'ws_1') {
$C->deb("Fate passed to ws_1: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT ws_1';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM ws_1'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'ws_1', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("ws_1 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->unsp)) { ($C) } else { () }
},
sub {
my $C=shift;
if (($C) = ($C->vws)
and ($C) = ($C->heredoc)) {
$C
} else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->unv)) { ($C) } else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->_PATTERN(qr/\G\z/))) {
scalar(do {
$C->moreinput }, $C)
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) { ($C) } else { () }
}))) {
scalar(do {
{
if (($C->{'_pos'} == $startpos)) {
delete $::MEMOS[$C->{'_pos'}]->{'ws'}}
else {
delete $::MEMOS[$C->{'_pos'}]->{'ws'};
$::MEMOS[$C->{'_pos'}]->{'endstmt'} = $::MEMOS[$startpos]->{'endstmt'}
if exists $::MEMOS[$startpos]->{'endstmt'};
}}}, $C)
} else { () }

}
};
@gather;
});
}
;
## token unsp {
sub unsp__PEEK { $_[0]->_AUTOLEXpeek('unsp', $retree) }
sub unsp {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE unsp");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "unsp", $C->_NOTBEFORE(sub {
my $C=shift;
$C
}));
}
;
## token vws {
sub vws__PEEK { $_[0]->_AUTOLEXpeek('vws', $retree) }
sub vws {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE vws");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "vws", do {
if (my ($C) = ($C->_PATTERN(qr/\G\n/))) {
$C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (my ($C) = ($C->_EXACT("\#DEBUG\ \-1"))) {
scalar(do {
say "DEBUG";
$STD::DEBUG = $::DEBUG = -1;
}, $C)
} else { () }
}))) { ($C) } else { () }
})
} else { () }

});
}
;
## method moreinput ()
sub moreinput {
no warnings 'recursion';
my $self = shift;
$::moreinput->() if $::moreinput};
## token unv {
sub unv__PEEK { $_[0]->_AUTOLEXpeek('unv', $retree) }
sub unv {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE unv");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "unv", $C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'unv_0') {
$C->deb("Fate passed to unv_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT unv_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM unv_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'unv_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("unv_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_PATTERN(qr/\G[\x20\t\r]++/)
},
sub {
my $C=shift;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
do {
my $C = $C;
if (($C) = ($C->_PATTERN(qr/\G[\x20\t\r]*+\=/))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'unv_1') {
$C->deb("Fate passed to unv_1: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT unv_1';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM unv_1'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'unv_1', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("unv_1 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_PATTERN(qr/\G\w/)
},
sub {
my $C=shift;
$C->_EXACT("\\")
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }
};
}))) { ($C) } else { () }
}))
and ($C) = ($C->_PATTERN(qr/\G(?m:^)/))
and ($C) = ($C->pod_comment)) {
$C
} else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->_PATTERN(qr/\G[\x20\t\r]*+/))) {
$C->_SUBSUMEr(['comment','p5comment'], sub {
my $C = shift;
$C->p5comment
})
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}));
}
;
## token p5comment:sym<#> {
sub p5comment__S_026Sharp__PEEK { $_[0]->_AUTOLEXpeek('p5comment__S_026Sharp', $retree) }
sub p5comment__S_026Sharp {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5comment__S_026Sharp");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\#";
$self->_MATCHIFYr($S, "p5comment__S_026Sharp", do {
my $C = $C;
if (($C) = ($C->_EXACT("\#"))
and ($C) = (scalar(do {
}, $C))) {
$C->_STARr(sub {
my $C=shift;
$C->_NOTCHAR( sub { my $C=shift;
$C->_EXACT("\n")
})
})
} else { () }

});
}
;
## token ident {
sub ident__PEEK { $_[0]->_AUTOLEXpeek('ident', $retree) }
sub ident {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE ident");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "ident", $C->_PATTERN(qr/\G[_[:alpha:]]\w*+/));
}
;
## token identifier {
sub identifier__PEEK { $_[0]->_AUTOLEXpeek('identifier', $retree) }
sub identifier {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE identifier");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "identifier", $C->_PATTERN(qr/\G[_[:alpha:]]\w*+/));
}
;
## token pod_comment {
sub pod_comment__PEEK { $_[0]->_AUTOLEXpeek('pod_comment', $retree) }
sub pod_comment {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE pod_comment");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "pod_comment", do {
my $C = $C;
if (($C) = ($C->_PATTERN(qr/\G(?m:^)[\x20\t\r]*+\=/))
and ($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->unsp)) { ($C) } else { () }
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'pod_comment_0') {
$C->deb("Fate passed to pod_comment_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT pod_comment_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM pod_comment_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'pod_comment_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("pod_comment_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (($C) = ($C->_PATTERN(qr/\Gbegin[\x20\t\r]++/))
and ($C) = ($C->_SUBSUMEr(['identifier'], sub {
my $C = shift;
$C->identifier
}))
and ($C) = ($C->_COMMITLTM())
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
if (my ($C) = (STD::LazyMap::lazymap(sub {
my $C=shift;
if (($C) = ($C->_EXACT("\n"))
and ($C) = ($C->_PATTERN(qr/\G[\x20\t\r]*+\=/))
and ($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->unsp)) { ($C) } else { () }
}))
and ($C) = ($C->_PATTERN(qr/\Gend[\x20\t\r]++/))
and ($C) = ($C->_BACKREFn('identifier'))
and ($C) = ($C->_PATTERN(qr/\G\b/))) {
$C->_STARr(sub {
my $C=shift;
$C->_NOTCHAR( sub { my $C=shift;
$C->_EXACT("\n")
})
})
} else { () }
},
$C->_SCANf()))) { ($C) } else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->before(sub {
my $C=shift;
(($C) x !!do {
my $M = $C;
$M->{'identifier'}->Str eq 'END'})
}))) {
$C->_STARr(sub {
my $C=shift;
$C->cursor_incr()
})
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, scalar(do {
my $M = $C;
my $id = $M->{'identifier'}->Str;
$self->panic("=begin $id without matching =end $id");
}, $C)
};
@gather;
}
}))) {
$C
} else { () }
},
sub {
my $C=shift;
if (($C) = ($C->_PATTERN(qr/\Gbegin\b/))
and ($C) = ($C->_COMMITLTM())
and ($C) = ($C->_PATTERN(qr/\G[\x20\t\r]*+/))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_PATTERN(qr/\G(?m:$)/)
}
or $xact->[-2] or
do {
push @gather, $C->_EXACT("\#")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->panic("Unrecognized token after =begin"))) { ($C) } else { () }

}
};
@gather;
}
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
if (my ($C) = (STD::LazyMap::lazymap(sub {
my $C=shift;
if (($C) = ($C->_EXACT("\n"))
and ($C) = ($C->_PATTERN(qr/\G[\x20\t\r]*+\=/))
and ($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->unsp)) { ($C) } else { () }
}))
and ($C) = ($C->_PATTERN(qr/\Gend\b/))) {
$C->_STARr(sub {
my $C=shift;
$C->_NOTCHAR( sub { my $C=shift;
$C->_EXACT("\n")
})
})
} else { () }
},
$C->_SCANf()))) { ($C) } else { () }

}
}
or $xact->[-2] or
do {
push @gather, scalar(do {
$self->panic("=begin without matching =end")}, $C)
};
@gather;
}
}))) {
$C
} else { () }
},
sub {
my $C=shift;
if (($C) = ($C->_PATTERN(qr/\Gfor\b/))
and ($C) = ($C->_COMMITLTM())
and ($C) = ($C->_PATTERN(qr/\G[\x20\t\r]*+/))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_SUBSUMEr(['identifier'], sub {
my $C = shift;
$C->identifier
})
}
or $xact->[-2] or
do {
push @gather, $C->_PATTERN(qr/\G(?m:$)/)
}
or $xact->[-2] or
do {
push @gather, $C->_EXACT("\#")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->panic("Unrecognized token after =for"))) { ($C) } else { () }

}
};
@gather;
}
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
if (my ($C) = (STD::LazyMap::lazymap(sub {
my $C=shift;
$C->_PATTERN(qr/\G(?m:^)[\x20\t\r]*+(?m:$)/)
},
$C->_SCANf()))) { ($C) } else { () }

}
}
or $xact->[-2] or
do {
push @gather, $C->_STARr(sub {
my $C=shift;
$C->cursor_incr()
})
};
@gather;
}
}))) {
$C
} else { () }
},
sub {
my $C=shift;
if (($C) = ($C->_COMMITLTM())
and ($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = (STD::LazyMap::lazymap(sub {
my $C=shift;
$C->_PATTERN(qr/\G(?m:^)\=cut\b/)
},
$C->_SCANf()))) { ($C) } else { () }
}))) { ($C) } else { () }
}))
and ($C) = ($C->panic("Obsolete pod format, please use =begin/=end instead"))) {
$C
} else { () }
}))) { ($C) } else { () }
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_PATTERN(qr/\G[_[:alpha:]]/)
}
or $xact->[-2] or
do {
push @gather, $C->_PATTERN(qr/\G\s/)
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->panic("Illegal pod directive"))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C->_STARr(sub {
my $C=shift;
$C->_NOTCHAR( sub { my $C=shift;
$C->_EXACT("\n")
})
})
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

});
}
;
## rule comp_unit {
sub comp_unit__PEEK { $_[0]->_AUTOLEXpeek('comp_unit', $retree) }
sub comp_unit {
no warnings 'recursion';
my $self = shift;

local $::begin_compunit = 1;local $::endargs = -1;local %::LANG;local $::PKGDECL = "";local $::IN_DECL;local $::DECLARAND;local $::NEWPKG;local $::NEWLEX;local $::QSIGIL = '';local $::IN_META = 0;local $::QUASIMODO;local $::SCOPE = "";local $::LEFTSIGIL;local %::MYSTERY = ();local $::INVOCANT_OK;local $::INVOCANT_IS;local $::CURLEX;local $::MULTINESS = '';local $::CURPKG;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE comp_unit");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "comp_unit", do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = (scalar(do {
{
$::LANG{'MAIN'}    = 'STD' ;
$::LANG{'Q'}       = 'STD::Q' ;
$::LANG{'Regex'}   = 'STD::Regex' ;
$::LANG{'Trans'}   = 'STD::Trans' ;
$::LANG{'P5'}      = 'STD::STD::P5' ;
$::LANG{'P5Regex'} = 'STD::P5::Regex' ;
@::WORRIES = ();
$self->load_setting($::SETTINGNAME);
my $oid = $::SETTING->id;
my $id = 'MY:file<' . $::FILE->{'name'} . '>';
$::CURLEX = Stash->new(
'OUTER::' => [$oid],
'!file' => $::FILE, '!line' => 0,
'!id' => [$id],
);
$STD::ALL->{$id} = $::CURLEX;
$::UNIT = $::CURLEX;
$STD::ALL->{'UNIT'} = $::UNIT;
$self->finishlex;
}}, $C))
and ($C) = ($C->_SUBSUMEr(['statementlist'], sub {
my $C = shift;
$C->statementlist
}))
and ($C) = ($C->ws)
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->unitstopper)) { ($C) } else { () }
}))) { ($C) } else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->panic("Confused"))
and ($C) = ($C->ws)) {
$C
} else { () }

}
};
@gather;
}
}))) {
scalar(do {
{
if (@::WORRIES) {
warn "Potential difficulties:\n  " . join( "\n  ", @::WORRIES) . "\n"};
my $m = $C->explain_mystery();
warn $m if $m;
}}, $C)
} else { () }

});
}
;
## method explain_mystery()
sub explain_mystery {
no warnings 'recursion';
my $self = shift;
my %post_types;
my %unk_types;
my %unk_routines;
my $m = '';
for (keys(%::MYSTERY)) {
my $p = $::MYSTERY{$_}->{'lex'};
if ($self->is_name($_, $p)) {
$post_types{$_} = $::MYSTERY{$_};
next;
};
next if $self->is_known($_, $p) or $self->is_known('&' . $_, $p);
if ($_ lt 'a') {
$unk_types{$_} = $::MYSTERY{$_}}
else {
$unk_routines{$_} = $::MYSTERY{$_}};
}
;
if (%post_types) {
my @tmp = sort keys(%post_types);
$m .= "Illegally post-declared type" . ('s' x (@tmp != 1)) . ":\n";
for (@tmp) {
$m .= "\t$_ used at line " . $post_types{$_}->{'line'} . "\n"}
;
};
if (%unk_types) {
my @tmp = sort keys(%unk_types);
$m .= "Undeclared name" . ('s' x (@tmp != 1)) . ":\n";
for (@tmp) {
$m .= "\t$_ used at line " . $unk_types{$_}->{'line'} . "\n"}
;
};
if (%unk_routines) {
my @tmp = sort keys(%unk_routines);
$m .= "Undeclared routine" . ('s' x (@tmp != 1)) . ":\n";
for (@tmp) {
$m .= "\t$_ used at line " . $unk_routines{$_}->{'line'} . "\n"}
;
};
$m;
};
## token xblock {
sub xblock__PEEK { $_[0]->_AUTOLEXpeek('xblock', $retree) }
sub xblock {
no warnings 'recursion';
my $self = shift;

local $::GOAL = '{';
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE xblock");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "xblock", do {
my $C = $C;
if (($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\)";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\("))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['EXPR'], sub {
my $C = shift;
$C->EXPR
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\)")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'block expression', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))
and ($C) = ($C->ws)) {
$C->_SUBSUMEr(['block'], sub {
my $C = shift;
$C->block
})
} else { () }

});
}
;
## token block {
sub block__PEEK { $_[0]->_AUTOLEXpeek('block', $retree) }
sub block {
no warnings 'recursion';
my $self = shift;

local $::CURLEX = $::CURLEX;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE block");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "block", do {
my $C = $C;
if (($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\{")
}))) { ($C) } else { () }
}))) { ($C) } else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->panic("Missing block"))) { ($C) } else { () }

}
};
@gather;
}
}))
and ($C) = ($C->newlex)) {
$C->_SUBSUMEr(['blockoid'], sub {
my $C = shift;
$C->blockoid
})
} else { () }

});
}
;
## token blockoid {
sub blockoid__PEEK { $_[0]->_AUTOLEXpeek('blockoid', $retree) }
sub blockoid {
no warnings 'recursion';
my $self = shift;

local %::LANG = %::LANG;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE blockoid");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "blockoid", do {
my $C = $C;
if (($C) = ($C->finishlex)
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'blockoid_0') {
$C->deb("Fate passed to blockoid_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT blockoid_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM blockoid_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'blockoid_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("blockoid_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\}";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\{"))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['statementlist'], sub {
my $C = shift;
$C->statementlist
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\}")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'block', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) { ($C) } else { () }
},
sub {
my $C=shift;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->terminator)) { ($C) } else { () }
}))
and ($C) = ($C->panic('Missing block'))) {
$C
} else { () }
},
sub {
my $C=shift;
if (($C) = ($C->before(sub {
my $C=shift;
$C
}))
and ($C) = ($C->panic("Malformed block"))) {
$C
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'blockoid_1') {
$C->deb("Fate passed to blockoid_1: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT blockoid_1';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM blockoid_1'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'blockoid_1', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("blockoid_1 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G[\x20\t\r]*+(?m:$)/)
}))) { ($C) } else { () }
}))) {
scalar(do {
$::MEMOS[$C->{'_pos'}]->{'endstmt'} = 2}, $C)
} else { () }
},
sub {
my $C=shift;
if (($C) = ($C->_PATTERN(qr/\G[\x20\t\r]*+/))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G[\\,:]/)
}))) { ($C) } else { () }
}))) {
$C
} else { () }
},
sub {
my $C=shift;
if (($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->unv)) { ($C) } else { () }
}))
and ($C) = ($C->_PATTERN(qr/\G(?m:$)/))) {
scalar(do {
$::MEMOS[$C->{'_pos'}]->{'endstmt'} = 2}, $C)
} else { () }
},
sub {
my $C=shift;
if (($C) = (scalar(do {
}, $C))
and ($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->unsp)) { ($C) } else { () }
}))) {
scalar(do {
$::MEMOS[$C->{'_pos'}]->{'endargs'} = 1}, $C)
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

});
}
;
## token regex_block {
sub regex_block__PEEK { $_[0]->_AUTOLEXpeek('regex_block', $retree) }
sub regex_block {
no warnings 'recursion';
my $self = shift;

local %::LANG = %::LANG;my $lang = $::LANG{'Regex'};local $::GOAL = '}';
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE regex_block");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'quotepair'} = [];
$self->_MATCHIFYr($S, "regex_block", do {
my $C = $C;
if (($C) = ($C->_STARr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->_SUBSUMEr(['quotepair'], sub {
my $C = shift;
$C->quotepair
}))
and ($C) = ($C->ws)) {
scalar(do {
my $M = $C;
my $kv = $M->{'quotepair'}->[-1];
$lang = $lang->tweak($kv->{'k'}, $kv->{'v'})
or $self->sorry("Unrecognized adverb :" . $kv->{'k'} . '(' . $kv->{'v'} . ')');
}, $C)
} else { () }
}))) { ($C) } else { () }
}))
and ($C) = ($C->_EXACT("\{"))
and ($C) = ($C->_SUBSUMEr(['nibble'], sub {
my $C = shift;
$C->nibble( $C->cursor_fresh($lang)->unbalanced('}') )
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\}")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->panic("Unable to parse regex; couldn't find right brace"))) { ($C) } else { () }

}
};
@gather;
}
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'regex_block_0') {
$C->deb("Fate passed to regex_block_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT regex_block_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM regex_block_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'regex_block_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("regex_block_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G[\x20\t\r]*+(?m:$)/)
}))) { ($C) } else { () }
}))) {
scalar(do {
$::MEMOS[$C->{'_pos'}]->{'endstmt'} = 2}, $C)
} else { () }
},
sub {
my $C=shift;
if (($C) = ($C->_PATTERN(qr/\G[\x20\t\r]*+/))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G[\\,:]/)
}))) { ($C) } else { () }
}))) {
$C
} else { () }
},
sub {
my $C=shift;
if (($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->unv)) { ($C) } else { () }
}))
and ($C) = ($C->_PATTERN(qr/\G(?m:$)/))) {
scalar(do {
$::MEMOS[$C->{'_pos'}]->{'endstmt'} = 2}, $C)
} else { () }
},
sub {
my $C=shift;
if (($C) = (scalar(do {
}, $C))
and ($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->unsp)) { ($C) } else { () }
}))) {
scalar(do {
$::MEMOS[$C->{'_pos'}]->{'endargs'} = 1}, $C)
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

});
}
;
## rule statementlist {
sub statementlist__PEEK { $_[0]->_AUTOLEXpeek('statementlist', $retree) }
sub statementlist {
no warnings 'recursion';
my $self = shift;

local $::INVOCANT_OK = 0;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE statementlist");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'eat_terminator'} = [];
$C->{'statement'} = [];
$self->_MATCHIFYr($S, "statementlist", do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'statementlist_0') {
$C->deb("Fate passed to statementlist_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT statementlist_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM statementlist_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'statementlist_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("statementlist_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (($C) = ($C->_PATTERN(qr/\G\z/))
and ($C) = ($C->ws)) {
$C
} else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = ($C->_PATTERN(qr/\G[\)\]\}]/))
and ($C) = ($C->ws)) {
$C
} else { () }
};
}))) { ($C) } else { () }
}))) { ($C) } else { () }
},
sub {
my $C=shift;
if (($C) = ($C->_STARr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->_SUBSUMEr(['statement'], sub {
my $C = shift;
$C->statement
}))
and ($C) = ($C->_SUBSUMEr(['eat_terminator'], sub {
my $C = shift;
$C->eat_terminator
}))
and ($C) = ($C->ws)) {
$C
} else { () }
}))) { ($C) } else { () }
}))
and ($C) = ($C->ws)) {
$C
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

});
}
;
## rule semilist {
sub semilist__PEEK { $_[0]->_AUTOLEXpeek('semilist', $retree) }
sub semilist {
no warnings 'recursion';
my $self = shift;

local $::INVOCANT_OK = 0;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE semilist");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'eat_terminator'} = [];
$C->{'statement'} = [];
$self->_MATCHIFYr($S, "semilist", do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'semilist_0') {
$C->deb("Fate passed to semilist_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT semilist_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM semilist_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'semilist_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("semilist_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = ($C->_PATTERN(qr/\G[\)\]\}]/))
and ($C) = ($C->ws)) {
$C
} else { () }
};
}))) { ($C) } else { () }
}))) { ($C) } else { () }
},
sub {
my $C=shift;
if (($C) = ($C->_STARr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->_SUBSUMEr(['statement'], sub {
my $C = shift;
$C->statement
}))
and ($C) = ($C->_SUBSUMEr(['eat_terminator'], sub {
my $C = shift;
$C->eat_terminator
}))
and ($C) = ($C->ws)) {
$C
} else { () }
}))) { ($C) } else { () }
}))
and ($C) = ($C->ws)) {
$C
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

});
}
;
## token label {
sub label__PEEK { $_[0]->_AUTOLEXpeek('label', $retree) }
sub label {
no warnings 'recursion';
my $self = shift;

my $label;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE label");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "label", do {
my $C = $C;
if (($C) = ($C->_SUBSUMEr(['identifier'], sub {
my $C = shift;
$C->identifier
}))
and ($C) = ($C->_EXACT("\:"))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G\s/)
}))) { ($C) } else { () }
}))
and ($C) = ($C->ws)
and ($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->before(sub {
my $C=shift;
(($C) x !!do {
my $M = $C;
$C->is_name($label = $M->{'identifier'}->Str) })
}))
and ($C) = ($C->sorry("Illegal redeclaration of '$label'"))) {
$C
} else { () }
}))) { ($C) } else { () }
}))) {
scalar(do {
{
$C->add_my_name($label)}}, $C)
} else { () }

});
}
;
## token statement {
sub statement__PEEK { $_[0]->_AUTOLEXpeek('statement', $retree) }
sub statement {
no warnings 'recursion';
my $self = shift;

local $::endargs = -1;local $::QSIGIL = 0;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE statement");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'p5statement_mod_cond'} = [];
$C->{'p5statement_mod_loop'} = [];
$C->{'statement_mod_cond'} = [];
$C->{'statement_mod_loop'} = [];
$self->_MATCHIFYr($S, "statement", do {
my $C = $C;
if (($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G[\)\]\}]/)
}))) { ($C) } else { () }
}))
and ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
(($C) x !!do {
$C = $::LANG{'MAIN'}->bless($C)})
}))) { ($C) } else { () }
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'statement_0') {
$C->deb("Fate passed to statement_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT statement_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM statement_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'statement_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("statement_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->_SUBSUMEr(['label'], sub {
my $C = shift;
$C->label
}))) {
$C->_SUBSUMEr(['statement'], sub {
my $C = shift;
$C->statement
})
} else { () }
},
sub {
my $C=shift;
$C->_SUBSUMEr(['statement_control','p5statement_control'], sub {
my $C = shift;
$C->p5statement_control
})
},
sub {
my $C=shift;
if (($C) = ($C->_SUBSUMEr(['EXPR'], sub {
my $C = shift;
$C->EXPR
}))
and ($C) = ($C->ws)) {
$C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'statement_1') {
$C->deb("Fate passed to statement_1: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT statement_1';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM statement_1'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'statement_1', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("statement_1 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_SUBSUMEr(['statement_mod_loop','p5statement_mod_loop'], sub {
my $C = shift;
$C->p5statement_mod_loop
})
},
sub {
my $C=shift;
$C->_SUBSUMEr(['statement_mod_cond','p5statement_mod_cond'], sub {
my $C = shift;
$C->p5statement_mod_cond
})
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) { ($C) } else { () }
})
} else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\;")
}))) { ($C) } else { () }
}))) { ($C) } else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

});
}
;
## token eat_terminator {
sub eat_terminator__PEEK { $_[0]->_AUTOLEXpeek('eat_terminator', $retree) }
sub eat_terminator {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE eat_terminator");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "eat_terminator", $C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
if (my ($C) = ($C->_EXACT("\;"))) {
$C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G\z/)
}))) { ($C) } else { () }
}))) {
scalar(do {
$::ORIG =~ s/\;$/ /}, $C)
} else { () }
}))) { ($C) } else { () }
})
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->before(sub {
my $C=shift;
(($C) x !!do {
$::MEMOS[$C->{'_pos'}]->{'endstmt'} })
}))
and ($C) = ($C->ws)) {
$C
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->terminator)) { ($C) } else { () }
}))) { ($C) } else { () }

}
}
or $xact->[-2] or
do {
push @gather, $C->_PATTERN(qr/\G\z/)
}
or $xact->[-2] or
do {
push @gather, do {
my $C = $C;
if (($C) = (scalar(do {
{
if ($::MEMOS[$C->{'_pos'}]->{'ws'}) {
$C->{'_pos'} = $::MEMOS[$C->{'_pos'}]->{'ws'}}}}, $C))
and ($C) = ($C->panic("Confused"))) {
$C
} else { () }

}
};
@gather;
}
}));
}
;
## token p5statement_control:use {
sub p5statement_control__S_027use__PEEK { $_[0]->_AUTOLEXpeek('p5statement_control__S_027use', $retree) }
sub p5statement_control__S_027use {
no warnings 'recursion';
my $self = shift;

;
my $longname;local $::SCOPE = 'use';
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_control__S_027use");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "use";
$self->_MATCHIFYr($S, "p5statement_control__S_027use", do {
my $C = $C;
if (($C) = ($C->_EXACT("use"))
and ($C) = ($C->spacey)
and ($C) = ($C->ws)
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'p5statement_control__S_027use_0') {
$C->deb("Fate passed to p5statement_control__S_027use_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5statement_control__S_027use_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM p5statement_control__S_027use_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5statement_control__S_027use_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("p5statement_control__S_027use_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_SUBSUMEr(['version','p5version'], sub {
my $C = shift;
$C->p5version
})
},
sub {
my $C=shift;
if (($C) = ($C->_SUBSUMEr(['module_name','p5module_name'], sub {
my $C = shift;
$C->p5module_name
}))
and ($C) = (scalar(do {
my $M = $C;
{
$longname = $M->{'module_name'}->{'longname'}}}, $C))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->spacey)
and ($C) = ($C->_SUBSUMEr(['arglist'], sub {
my $C = shift;
$C->arglist
}))) {
scalar(do {
my $M = $C;
{
$C->do_use($longname, $M->{'arglist'})}}, $C)
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, scalar(do {
{
$C->do_use($longname, '')}}, $C)
};
@gather;
}
}))) {
$C
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## token p5statement_control:no {
sub p5statement_control__S_028no__PEEK { $_[0]->_AUTOLEXpeek('p5statement_control__S_028no', $retree) }
sub p5statement_control__S_028no {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_control__S_028no");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'arglist'} = [];
$C->{sym} = "no";
$self->_MATCHIFYr($S, "p5statement_control__S_028no", do {
my $C = $C;
if (($C) = ($C->_EXACT("no"))
and ($C) = ($C->spacey)
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['module_name','p5module_name'], sub {
my $C = shift;
$C->p5module_name
}))
and ($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (my ($C) = ($C->spacey)) {
$C->_SUBSUMEr(['arglist'], sub {
my $C = shift;
$C->arglist
})
} else { () }
}))) { ($C) } else { () }
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## token p5statement_control:if {
sub p5statement_control__S_029if__PEEK { $_[0]->_AUTOLEXpeek('p5statement_control__S_029if', $retree) }
sub p5statement_control__S_029if {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_control__S_029if");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'else'} = [];
$C->{'elsif'} = [];
$C->{'pblock'} = [];
$C->{'xblock'} = [];
$C->{sym} = "if";
$self->_MATCHIFYr($S, "p5statement_control__S_029if", do {
my $C = $C;
if (($C) = ($C->_SUBSUMEr(['sym'], sub {
my $C = shift;
$C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'p5statement_control__S_029if_0') {
$C->deb("Fate passed to p5statement_control__S_029if_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5statement_control__S_029if_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM p5statement_control__S_029if_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5statement_control__S_029if_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("p5statement_control__S_029if_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_EXACT("if")
},
sub {
my $C=shift;
$C->_EXACT("unless")
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
})
}))
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['xblock'], sub {
my $C = shift;
$C->xblock
}))
and ($C) = ($C->ws)
and ($C) = ($C->_STARr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->ws)
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
if (my ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->ws)) {
$C->_PATTERN(qr/\Gelse\s*+if/)
} else { () }
}))) { ($C) } else { () }
}))) { ($C) } else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->panic("Please use 'elsif'"))
and ($C) = ($C->ws)) {
$C
} else { () }

}
};
@gather;
}
}))
and ($C) = ($C->_EXACT("elsif"))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->spacey)) { ($C) } else { () }
}))
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['elsif','xblock'], sub {
my $C = shift;
$C->xblock
}))
and ($C) = ($C->ws)) {
$C
} else { () }
}))) { ($C) } else { () }
}))
and ($C) = ($C->ws)
and ($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->ws)
and ($C) = ($C->_EXACT("else"))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->spacey)) { ($C) } else { () }
}))
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['else','pblock'], sub {
my $C = shift;
$C->pblock
}))
and ($C) = ($C->ws)) {
$C
} else { () }
}))) { ($C) } else { () }
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## token p5statement_control:while {
sub p5statement_control__S_030while__PEEK { $_[0]->_AUTOLEXpeek('p5statement_control__S_030while', $retree) }
sub p5statement_control__S_030while {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_control__S_030while");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "while";
$self->_MATCHIFYr($S, "p5statement_control__S_030while", do {
my $C = $C;
if (($C) = ($C->_EXACT("while"))
and ($C) = ($C->spacey)
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['xblock'], sub {
my $C = shift;
$C->xblock
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## token p5statement_control:until {
sub p5statement_control__S_031until__PEEK { $_[0]->_AUTOLEXpeek('p5statement_control__S_031until', $retree) }
sub p5statement_control__S_031until {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_control__S_031until");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "until";
$self->_MATCHIFYr($S, "p5statement_control__S_031until", do {
my $C = $C;
if (($C) = ($C->_EXACT("until"))
and ($C) = ($C->spacey)
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['xblock'], sub {
my $C = shift;
$C->xblock
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## token p5statement_control:for {
sub p5statement_control__S_032for__PEEK { $_[0]->_AUTOLEXpeek('p5statement_control__S_032for', $retree) }
sub p5statement_control__S_032for {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_control__S_032for");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "for";
$self->_MATCHIFYr($S, "p5statement_control__S_032for", do {
my $C = $C;
if (($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'p5statement_control__S_032for_0') {
$C->deb("Fate passed to p5statement_control__S_032for_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5statement_control__S_032for_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM p5statement_control__S_032for_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5statement_control__S_032for_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("p5statement_control__S_032for_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_EXACT("for")
},
sub {
my $C=shift;
$C->_EXACT("foreach")
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))
and ($C) = ($C->ws)
and ($C) = ($C->_OPTr(sub {
my $C=shift;
$C->_SUBSUMEr(['eee'], sub {
my $C = shift;
$C->_PAREN( sub {
my $C=shift;
do {
my $C = $C;
if (($C) = ($C->_EXACT("\("))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = ($C->_OPTr(sub {
my $C=shift;
$C->_SUBSUMEr(['e1','EXPR'], sub {
my $C = shift;
$C->EXPR
})
}))
and ($C) = ($C->ws)
and ($C) = ($C->_EXACT("\;"))
and ($C) = ($C->ws)
and ($C) = ($C->_OPTr(sub {
my $C=shift;
$C->_SUBSUMEr(['e2','EXPR'], sub {
my $C = shift;
$C->EXPR
})
}))
and ($C) = ($C->ws)
and ($C) = ($C->_EXACT("\;"))
and ($C) = ($C->ws)
and ($C) = ($C->_OPTr(sub {
my $C=shift;
$C->_SUBSUMEr(['e3','EXPR'], sub {
my $C = shift;
$C->EXPR
})
}))
and ($C) = ($C->ws)) {
$C->_EXACT("\)")
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->panic("Malformed loop spec"))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
};

})
})
}))
and ($C) = ($C->ws)) {
$C->_SUBSUMEr(['block'], sub {
my $C = shift;
$C->block
})
} else { () }

});
}
;
## token p5statement_control:given {
sub p5statement_control__S_033given__PEEK { $_[0]->_AUTOLEXpeek('p5statement_control__S_033given', $retree) }
sub p5statement_control__S_033given {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_control__S_033given");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "given";
$self->_MATCHIFYr($S, "p5statement_control__S_033given", do {
my $C = $C;
if (($C) = ($C->_EXACT("given"))
and ($C) = ($C->spacey)
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['xblock'], sub {
my $C = shift;
$C->xblock
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## token p5statement_control:when {
sub p5statement_control__S_034when__PEEK { $_[0]->_AUTOLEXpeek('p5statement_control__S_034when', $retree) }
sub p5statement_control__S_034when {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_control__S_034when");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "when";
$self->_MATCHIFYr($S, "p5statement_control__S_034when", do {
my $C = $C;
if (($C) = ($C->_EXACT("when"))
and ($C) = ($C->spacey)
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['xblock'], sub {
my $C = shift;
$C->xblock
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## rule p5statement_control:default {<sym> <block> }
sub p5statement_control__S_035default__PEEK { $_[0]->_AUTOLEXpeek('p5statement_control__S_035default', $retree) }
sub p5statement_control__S_035default {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_control__S_035default");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "default";
$self->_MATCHIFYr($S, "p5statement_control__S_035default", do {
my $C = $C;
if (($C) = ($C->_EXACT("default"))
and ($C) = ($C->spacey)
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['block'], sub {
my $C = shift;
$C->block
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## rule p5statement_prefix:BEGIN    {<sym> <block> }
sub p5statement_prefix__S_036BEGIN__PEEK { $_[0]->_AUTOLEXpeek('p5statement_prefix__S_036BEGIN', $retree) }
sub p5statement_prefix__S_036BEGIN {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_prefix__S_036BEGIN");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "BEGIN";
$self->_MATCHIFYr($S, "p5statement_prefix__S_036BEGIN", do {
my $C = $C;
if (($C) = ($C->_EXACT("BEGIN"))
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['block'], sub {
my $C = shift;
$C->block
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## rule p5statement_prefix:CHECK    {<sym> <block> }
sub p5statement_prefix__S_037CHECK__PEEK { $_[0]->_AUTOLEXpeek('p5statement_prefix__S_037CHECK', $retree) }
sub p5statement_prefix__S_037CHECK {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_prefix__S_037CHECK");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "CHECK";
$self->_MATCHIFYr($S, "p5statement_prefix__S_037CHECK", do {
my $C = $C;
if (($C) = ($C->_EXACT("CHECK"))
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['block'], sub {
my $C = shift;
$C->block
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## rule p5statement_prefix:INIT     {<sym> <block> }
sub p5statement_prefix__S_038INIT__PEEK { $_[0]->_AUTOLEXpeek('p5statement_prefix__S_038INIT', $retree) }
sub p5statement_prefix__S_038INIT {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_prefix__S_038INIT");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "INIT";
$self->_MATCHIFYr($S, "p5statement_prefix__S_038INIT", do {
my $C = $C;
if (($C) = ($C->_EXACT("INIT"))
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['block'], sub {
my $C = shift;
$C->block
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## rule p5statement_control:END     {<sym> <block> }
sub p5statement_control__S_039END__PEEK { $_[0]->_AUTOLEXpeek('p5statement_control__S_039END', $retree) }
sub p5statement_control__S_039END {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_control__S_039END");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "END";
$self->_MATCHIFYr($S, "p5statement_control__S_039END", do {
my $C = $C;
if (($C) = ($C->_EXACT("END"))
and ($C) = ($C->spacey)
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['block'], sub {
my $C = shift;
$C->block
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## rule modifier_expr { <EXPR> }
sub modifier_expr__PEEK { $_[0]->_AUTOLEXpeek('modifier_expr', $retree) }
sub modifier_expr {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE modifier_expr");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "modifier_expr", do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['EXPR'], sub {
my $C = shift;
$C->EXPR
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## rule p5statement_mod_cond:if     {<sym> <modifier_expr> }
sub p5statement_mod_cond__S_040if__PEEK { $_[0]->_AUTOLEXpeek('p5statement_mod_cond__S_040if', $retree) }
sub p5statement_mod_cond__S_040if {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_mod_cond__S_040if");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "if";
$self->_MATCHIFYr($S, "p5statement_mod_cond__S_040if", do {
my $C = $C;
if (($C) = ($C->_EXACT("if"))
and ($C) = ($C->nofun)
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['modifier_expr'], sub {
my $C = shift;
$C->modifier_expr
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## rule p5statement_mod_cond:unless {<sym> <modifier_expr> }
sub p5statement_mod_cond__S_041unless__PEEK { $_[0]->_AUTOLEXpeek('p5statement_mod_cond__S_041unless', $retree) }
sub p5statement_mod_cond__S_041unless {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_mod_cond__S_041unless");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "unless";
$self->_MATCHIFYr($S, "p5statement_mod_cond__S_041unless", do {
my $C = $C;
if (($C) = ($C->_EXACT("unless"))
and ($C) = ($C->nofun)
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['modifier_expr'], sub {
my $C = shift;
$C->modifier_expr
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## rule p5statement_mod_cond:when   {<sym> <modifier_expr> }
sub p5statement_mod_cond__S_042when__PEEK { $_[0]->_AUTOLEXpeek('p5statement_mod_cond__S_042when', $retree) }
sub p5statement_mod_cond__S_042when {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_mod_cond__S_042when");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "when";
$self->_MATCHIFYr($S, "p5statement_mod_cond__S_042when", do {
my $C = $C;
if (($C) = ($C->_EXACT("when"))
and ($C) = ($C->nofun)
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['modifier_expr'], sub {
my $C = shift;
$C->modifier_expr
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## rule p5statement_mod_loop:while {<sym> <modifier_expr> }
sub p5statement_mod_loop__S_043while__PEEK { $_[0]->_AUTOLEXpeek('p5statement_mod_loop__S_043while', $retree) }
sub p5statement_mod_loop__S_043while {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_mod_loop__S_043while");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "while";
$self->_MATCHIFYr($S, "p5statement_mod_loop__S_043while", do {
my $C = $C;
if (($C) = ($C->_EXACT("while"))
and ($C) = ($C->nofun)
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['modifier_expr'], sub {
my $C = shift;
$C->modifier_expr
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## rule p5statement_mod_loop:until {<sym> <modifier_expr> }
sub p5statement_mod_loop__S_044until__PEEK { $_[0]->_AUTOLEXpeek('p5statement_mod_loop__S_044until', $retree) }
sub p5statement_mod_loop__S_044until {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_mod_loop__S_044until");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "until";
$self->_MATCHIFYr($S, "p5statement_mod_loop__S_044until", do {
my $C = $C;
if (($C) = ($C->_EXACT("until"))
and ($C) = ($C->nofun)
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['modifier_expr'], sub {
my $C = shift;
$C->modifier_expr
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## rule p5statement_mod_loop:for   {<sym> <modifier_expr> }
sub p5statement_mod_loop__S_045for__PEEK { $_[0]->_AUTOLEXpeek('p5statement_mod_loop__S_045for', $retree) }
sub p5statement_mod_loop__S_045for {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_mod_loop__S_045for");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "for";
$self->_MATCHIFYr($S, "p5statement_mod_loop__S_045for", do {
my $C = $C;
if (($C) = ($C->_EXACT("for"))
and ($C) = ($C->nofun)
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['modifier_expr'], sub {
my $C = shift;
$C->modifier_expr
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## rule p5statement_mod_loop:given {<sym> <modifier_expr> }
sub p5statement_mod_loop__S_046given__PEEK { $_[0]->_AUTOLEXpeek('p5statement_mod_loop__S_046given', $retree) }
sub p5statement_mod_loop__S_046given {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_mod_loop__S_046given");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "given";
$self->_MATCHIFYr($S, "p5statement_mod_loop__S_046given", do {
my $C = $C;
if (($C) = ($C->_EXACT("given"))
and ($C) = ($C->nofun)
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['modifier_expr'], sub {
my $C = shift;
$C->modifier_expr
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## token def_module_name {
sub def_module_name__PEEK { $_[0]->_AUTOLEXpeek('def_module_name', $retree) }
sub def_module_name {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE def_module_name");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'signature'} = [];
$self->_MATCHIFYr($S, "def_module_name", do {
if (my ($C) = ($C->_SUBSUMEr(['longname'], sub {
my $C = shift;
$C->longname
}))) {
$C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\[")
}))) { ($C) } else { () }
}))
and ($C) = ($C->before(sub {
my $C=shift;
(($C) x !!do {
($::PKGDECL//'') eq 'role' })
}))
and ($C) = ($C->newlex)
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\]";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\["))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['signature'], sub {
my $C = shift;
$C->signature
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\]")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'generic role', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))
and ($C) = (scalar(do {
$::IN_DECL = 0}, $C))
and ($C) = ($C->finishlex)) {
$C
} else { () }
}))) { ($C) } else { () }
})
} else { () }

});
}
;
## token p5module_name:normal {
sub p5module_name__S_047normal__PEEK { $_[0]->_AUTOLEXpeek('p5module_name__S_047normal', $retree) }
sub p5module_name__S_047normal {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5module_name__S_047normal");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'arglist'} = [];
$C->{sym} = "normal";
$self->_MATCHIFYr($S, "p5module_name__S_047normal", do {
if (my ($C) = ($C->_SUBSUMEr(['longname'], sub {
my $C = shift;
$C->longname
}))) {
$C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\[")
}))) { ($C) } else { () }
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\]";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\["))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['arglist'], sub {
my $C = shift;
$C->arglist
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\]")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'generic role', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) {
$C
} else { () }
}))) { ($C) } else { () }
})
} else { () }

});
}
;
## token vnum {
sub vnum__PEEK { $_[0]->_AUTOLEXpeek('vnum', $retree) }
sub vnum {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE vnum");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "vnum", do {
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'vnum_0') {
$C->deb("Fate passed to vnum_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT vnum_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM vnum_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'vnum_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("vnum_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_PATTERN(qr/\G\d++/)
},
sub {
my $C=shift;
$C->_EXACT("\*")
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};

});
}
;
## token p5version:sym<v> {
sub p5version__S_048v__PEEK { $_[0]->_AUTOLEXpeek('p5version__S_048v', $retree) }
sub p5version__S_048v {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5version__S_048v");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'vnum'} = [];
$C->{sym} = "v";
$self->_MATCHIFYr($S, "p5version__S_048v", do {
my $C = $C;
if (($C) = ($C->_EXACT("v"))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G\d++/)
}))) { ($C) } else { () }
}))
and ($C) = ($C->_COMMITLTM())
and ($C) = ($C->_REPSEPr( sub {
my $C=shift;
$C->_EXACT("\.")
}, sub {
my $C=shift;
$C->_SUBSUMEr(['vnum'], sub {
my $C = shift;
$C->vnum
})
}))) {
$C->_PATTERN(qr/\G\+?+/)
} else { () }

});
}
;
## token variable_declarator {
sub variable_declarator__PEEK { $_[0]->_AUTOLEXpeek('variable_declarator', $retree) }
sub variable_declarator {
no warnings 'recursion';
my $self = shift;

local $::IN_DECL = 1;local $::DECLARAND;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE variable_declarator");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'p5postcircumfix'} = [];
$C->{'postcircumfix'} = [];
$C->{'semilist'} = [];
$C->{'shape'} = [];
$C->{'signature'} = [];
$C->{'trait'} = [];
$self->_MATCHIFYr($S, "variable_declarator", do {
my $C = $C;
if (($C) = ($C->_SUBSUMEr(['variable'], sub {
my $C = shift;
$C->variable
}))
and ($C) = (scalar(do {
my $M = $C;
$::IN_DECL = 0;
$C->add_variable($M->{'variable'}->Str) ;
}, $C))
and ($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (my ($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->unsp)) { ($C) } else { () }
}))) {
$C->_STARr(sub {
my $C=shift;
$C->_SUBSUMEr(['shape'], sub {
my $C = shift;
$C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'variable_declarator_0') {
$C->deb("Fate passed to variable_declarator_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT variable_declarator_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM variable_declarator_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'variable_declarator_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("variable_declarator_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\)";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\("))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['signature'], sub {
my $C = shift;
$C->signature
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\)")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'variable_declarator', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) { ($C) } else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\]";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\["))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['semilist'], sub {
my $C = shift;
$C->semilist
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\]")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'shape definition', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) { ($C) } else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\}";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\{"))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['semilist'], sub {
my $C = shift;
$C->semilist
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\}")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'shape definition', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) { ($C) } else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\<")
}))) { ($C) } else { () }
}))) {
$C->_SUBSUMEr(['postcircumfix','p5postcircumfix'], sub {
my $C = shift;
$C->p5postcircumfix
})
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
})
})
})
} else { () }
}))) { ($C) } else { () }
}))
and ($C) = ($C->ws)) {
$C->_STARr(sub {
my $C=shift;
$C->_SUBSUMEr(['trait'], sub {
my $C = shift;
$C->trait
})
})
} else { () }

});
}
;
## rule scoped($*SCOPE) {
sub scoped__PEEK { $_[0]->_AUTOLEXpeek('scoped', $retree) }
sub scoped {
no warnings 'recursion';
my $self = shift;

die 'Required argument SCOPE omitted' unless @_;
local $::SCOPE = @_ ? shift() : undef;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE scoped");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "scoped", do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'scoped_0') {
$C->deb("Fate passed to scoped_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT scoped_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM scoped_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'scoped_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("scoped_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (($C) = ($C->_SUBSUMEr(['declarator'], sub {
my $C = shift;
$C->declarator
}))
and ($C) = ($C->ws)) {
$C
} else { () }
},
sub {
my $C=shift;
if (($C) = ($C->_SUBSUMEr(['regex_declarator','p5regex_declarator'], sub {
my $C = shift;
$C->p5regex_declarator
}))
and ($C) = ($C->ws)) {
$C
} else { () }
},
sub {
my $C=shift;
if (($C) = ($C->_SUBSUMEr(['package_declarator','p5package_declarator'], sub {
my $C = shift;
$C->p5package_declarator
}))
and ($C) = ($C->ws)) {
$C
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->ws)) {
$C->_PATTERN(qr/\G[A-Z]/)
} else { () }
}))) { ($C) } else { () }
}))
and ($C) = ($C->_SUBSUMEr(['longname'], sub {
my $C = shift;
$C->longname
}))
and ($C) = (scalar(do {
my $M = $C;
{
my $t = $M->{'longname'}->Str;
if (not $C->is_known($t)) {
$C->sorry("In \"$::SCOPE\" declaration, typename $t must be predeclared (or marked as declarative with :: prefix)")};
}}, $C))
and ($C) = ($C->ws)
and ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
$C
}))) {
$C
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = ($C->panic("Malformed $::SCOPE"))
and ($C) = ($C->ws)) {
$C
} else { () }

}
};
@gather;
});
}
;
## token p5scope_declarator:my        { <sym> <scoped('my')> }
sub p5scope_declarator__S_049my__PEEK { $_[0]->_AUTOLEXpeek('p5scope_declarator__S_049my', $retree) }
sub p5scope_declarator__S_049my {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5scope_declarator__S_049my");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "my";
$self->_MATCHIFYr($S, "p5scope_declarator__S_049my", do {
my $C = $C;
if (($C) = ($C->_EXACT("my"))
and ($C) = ($C->nofun)) {
$C->_SUBSUMEr(['scoped'], sub {
my $C = shift;
$C->scoped('my')
})
} else { () }

});
}
;
## token p5scope_declarator:our       { <sym> <scoped('our')> }
sub p5scope_declarator__S_050our__PEEK { $_[0]->_AUTOLEXpeek('p5scope_declarator__S_050our', $retree) }
sub p5scope_declarator__S_050our {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5scope_declarator__S_050our");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "our";
$self->_MATCHIFYr($S, "p5scope_declarator__S_050our", do {
my $C = $C;
if (($C) = ($C->_EXACT("our"))
and ($C) = ($C->nofun)) {
$C->_SUBSUMEr(['scoped'], sub {
my $C = shift;
$C->scoped('our')
})
} else { () }

});
}
;
## token p5scope_declarator:state     { <sym> <scoped('state')> }
sub p5scope_declarator__S_051state__PEEK { $_[0]->_AUTOLEXpeek('p5scope_declarator__S_051state', $retree) }
sub p5scope_declarator__S_051state {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5scope_declarator__S_051state");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "state";
$self->_MATCHIFYr($S, "p5scope_declarator__S_051state", do {
my $C = $C;
if (($C) = ($C->_EXACT("state"))
and ($C) = ($C->nofun)) {
$C->_SUBSUMEr(['scoped'], sub {
my $C = shift;
$C->scoped('state')
})
} else { () }

});
}
;
## token p5package_declarator:package {
sub p5package_declarator__S_052package__PEEK { $_[0]->_AUTOLEXpeek('p5package_declarator__S_052package', $retree) }
sub p5package_declarator__S_052package {
no warnings 'recursion';
my $self = shift;

;
local $::PKGDECL = 'package';
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5package_declarator__S_052package");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "package";
$self->_MATCHIFYr($S, "p5package_declarator__S_052package", do {
my $C = $C;
if (($C) = ($C->_EXACT("package"))
and ($C) = ($C->spacey)) {
$C->_SUBSUMEr(['package_def'], sub {
my $C = shift;
$C->package_def
})
} else { () }

});
}
;
## token p5package_declarator:require {   # here because of declarational aspects
sub p5package_declarator__S_053require__PEEK { $_[0]->_AUTOLEXpeek('p5package_declarator__S_053require', $retree) }
sub p5package_declarator__S_053require {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5package_declarator__S_053require");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'EXPR'} = [];
$C->{sym} = "require";
$self->_MATCHIFYr($S, "p5package_declarator__S_053require", do {
my $C = $C;
if (($C) = ($C->_EXACT("require"))
and ($C) = ($C->spacey)
and ($C) = ($C->ws)
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
if (my ($C) = ($C->_SUBSUMEr(['module_name','p5module_name'], sub {
my $C = shift;
$C->p5module_name
}))) {
$C->_OPTr(sub {
my $C=shift;
$C->_SUBSUMEr(['EXPR'], sub {
my $C = shift;
$C->EXPR
})
})
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, $C->_SUBSUMEr(['EXPR'], sub {
my $C = shift;
$C->EXPR
})
};
@gather;
}
}))) {
$C
} else { () }

});
}
;
## rule package_def {
sub package_def__PEEK { $_[0]->_AUTOLEXpeek('package_def', $retree) }
sub package_def {
no warnings 'recursion';
my $self = shift;

my $longname;local $::IN_DECL = 1;local $::DECLARAND;local $::NEWPKG;local $::NEWLEX;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE package_def");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'def_module_name'} = [];
$self->_MATCHIFYr($S, "package_def", do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = (scalar(do {
$::SCOPE ||= 'our'}, $C))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['def_module_name'], sub {
my $C = shift;
$C->def_module_name
}))
and ($C) = (scalar(do {
my $M = $C;
$longname = $M->{'def_module_name'}->[0]->{'longname'};
$C->add_name($longname->Str);
}, $C))
and ($C) = ($C->ws)) {
$C
} else { () }
}))) { ($C) } else { () }
}))
and ($C) = ($C->ws)
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->ws)) {
$C->_EXACT("\;")
} else { () }
}))) { ($C) } else { () }
}))) {
scalar(do {
{
$longname  or  $C->panic("Package cannot be anonymous");
my $shortname = $longname->{'name'}->Str;
$::CURPKG = $::NEWPKG // $::CURPKG->{$shortname . '::'};
}}, $C)
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->panic("Unable to parse " . $::PKGDECL . " definition"))
and ($C) = ($C->ws)) {
$C
} else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) {
$C
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = ($C->panic("Malformed $::PKGDECL"))
and ($C) = ($C->ws)) {
$C
} else { () }

}
};
@gather;
});
}
;
## token declarator {
sub declarator__PEEK { $_[0]->_AUTOLEXpeek('declarator', $retree) }
sub declarator {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE declarator");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'trait'} = [];
$self->_MATCHIFYr($S, "declarator", $C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'declarator_0') {
$C->deb("Fate passed to declarator_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT declarator_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM declarator_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'declarator_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("declarator_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_SUBSUMEr(['constant_declarator'], sub {
my $C = shift;
$C->constant_declarator
})
},
sub {
my $C=shift;
$C->_SUBSUMEr(['variable_declarator'], sub {
my $C = shift;
$C->variable_declarator
})
},
sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\)";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\("))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['signature'], sub {
my $C = shift;
$C->signature
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\)")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'declarator', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) {
$C->_STARr(sub {
my $C=shift;
$C->_SUBSUMEr(['trait'], sub {
my $C = shift;
$C->trait
})
})
} else { () }
},
sub {
my $C=shift;
$C->_SUBSUMEr(['routine_declarator','p5routine_declarator'], sub {
my $C = shift;
$C->p5routine_declarator
})
},
sub {
my $C=shift;
$C->_SUBSUMEr(['regex_declarator','p5regex_declarator'], sub {
my $C = shift;
$C->p5regex_declarator
})
},
sub {
my $C=shift;
$C->_SUBSUMEr(['type_declarator','p5type_declarator'], sub {
my $C = shift;
$C->p5type_declarator
})
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}));
}
;
## token p5multi_declarator:null {
sub p5multi_declarator__S_054null__PEEK { $_[0]->_AUTOLEXpeek('p5multi_declarator__S_054null', $retree) }
sub p5multi_declarator__S_054null {
no warnings 'recursion';
my $self = shift;

local $::MULTINESS = '';
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5multi_declarator__S_054null");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "null";
$self->_MATCHIFYr($S, "p5multi_declarator__S_054null", $C->_SUBSUMEr(['declarator'], sub {
my $C = shift;
$C->declarator
}));
}
;
## token p5routine_declarator:sub       { <sym> <routine_def> }
sub p5routine_declarator__S_055sub__PEEK { $_[0]->_AUTOLEXpeek('p5routine_declarator__S_055sub', $retree) }
sub p5routine_declarator__S_055sub {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5routine_declarator__S_055sub");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "sub";
$self->_MATCHIFYr($S, "p5routine_declarator__S_055sub", do {
my $C = $C;
if (($C) = ($C->_EXACT("sub"))
and ($C) = ($C->nofun)) {
$C->_SUBSUMEr(['routine_def'], sub {
my $C = shift;
$C->routine_def
})
} else { () }

});
}
;
## rule parensig {
sub parensig__PEEK { $_[0]->_AUTOLEXpeek('parensig', $retree) }
sub parensig {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE parensig");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "parensig", do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\)";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\("))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['signature'], sub {
my $C = shift;
$C->signature(1)
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\)")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'signature', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## method checkyada
sub checkyada {
no warnings 'recursion';
my $self = shift;
eval {
my $startsym = $self->{'blockoid'}->{'statementlist'}->{'statement'}->[0]->{'EXPR'}->{'term'}->{'sym'} // '';
if ($startsym eq '...' or $startsym eq '!!!' or $startsym eq '???') {
$::DECLARAND->{'stub'} = 1};
};
return $self;
};
## rule routine_def () {
sub routine_def__PEEK { $_[0]->_AUTOLEXpeek('routine_def', $retree) }
sub routine_def {
no warnings 'recursion';
my $self = shift;

local $::CURLEX = $::CURLEX;local $::IN_DECL = 1;local $::DECLARAND;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE routine_def");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'deflongname'} = [];
$C->{'parensig'} = [];
$C->{'trait'} = [];
$self->_MATCHIFYr($S, "routine_def", do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'routine_def_0') {
$C->deb("Fate passed to routine_def_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT routine_def_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM routine_def_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'routine_def_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("routine_def_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (($C) = ($C->ws)
and ($C) = ($C->_EXACT("\&"))
and ($C) = ($C->_OPTr(sub {
my $C=shift;
$C->_SUBSUMEr(['deflongname'], sub {
my $C = shift;
$C->deflongname
})
}))
and ($C) = ($C->ws)) {
$C
} else { () }
},
sub {
my $C=shift;
if (($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['deflongname'], sub {
my $C = shift;
$C->deflongname
}))
and ($C) = ($C->ws)) {
$C
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) { ($C) } else { () }
}))
and ($C) = ($C->ws)
and ($C) = ($C->newlex(1))
and ($C) = ($C->ws)
and ($C) = ($C->_OPTr(sub {
my $C=shift;
$C->_SUBSUMEr(['parensig'], sub {
my $C = shift;
$C->parensig
})
}))
and ($C) = ($C->ws)
and ($C) = ($C->_STARr(sub {
my $C=shift;
$C->_SUBSUMEr(['trait'], sub {
my $C = shift;
$C->trait
})
}))
and ($C) = ($C->ws)
and ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
(($C) x !!do {
$::IN_DECL = 0})
}))
and ($C) = ($C->_SUBSUMEr(['blockoid'], sub {
my $C = shift;
$C->blockoid
}))
and ($C) = ($C->checkyada)
and ($C) = ($C->getsig)) {
$C
} else { () }
}))
and ($C) = ($C->ws)) {
$C
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = ($C->panic("Malformed routine"))
and ($C) = ($C->ws)) {
$C
} else { () }

}
};
@gather;
});
}
;
## rule trait {
sub trait__PEEK { $_[0]->_AUTOLEXpeek('trait', $retree) }
sub trait {
no warnings 'recursion';
my $self = shift;

local $::IN_DECL = 0;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE trait");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "trait", do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = ($C->_EXACT("\:"))
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['EXPR'], sub {
my $C = shift;
$C->EXPR(\%comma)
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## token nullterm {
sub nullterm__PEEK { $_[0]->_AUTOLEXpeek('nullterm', $retree) }
sub nullterm {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE nullterm");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "nullterm", $C->before(sub {
my $C=shift;
$C
}));
}
;
## token nulltermish {
sub nulltermish__PEEK { $_[0]->_AUTOLEXpeek('nulltermish', $retree) }
sub nulltermish {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE nulltermish");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "nulltermish", $C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'nulltermish_0') {
$C->deb("Fate passed to nulltermish_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT nulltermish_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM nulltermish_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'nulltermish_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("nulltermish_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->stdstopper)) { ($C) } else { () }
}))) { ($C) } else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->_SUBSUMEr(['term','termish'], sub {
my $C = shift;
$C->termish
}))) {
scalar(do {
my $M = $C;
$C->{'PRE'}  = delete $M->{'term'}->{'PRE'};
$C->{'POST'} = delete $M->{'term'}->{'POST'};
$C->{'~CAPS'} = $M->{'term'}->{'~CAPS'};
}, $C)
} else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C
}))) { ($C) } else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}));
}
;
## token termish {
sub termish__PEEK { $_[0]->_AUTOLEXpeek('termish', $retree) }
sub termish {
no warnings 'recursion';
my $self = shift;

local $::SCOPE = "";local $::VAR;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE termish");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'POST'} = [];
$C->{'PRE'} = [];
$self->_MATCHIFYr($S, "termish", do {
my $C = $C;
if (($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'termish_0') {
$C->deb("Fate passed to termish_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT termish_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM termish_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'termish_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("termish_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (($C) = ($C->_SUBSUMEr(['PRE'], sub {
my $C = shift;
$C->PRE
}))
and ($C) = ($C->_STARr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (my ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
(($C) x !!do {
my $M = $C;
my $p = $M->{'PRE'};
my @p = @$p;
$p[-1]->{'O'}->{'term'} and $M->{'term'} = pop @$p ;
})
}))) {
$C->_SUBSUMEr(['PRE'], sub {
my $C = shift;
$C->PRE
})
} else { () }
}))) { ($C) } else { () }
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
if (my ($C) = ($C->before(sub {
my $C=shift;
(($C) x !!do {
my $M = $C;
$M->{'term'} })
}))) { ($C) } else { () }

}
}
or $xact->[-2] or
do {
push @gather, $C->_SUBSUMEr(['term'], sub {
my $C = shift;
$C->term
})
};
@gather;
}
}))) {
$C
} else { () }
},
sub {
my $C=shift;
$C->_SUBSUMEr(['term','p5term'], sub {
my $C = shift;
$C->p5term
})
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->before(sub {
my $C=shift;
(($C) x !!do {
$::QSIGIL })
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
if (my ($C) = ($C->before(sub {
my $C=shift;
(($C) x !!do {
$::QSIGIL eq '$' })
}))) {
$C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
STD::LazyMap::lazymap(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->after(sub {
my $C=shift;
$C->_PATTERN(qr/\G(?<=[\]}>)])/)
}))) { ($C) } else { () }
}))) { ($C) } else { () }
},
$C->_PLUSg(sub {
my $C=shift;
$C->_SUBSUMEr(['POST'], sub {
my $C = shift;
$C->POST
})
}))
}))) { ($C) } else { () }
})
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = (STD::LazyMap::lazymap(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->after(sub {
my $C=shift;
$C->_PATTERN(qr/\G(?<=[\]}>)])/)
}))) { ($C) } else { () }
}))) { ($C) } else { () }
},
$C->_PLUSg(sub {
my $C=shift;
$C->_SUBSUMEr(['POST'], sub {
my $C = shift;
$C->POST
})
})))) { ($C) } else { () }

}
}
or $xact->[-2] or
do {
push @gather, scalar(do {
$::VAR = 0}, $C)
};
@gather;
}
}))) {
$C
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
(($C) x !!do {
$::QSIGIL })
}))) {
$C->_STARr(sub {
my $C=shift;
$C->_SUBSUMEr(['POST'], sub {
my $C = shift;
$C->POST
})
})
} else { () }

}
};
@gather;
}
}))) {
scalar(do {
my $M = $C;
$self->check_variable($::VAR) if $::VAR;
$C->{'~CAPS'} = $M->{'term'}->{'~CAPS'};
}, $C)
} else { () }

});
}
;
## token p5term:fatarrow           { <fatarrow> }
sub p5term__S_056fatarrow__PEEK { $_[0]->_AUTOLEXpeek('p5term__S_056fatarrow', $retree) }
sub p5term__S_056fatarrow {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5term__S_056fatarrow");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "fatarrow";
$self->_MATCHIFYr($S, "p5term__S_056fatarrow", $C->_SUBSUMEr(['fatarrow'], sub {
my $C = shift;
$C->fatarrow
}));
}
;
## token p5term:variable           { <variable> { $*VAR = $<variable> } }
sub p5term__S_057variable__PEEK { $_[0]->_AUTOLEXpeek('p5term__S_057variable', $retree) }
sub p5term__S_057variable {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5term__S_057variable");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "variable";
$self->_MATCHIFYr($S, "p5term__S_057variable", do {
if (my ($C) = ($C->_SUBSUMEr(['variable'], sub {
my $C = shift;
$C->variable
}))) {
scalar(do {
my $M = $C;
$::VAR = $M->{'variable'} }, $C)
} else { () }

});
}
;
## token p5term:package_declarator { <package_declarator=p5package_declarator> }
sub p5term__S_058package_declarator__PEEK { $_[0]->_AUTOLEXpeek('p5term__S_058package_declarator', $retree) }
sub p5term__S_058package_declarator {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5term__S_058package_declarator");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "package_declarator";
$self->_MATCHIFYr($S, "p5term__S_058package_declarator", $C->_SUBSUMEr(['package_declarator','p5package_declarator'], sub {
my $C = shift;
$C->p5package_declarator
}));
}
;
## token p5term:scope_declarator   { <scope_declarator=p5scope_declarator> }
sub p5term__S_059scope_declarator__PEEK { $_[0]->_AUTOLEXpeek('p5term__S_059scope_declarator', $retree) }
sub p5term__S_059scope_declarator {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5term__S_059scope_declarator");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "scope_declarator";
$self->_MATCHIFYr($S, "p5term__S_059scope_declarator", $C->_SUBSUMEr(['scope_declarator','p5scope_declarator'], sub {
my $C = shift;
$C->p5scope_declarator
}));
}
;
## token p5term:routine_declarator { <routine_declarator=p5routine_declarator> }
sub p5term__S_060routine_declarator__PEEK { $_[0]->_AUTOLEXpeek('p5term__S_060routine_declarator', $retree) }
sub p5term__S_060routine_declarator {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5term__S_060routine_declarator");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "routine_declarator";
$self->_MATCHIFYr($S, "p5term__S_060routine_declarator", $C->_SUBSUMEr(['routine_declarator','p5routine_declarator'], sub {
my $C = shift;
$C->p5routine_declarator
}));
}
;
## token p5term:circumfix          { <circumfix=p5circumfix> }
sub p5term__S_061circumfix__PEEK { $_[0]->_AUTOLEXpeek('p5term__S_061circumfix', $retree) }
sub p5term__S_061circumfix {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5term__S_061circumfix");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "circumfix";
$self->_MATCHIFYr($S, "p5term__S_061circumfix", $C->_SUBSUMEr(['circumfix','p5circumfix'], sub {
my $C = shift;
$C->p5circumfix
}));
}
;
## token p5term:dotty              { <dotty=p5dotty> }
sub p5term__S_062dotty__PEEK { $_[0]->_AUTOLEXpeek('p5term__S_062dotty', $retree) }
sub p5term__S_062dotty {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5term__S_062dotty");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "dotty";
$self->_MATCHIFYr($S, "p5term__S_062dotty", $C->_SUBSUMEr(['dotty','p5dotty'], sub {
my $C = shift;
$C->p5dotty
}));
}
;
## token p5term:value              { <value=p5value> }
sub p5term__S_063value__PEEK { $_[0]->_AUTOLEXpeek('p5term__S_063value', $retree) }
sub p5term__S_063value {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5term__S_063value");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "value";
$self->_MATCHIFYr($S, "p5term__S_063value", $C->_SUBSUMEr(['value','p5value'], sub {
my $C = shift;
$C->p5value
}));
}
;
## token p5term:capterm            { <capterm> }
sub p5term__S_064capterm__PEEK { $_[0]->_AUTOLEXpeek('p5term__S_064capterm', $retree) }
sub p5term__S_064capterm {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5term__S_064capterm");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "capterm";
$self->_MATCHIFYr($S, "p5term__S_064capterm", $C->_SUBSUMEr(['capterm'], sub {
my $C = shift;
$C->capterm
}));
}
;
## token p5term:statement_prefix   { <statement_prefix=p5statement_prefix> }
sub p5term__S_065statement_prefix__PEEK { $_[0]->_AUTOLEXpeek('p5term__S_065statement_prefix', $retree) }
sub p5term__S_065statement_prefix {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5term__S_065statement_prefix");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "statement_prefix";
$self->_MATCHIFYr($S, "p5term__S_065statement_prefix", $C->_SUBSUMEr(['statement_prefix','p5statement_prefix'], sub {
my $C = shift;
$C->p5statement_prefix
}));
}
;
## token fatarrow {
sub fatarrow__PEEK { $_[0]->_AUTOLEXpeek('fatarrow', $retree) }
sub fatarrow {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE fatarrow");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "fatarrow", do {
my $C = $C;
if (($C) = ($C->_SUBSUMEr(['key','identifier'], sub {
my $C = shift;
$C->identifier
}))
and ($C) = ($C->_PATTERN(qr/\G[\x20\t\r]*+\=\>/))
and ($C) = ($C->ws)) {
$C->_SUBSUMEr(['val','EXPR'], sub {
my $C = shift;
$C->EXPR(\%assignment)
})
} else { () }

});
}
;
## token p5special_variable:sym<$!> { <sym> <!before \w> }
sub p5special_variable__S_066DollarBang__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_066DollarBang', $retree) }
sub p5special_variable__S_066DollarBang {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_066DollarBang");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\!";
$self->_MATCHIFYr($S, "p5special_variable__S_066DollarBang", do {
my $C = $C;
if (($C) = ($C->_EXACT("\$\!"))
and ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G\w/)
}))) { ($C) } else { () }
}))) {
$C
} else { () }

});
}
;
## token p5special_variable:sym<$!{ }> {
sub p5special_variable__S_067DollarBangCur_Ly__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_067DollarBangCur_Ly', $retree) }
sub p5special_variable__S_067DollarBangCur_Ly {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_067DollarBangCur_Ly");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\!\{\ \}";
$self->_MATCHIFYr($S, "p5special_variable__S_067DollarBangCur_Ly", $C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\}";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\$\!\{"))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['EXPR'], sub {
my $C = shift;
$C->EXPR
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\}")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'p5special_variable', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}));
}
;
## token p5special_variable:sym<$/> {
sub p5special_variable__S_068DollarSlash__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_068DollarSlash', $retree) }
sub p5special_variable__S_068DollarSlash {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_068DollarSlash");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\/";
$self->_MATCHIFYr($S, "p5special_variable__S_068DollarSlash", $C->_EXACT("\$\/"));
}
;
## token p5special_variable:sym<$~> {
sub p5special_variable__S_069DollarTilde__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_069DollarTilde', $retree) }
sub p5special_variable__S_069DollarTilde {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_069DollarTilde");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\~";
$self->_MATCHIFYr($S, "p5special_variable__S_069DollarTilde", $C->_EXACT("\$\~"));
}
;
## token p5special_variable:sym<$`> {
sub p5special_variable__S_070DollarGrave__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_070DollarGrave', $retree) }
sub p5special_variable__S_070DollarGrave {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_070DollarGrave");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\`";
$self->_MATCHIFYr($S, "p5special_variable__S_070DollarGrave", $C->_EXACT("\$\`"));
}
;
## token p5special_variable:sym<$@> {
sub p5special_variable__S_071DollarAt__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_071DollarAt', $retree) }
sub p5special_variable__S_071DollarAt {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_071DollarAt");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\@";
$self->_MATCHIFYr($S, "p5special_variable__S_071DollarAt", $C->_EXACT("\$\@"));
}
;
## token p5special_variable:sym<$#> {
sub p5special_variable__S_072DollarSharp__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_072DollarSharp', $retree) }
sub p5special_variable__S_072DollarSharp {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_072DollarSharp");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\#";
$self->_MATCHIFYr($S, "p5special_variable__S_072DollarSharp", $C->_EXACT("\$\#"));
}
;
## token p5special_variable:sym<$$> {
sub p5special_variable__S_073DollarDollar__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_073DollarDollar', $retree) }
sub p5special_variable__S_073DollarDollar {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_073DollarDollar");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\$";
$self->_MATCHIFYr($S, "p5special_variable__S_073DollarDollar", do {
my $C = $C;
if (($C) = ($C->_EXACT("\$\$"))
and ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
$C->_PATTERN(qr/\G[_[:alpha:]]/)
}))) {
$C
} else { () }

});
}
;
## token p5special_variable:sym<$%> {
sub p5special_variable__S_074DollarPercent__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_074DollarPercent', $retree) }
sub p5special_variable__S_074DollarPercent {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_074DollarPercent");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\%";
$self->_MATCHIFYr($S, "p5special_variable__S_074DollarPercent", $C->_EXACT("\$\%"));
}
;
## token p5special_variable:sym<$^X> {
sub p5special_variable__S_075DollarCaretX__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_075DollarCaretX', $retree) }
sub p5special_variable__S_075DollarCaretX {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_075DollarCaretX");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\^X";
$self->_MATCHIFYr($S, "p5special_variable__S_075DollarCaretX", do {
my $C = $C;
if (($C) = ($C->_SUBSUMEr(['sigil','p5sigil'], sub {
my $C = shift;
$C->p5sigil
}))
and ($C) = ($C->_EXACT("\^"))
and ($C) = ($C->_SUBSUMEr(['letter'], sub {
my $C = shift;
$C->_BRACKETr(sub {
my $C=shift;
$C->_PATTERN(qr/\G[A-Z]/)
})
}))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G\W/)
}))) { ($C) } else { () }
}))) {
$C
} else { () }

});
}
;
## token p5special_variable:sym<$^> {
sub p5special_variable__S_076DollarCaret__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_076DollarCaret', $retree) }
sub p5special_variable__S_076DollarCaret {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_076DollarCaret");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\^";
$self->_MATCHIFYr($S, "p5special_variable__S_076DollarCaret", $C->_EXACT("\$\^"));
}
;
## token p5special_variable:sym<$&> {
sub p5special_variable__S_077DollarAmp__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_077DollarAmp', $retree) }
sub p5special_variable__S_077DollarAmp {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_077DollarAmp");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\&";
$self->_MATCHIFYr($S, "p5special_variable__S_077DollarAmp", $C->_EXACT("\$\&"));
}
;
## token p5special_variable:sym<$*> {
sub p5special_variable__S_078DollarStar__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_078DollarStar', $retree) }
sub p5special_variable__S_078DollarStar {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_078DollarStar");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\*";
$self->_MATCHIFYr($S, "p5special_variable__S_078DollarStar", $C->_EXACT("\$\*"));
}
;
## token p5special_variable:sym<$)> {
sub p5special_variable__S_079DollarThesis__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_079DollarThesis', $retree) }
sub p5special_variable__S_079DollarThesis {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_079DollarThesis");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\)";
$self->_MATCHIFYr($S, "p5special_variable__S_079DollarThesis", $C->_EXACT("\$\)"));
}
;
## token p5special_variable:sym<$-> {
sub p5special_variable__S_080DollarMinus__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_080DollarMinus', $retree) }
sub p5special_variable__S_080DollarMinus {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_080DollarMinus");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\-";
$self->_MATCHIFYr($S, "p5special_variable__S_080DollarMinus", $C->_EXACT("\$\-"));
}
;
## token p5special_variable:sym<$=> {
sub p5special_variable__S_081DollarEqual__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_081DollarEqual', $retree) }
sub p5special_variable__S_081DollarEqual {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_081DollarEqual");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\=";
$self->_MATCHIFYr($S, "p5special_variable__S_081DollarEqual", $C->_EXACT("\$\="));
}
;
## token p5special_variable:sym<@+> {
sub p5special_variable__S_082AtPlus__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_082AtPlus', $retree) }
sub p5special_variable__S_082AtPlus {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_082AtPlus");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\@\+";
$self->_MATCHIFYr($S, "p5special_variable__S_082AtPlus", $C->_EXACT("\@\+"));
}
;
## token p5special_variable:sym<%+> {
sub p5special_variable__S_083PercentPlus__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_083PercentPlus', $retree) }
sub p5special_variable__S_083PercentPlus {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_083PercentPlus");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\%\+";
$self->_MATCHIFYr($S, "p5special_variable__S_083PercentPlus", $C->_EXACT("\%\+"));
}
;
## token p5special_variable:sym<$+[ ]> {
sub p5special_variable__S_084DollarPlusBra_Ket__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_084DollarPlusBra_Ket', $retree) }
sub p5special_variable__S_084DollarPlusBra_Ket {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_084DollarPlusBra_Ket");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\+\[\ \]";
$self->_MATCHIFYr($S, "p5special_variable__S_084DollarPlusBra_Ket", $C->_EXACT("\$\+\["));
}
;
## token p5special_variable:sym<@+[ ]> {
sub p5special_variable__S_085AtPlusBra_Ket__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_085AtPlusBra_Ket', $retree) }
sub p5special_variable__S_085AtPlusBra_Ket {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_085AtPlusBra_Ket");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\@\+\[\ \]";
$self->_MATCHIFYr($S, "p5special_variable__S_085AtPlusBra_Ket", $C->_EXACT("\@\+\["));
}
;
## token p5special_variable:sym<@+{ }> {
sub p5special_variable__S_086AtPlusCur_Ly__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_086AtPlusCur_Ly', $retree) }
sub p5special_variable__S_086AtPlusCur_Ly {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_086AtPlusCur_Ly");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\@\+\{\ \}";
$self->_MATCHIFYr($S, "p5special_variable__S_086AtPlusCur_Ly", $C->_EXACT("\@\+\{"));
}
;
## token p5special_variable:sym<@-> {
sub p5special_variable__S_087AtMinus__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_087AtMinus', $retree) }
sub p5special_variable__S_087AtMinus {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_087AtMinus");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\@\-";
$self->_MATCHIFYr($S, "p5special_variable__S_087AtMinus", $C->_EXACT("\@\-"));
}
;
## token p5special_variable:sym<%-> {
sub p5special_variable__S_088PercentMinus__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_088PercentMinus', $retree) }
sub p5special_variable__S_088PercentMinus {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_088PercentMinus");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\%\-";
$self->_MATCHIFYr($S, "p5special_variable__S_088PercentMinus", $C->_EXACT("\%\-"));
}
;
## token p5special_variable:sym<$-[ ]> {
sub p5special_variable__S_089DollarMinusBra_Ket__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_089DollarMinusBra_Ket', $retree) }
sub p5special_variable__S_089DollarMinusBra_Ket {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_089DollarMinusBra_Ket");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\-\[\ \]";
$self->_MATCHIFYr($S, "p5special_variable__S_089DollarMinusBra_Ket", $C->_EXACT("\$\-\["));
}
;
## token p5special_variable:sym<@-[ ]> {
sub p5special_variable__S_090AtMinusBra_Ket__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_090AtMinusBra_Ket', $retree) }
sub p5special_variable__S_090AtMinusBra_Ket {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_090AtMinusBra_Ket");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\@\-\[\ \]";
$self->_MATCHIFYr($S, "p5special_variable__S_090AtMinusBra_Ket", $C->_EXACT("\@\-\["));
}
;
## token p5special_variable:sym<%-{ }> {
sub p5special_variable__S_091PercentMinusCur_Ly__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_091PercentMinusCur_Ly', $retree) }
sub p5special_variable__S_091PercentMinusCur_Ly {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_091PercentMinusCur_Ly");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\%\-\{\ \}";
$self->_MATCHIFYr($S, "p5special_variable__S_091PercentMinusCur_Ly", $C->_EXACT("\@\-\{"));
}
;
## token p5special_variable:sym<$+> {
sub p5special_variable__S_092DollarPlus__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_092DollarPlus', $retree) }
sub p5special_variable__S_092DollarPlus {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_092DollarPlus");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\+";
$self->_MATCHIFYr($S, "p5special_variable__S_092DollarPlus", $C->_EXACT("\$\+"));
}
;
## token p5special_variable:sym<${^ }> {
sub p5special_variable__S_093DollarCurCaret_Ly__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_093DollarCurCaret_Ly', $retree) }
sub p5special_variable__S_093DollarCurCaret_Ly {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_093DollarCurCaret_Ly");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\{\^\ \}";
$self->_MATCHIFYr($S, "p5special_variable__S_093DollarCurCaret_Ly", do {
my $C = $C;
if (($C) = ($C->_SUBSUMEr(['sigil','p5sigil'], sub {
my $C = shift;
$C->p5sigil
}))
and ($C) = ($C->_EXACT("\{\^"))
and ($C) = ($C->_COMMITLTM())
and ($C) = ($C->_SUBSUMEr(['text'], sub {
my $C = shift;
$C->_BRACKET(sub {
my $C=shift;
$C->_SCANf()
})
}))) {
$C->_EXACT("\}")
} else { () }

});
}
;
## token p5special_variable:sym<::{ }> {
sub p5special_variable__S_094ColonColonCur_Ly__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_094ColonColonCur_Ly', $retree) }
sub p5special_variable__S_094ColonColonCur_Ly {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_094ColonColonCur_Ly");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\:\:\{\ \}";
$self->_MATCHIFYr($S, "p5special_variable__S_094ColonColonCur_Ly", do {
my $C = $C;
if (($C) = ($C->_EXACT("\:\:"))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\{")
}))) { ($C) } else { () }
}))) {
$C
} else { () }

});
}
;
## regex p5special_variable:sym<${ }> {
sub p5special_variable__S_095DollarCur_Ly__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_095DollarCur_Ly', $retree) }
sub p5special_variable__S_095DollarCur_Ly {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_095DollarCur_Ly");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\{\ \}";
$self->_MATCHIFY($S, "p5special_variable__S_095DollarCur_Ly", STD::LazyMap::lazymap(sub {
my $C=shift;
if (($C) = ($C->_EXACT("\{"))
and ($C) = (scalar(do {
}, $C))) {
STD::LazyMap::lazymap(sub {
my $C=shift;
$C->_EXACT("\}")
},
$C->_SUBSUME(['text'], sub {
my $C = shift;
$C->_BRACKET(sub {
my $C=shift;
$C->_SCANf()
})
}))
} else { () }
},
$C->_SUBSUME(['sigil','p5sigil'], sub {
my $C = shift;
$C->p5sigil
})));
}
;
## token p5special_variable:sym<$[> {
sub p5special_variable__S_096DollarBra__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_096DollarBra', $retree) }
sub p5special_variable__S_096DollarBra {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_096DollarBra");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\[";
$self->_MATCHIFYr($S, "p5special_variable__S_096DollarBra", $C->_EXACT("\$\["));
}
;
## token p5special_variable:sym<$]> {
sub p5special_variable__S_097DollarKet__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_097DollarKet', $retree) }
sub p5special_variable__S_097DollarKet {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_097DollarKet");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\]";
$self->_MATCHIFYr($S, "p5special_variable__S_097DollarKet", $C->_EXACT("\$\]"));
}
;
## token p5special_variable:sym<$\\> {
sub p5special_variable__S_098DollarBack__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_098DollarBack', $retree) }
sub p5special_variable__S_098DollarBack {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_098DollarBack");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\\";
$self->_MATCHIFYr($S, "p5special_variable__S_098DollarBack", $C->_EXACT("\$\\"));
}
;
## token p5special_variable:sym<$|> {
sub p5special_variable__S_099DollarVert__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_099DollarVert', $retree) }
sub p5special_variable__S_099DollarVert {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_099DollarVert");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\|";
$self->_MATCHIFYr($S, "p5special_variable__S_099DollarVert", $C->_EXACT("\$\|"));
}
;
## token p5special_variable:sym<$:> {
sub p5special_variable__S_100DollarColon__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_100DollarColon', $retree) }
sub p5special_variable__S_100DollarColon {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_100DollarColon");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\:";
$self->_MATCHIFYr($S, "p5special_variable__S_100DollarColon", $C->_EXACT("\$\:"));
}
;
## token p5special_variable:sym<$;> {
sub p5special_variable__S_101DollarSemi__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_101DollarSemi', $retree) }
sub p5special_variable__S_101DollarSemi {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_101DollarSemi");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\;";
$self->_MATCHIFYr($S, "p5special_variable__S_101DollarSemi", $C->_EXACT("\$\;"));
}
;
## token p5special_variable:sym<$'> { #'
sub p5special_variable__S_102DollarSingle__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_102DollarSingle', $retree) }
sub p5special_variable__S_102DollarSingle {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_102DollarSingle");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\'";
$self->_MATCHIFYr($S, "p5special_variable__S_102DollarSingle", $C->_EXACT("\$\'"));
}
;
## token p5special_variable:sym<$"> {
sub p5special_variable__S_103DollarDouble__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_103DollarDouble', $retree) }
sub p5special_variable__S_103DollarDouble {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_103DollarDouble");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\"";
$self->_MATCHIFYr($S, "p5special_variable__S_103DollarDouble", do {
my $C = $C;
if (($C) = ($C->_EXACT("\$\""))
and ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
(($C) x !!do {
$::QSIGIL })
}))) {
$C
} else { () }

});
}
;
## token p5special_variable:sym<$,> {
sub p5special_variable__S_104DollarComma__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_104DollarComma', $retree) }
sub p5special_variable__S_104DollarComma {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_104DollarComma");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\,";
$self->_MATCHIFYr($S, "p5special_variable__S_104DollarComma", $C->_EXACT("\$\,"));
}
;
## token p5special_variable:sym['$<'] {
sub p5special_variable__S_105DollarLt__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_105DollarLt', $retree) }
sub p5special_variable__S_105DollarLt {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_105DollarLt");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\<";
$self->_MATCHIFYr($S, "p5special_variable__S_105DollarLt", $C->_EXACT("\$\<"));
}
;
## token p5special_variable:sym«\$>» {
sub p5special_variable__S_106DollarGt__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_106DollarGt', $retree) }
sub p5special_variable__S_106DollarGt {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_106DollarGt");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\>";
$self->_MATCHIFYr($S, "p5special_variable__S_106DollarGt", $C->_EXACT("\$\>"));
}
;
## token p5special_variable:sym<$.> {
sub p5special_variable__S_107DollarDot__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_107DollarDot', $retree) }
sub p5special_variable__S_107DollarDot {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_107DollarDot");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\.";
$self->_MATCHIFYr($S, "p5special_variable__S_107DollarDot", $C->_EXACT("\$\."));
}
;
## token p5special_variable:sym<$?> {
sub p5special_variable__S_108DollarQuestion__PEEK { $_[0]->_AUTOLEXpeek('p5special_variable__S_108DollarQuestion', $retree) }
sub p5special_variable__S_108DollarQuestion {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5special_variable__S_108DollarQuestion");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$\?";
$self->_MATCHIFYr($S, "p5special_variable__S_108DollarQuestion", $C->_EXACT("\$\?"));
}
;
## token desigilname {
sub desigilname__PEEK { $_[0]->_AUTOLEXpeek('desigilname', $retree) }
sub desigilname {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE desigilname");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "desigilname", $C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'desigilname_0') {
$C->deb("Fate passed to desigilname_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT desigilname_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM desigilname_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'desigilname_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("desigilname_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\$")
}))) { ($C) } else { () }
}))
and ($C) = ($C->_SUBSUMEr(['variable'], sub {
my $C = shift;
$C->variable
}))) {
scalar(do {
my $M = $C;
$::VAR = $M->{'variable'} }, $C)
} else { () }
},
sub {
my $C=shift;
$C->_SUBSUMEr(['longname'], sub {
my $C = shift;
$C->longname
})
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}));
}
;
## token variable {
sub variable__PEEK { $_[0]->_AUTOLEXpeek('variable', $retree) }
sub variable {
no warnings 'recursion';
my $self = shift;

local $::IN_META = 0;my $sigil = '';my $name;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE variable");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "variable", do {
my $C = $C;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->_SUBSUMEr(['sigil','p5sigil'], sub {
my $C = shift;
$C->p5sigil
}))) {
scalar(do {
my $M = $C;
$sigil = $M->{'sigil'}->Str}, $C)
} else { () }
}))) { ($C) } else { () }
}))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->_EXACT("\&"))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'variable_0') {
$C->deb("Fate passed to variable_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT variable_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM variable_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'variable_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("variable_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->_SUBSUMEr(['sublongname'], sub {
my $C = shift;
$C->sublongname
}))) {
scalar(do {
my $M = $C;
$name = $M->{'sublongname'}->Str }, $C)
} else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\]";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\["))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['infixish'], sub {
my $C = shift;
$C->infixish(1)
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\]")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'infix noun', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) { ($C) } else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'variable_1') {
$C->deb("Fate passed to variable_1: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT variable_1';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM variable_1'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'variable_1', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("variable_1 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (($C) = ($C->_SUBSUMEr(['sigil','p5sigil'], sub {
my $C = shift;
$C->p5sigil
}))
and ($C) = ($C->_SUBSUMEr(['desigilname'], sub {
my $C = shift;
$C->desigilname
}))) {
scalar(do {
my $M = $C;
$name = $M->{'desigilname'}->Str }, $C)
} else { () }
},
sub {
my $C=shift;
$C->_SUBSUMEr(['special_variable','p5special_variable'], sub {
my $C = shift;
$C->p5special_variable
})
},
sub {
my $C=shift;
if (my ($C) = ($C->_SUBSUMEr(['sigil','p5sigil'], sub {
my $C = shift;
$C->p5sigil
}))) {
$C->_SUBSUMEr(['index'], sub {
my $C = shift;
$C->_BRACKETr(sub {
my $C=shift;
$C->_PATTERN(qr/\G\d++/)
})
})
} else { () }
},
sub {
my $C=shift;
if (($C) = ($C->_SUBSUMEr(['sigil','p5sigil'], sub {
my $C = shift;
$C->p5sigil
}))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = (do {
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'variable_2') {
$C->deb("Fate passed to variable_2: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT variable_2';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM variable_2'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'variable_2', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("variable_2 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_EXACT("\<")
},
sub {
my $C=shift;
$C->_EXACT("\(")
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};

})) { ($C) } else { () }
}))) { ($C) } else { () }
}))) {
$C->_SUBSUMEr(['postcircumfix','p5postcircumfix'], sub {
my $C = shift;
$C->p5postcircumfix
})
} else { () }
},
sub {
my $C=shift;
if (($C) = ($C->_SUBSUMEr(['sigil','p5sigil'], sub {
my $C = shift;
$C->p5sigil
}))
and ($C) = ($C->before(sub {
my $C=shift;
(($C) x !!do {
$::IN_DECL })
}))) {
$C
} else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C
}))) {
scalar(do {
{
if ($::QSIGIL) {
return ()}
else {
$C->panic("Anonymous variable requires declarator")}}}, $C)
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }

});
}
;
## token p5sigil:sym<$>  { <sym> }
sub p5sigil__S_109Dollar__PEEK { $_[0]->_AUTOLEXpeek('p5sigil__S_109Dollar', $retree) }
sub p5sigil__S_109Dollar {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5sigil__S_109Dollar");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$";
$self->_MATCHIFYr($S, "p5sigil__S_109Dollar", $C->_EXACT("\$"));
}
;
## token p5sigil:sym<@>  { <sym> }
sub p5sigil__S_110At__PEEK { $_[0]->_AUTOLEXpeek('p5sigil__S_110At', $retree) }
sub p5sigil__S_110At {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5sigil__S_110At");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\@";
$self->_MATCHIFYr($S, "p5sigil__S_110At", $C->_EXACT("\@"));
}
;
## token p5sigil:sym<%>  { <sym> }
sub p5sigil__S_111Percent__PEEK { $_[0]->_AUTOLEXpeek('p5sigil__S_111Percent', $retree) }
sub p5sigil__S_111Percent {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5sigil__S_111Percent");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\%";
$self->_MATCHIFYr($S, "p5sigil__S_111Percent", $C->_EXACT("\%"));
}
;
## token p5sigil:sym<&>  { <sym> }
sub p5sigil__S_112Amp__PEEK { $_[0]->_AUTOLEXpeek('p5sigil__S_112Amp', $retree) }
sub p5sigil__S_112Amp {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5sigil__S_112Amp");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\&";
$self->_MATCHIFYr($S, "p5sigil__S_112Amp", $C->_EXACT("\&"));
}
;
## token deflongname {
sub deflongname__PEEK { $_[0]->_AUTOLEXpeek('deflongname', $retree) }
sub deflongname {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE deflongname");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'colonpair'} = [];
$self->_MATCHIFYr($S, "deflongname", do {
my $C = $C;
if (($C) = ($C->_SUBSUMEr(['name'], sub {
my $C = shift;
$C->name
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'deflongname_0') {
$C->deb("Fate passed to deflongname_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT deflongname_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM deflongname_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'deflongname_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("deflongname_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->_PLUSr(sub {
my $C=shift;
$C->_SUBSUMEr(['colonpair'], sub {
my $C = shift;
$C->colonpair
})
}))) {
scalar(do {
my $M = $C;
$C->add_macro($M->{'name'}) if $::IN_DECL}, $C)
} else { () }
},
sub {
my $C=shift;
scalar(do {
my $M = $C;
$C->add_routine($M->{'name'}->Str) if $::IN_DECL}, $C)
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

});
}
;
## token longname {
sub longname__PEEK { $_[0]->_AUTOLEXpeek('longname', $retree) }
sub longname {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE longname");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'colonpair'} = [];
$self->_MATCHIFYr($S, "longname", do {
if (my ($C) = ($C->_SUBSUMEr(['name'], sub {
my $C = shift;
$C->name
}))) {
$C->_STARr(sub {
my $C=shift;
$C->_SUBSUMEr(['colonpair'], sub {
my $C = shift;
$C->colonpair
})
})
} else { () }

});
}
;
## token name {
sub name__PEEK { $_[0]->_AUTOLEXpeek('name', $retree) }
sub name {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE name");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'morename'} = [];
$self->_MATCHIFYr($S, "name", $C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'name_0') {
$C->deb("Fate passed to name_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT name_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM name_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'name_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("name_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->_SUBSUMEr(['identifier'], sub {
my $C = shift;
$C->identifier
}))) {
$C->_STARr(sub {
my $C=shift;
$C->_SUBSUMEr(['morename'], sub {
my $C = shift;
$C->morename
})
})
} else { () }
},
sub {
my $C=shift;
$C->_PLUSr(sub {
my $C=shift;
$C->_SUBSUMEr(['morename'], sub {
my $C = shift;
$C->morename
})
})
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}));
}
;
## token morename {
sub morename__PEEK { $_[0]->_AUTOLEXpeek('morename', $retree) }
sub morename {
no warnings 'recursion';
my $self = shift;

local $::QSIGIL = '';
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE morename");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'EXPR'} = [];
$C->{'identifier'} = [];
$self->_MATCHIFYr($S, "morename", do {
if (my ($C) = ($C->_EXACT("\:\:"))) {
$C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = (do {
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'morename_0') {
$C->deb("Fate passed to morename_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT morename_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM morename_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'morename_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("morename_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_EXACT("\(")
},
sub {
my $C=shift;
$C->_PATTERN(qr/\G[_[:alpha:]]/)
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};

})) { ($C) } else { () }
}))) { ($C) } else { () }
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'morename_1') {
$C->deb("Fate passed to morename_1: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT morename_1';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM morename_1'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'morename_1', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("morename_1 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_SUBSUMEr(['identifier'], sub {
my $C = shift;
$C->identifier
})
},
sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\)";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\("))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['EXPR'], sub {
my $C = shift;
$C->EXPR
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\)")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'indirect name', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) { ($C) } else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }
}))) { ($C) } else { () }
})
} else { () }

});
}
;
## token subshortname {
sub subshortname__PEEK { $_[0]->_AUTOLEXpeek('subshortname', $retree) }
sub subshortname {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE subshortname");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'colonpair'} = [];
$self->_MATCHIFYr($S, "subshortname", $C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'subshortname_0') {
$C->deb("Fate passed to subshortname_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT subshortname_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM subshortname_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'subshortname_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("subshortname_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->_SUBSUMEr(['category'], sub {
my $C = shift;
$C->category
}))) {
$C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (my ($C) = ($C->_PLUSr(sub {
my $C=shift;
$C->_SUBSUMEr(['colonpair'], sub {
my $C = shift;
$C->colonpair
})
}))) {
scalar(do {
my $M = $C;
$C->add_macro($M->{'category'}) if $::IN_DECL}, $C)
} else { () }
}))) { ($C) } else { () }
})
} else { () }
},
sub {
my $C=shift;
$C->_SUBSUMEr(['desigilname'], sub {
my $C = shift;
$C->desigilname
})
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}));
}
;
## token sublongname {
sub sublongname__PEEK { $_[0]->_AUTOLEXpeek('sublongname', $retree) }
sub sublongname {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE sublongname");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'sigterm'} = [];
$self->_MATCHIFYr($S, "sublongname", do {
if (my ($C) = ($C->_SUBSUMEr(['subshortname'], sub {
my $C = shift;
$C->subshortname
}))) {
$C->_OPTr(sub {
my $C=shift;
$C->_SUBSUMEr(['sigterm'], sub {
my $C = shift;
$C->sigterm
})
})
} else { () }

});
}
;
## token p5value:quote   { <quote=p5quote> }
sub p5value__S_113quote__PEEK { $_[0]->_AUTOLEXpeek('p5value__S_113quote', $retree) }
sub p5value__S_113quote {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5value__S_113quote");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "quote";
$self->_MATCHIFYr($S, "p5value__S_113quote", $C->_SUBSUMEr(['quote','p5quote'], sub {
my $C = shift;
$C->p5quote
}));
}
;
## token p5value:number  { <number=p5number> }
sub p5value__S_114number__PEEK { $_[0]->_AUTOLEXpeek('p5value__S_114number', $retree) }
sub p5value__S_114number {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5value__S_114number");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "number";
$self->_MATCHIFYr($S, "p5value__S_114number", $C->_SUBSUMEr(['number','p5number'], sub {
my $C = shift;
$C->p5number
}));
}
;
## token p5value:version { <version=p5version> }
sub p5value__S_115version__PEEK { $_[0]->_AUTOLEXpeek('p5value__S_115version', $retree) }
sub p5value__S_115version {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5value__S_115version");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "version";
$self->_MATCHIFYr($S, "p5value__S_115version", $C->_SUBSUMEr(['version','p5version'], sub {
my $C = shift;
$C->p5version
}));
}
;
## token typename {
sub typename__PEEK { $_[0]->_AUTOLEXpeek('typename', $retree) }
sub typename {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE typename");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'p5postcircumfix'} = [];
$C->{'postcircumfix'} = [];
$C->{'typename'} = [];
$self->_MATCHIFYr($S, "typename", do {
my $C = $C;
if (($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'typename_0') {
$C->deb("Fate passed to typename_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT typename_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM typename_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'typename_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("typename_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->_EXACT("\:\:\?"))) {
$C->_SUBSUMEr(['identifier'], sub {
my $C = shift;
$C->identifier
})
} else { () }
},
sub {
my $C=shift;
if (($C) = ($C->_SUBSUMEr(['longname'], sub {
my $C = shift;
$C->longname
}))
and ($C) = ($C->before(sub {
my $C=shift;
(($C) x !!do {
my $M = $C;
{
my $longname = $M->{'longname'}->Str;
if (substr($longname, 0, 2) eq '::') {
$C->add_my_name(substr($longname, 2))}
else {
$C->is_name($longname)
};
}})
}))) {
$C
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))
and ($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->unsp)) { ($C) } else { () }
}))
and ($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\[")
}))) { ($C) } else { () }
}))) {
$C->_SUBSUMEr(['postcircumfix','p5postcircumfix'], sub {
my $C = shift;
$C->p5postcircumfix
})
} else { () }
}))) { ($C) } else { () }
}))
and ($C) = ($C->ws)) {
$C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->_EXACT("of"))
and ($C) = ($C->ws)) {
$C->_SUBSUMEr(['typename'], sub {
my $C = shift;
$C->typename
})
} else { () }
}))) { ($C) } else { () }
})
} else { () }

});
}
;
## token numish {
sub numish__PEEK { $_[0]->_AUTOLEXpeek('numish', $retree) }
sub numish {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE numish");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "numish", $C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'numish_0') {
$C->deb("Fate passed to numish_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT numish_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM numish_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'numish_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("numish_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_SUBSUMEr(['integer'], sub {
my $C = shift;
$C->integer
})
},
sub {
my $C=shift;
$C->_SUBSUMEr(['dec_number'], sub {
my $C = shift;
$C->dec_number
})
},
sub {
my $C=shift;
$C->_SUBSUMEr(['rad_number'], sub {
my $C = shift;
$C->rad_number
})
},
sub {
my $C=shift;
$C->_PATTERN(qr/\GNaN\b/)
},
sub {
my $C=shift;
$C->_PATTERN(qr/\GInf\b/)
},
sub {
my $C=shift;
$C->_PATTERN(qr/\G\+Inf\b/)
},
sub {
my $C=shift;
$C->_PATTERN(qr/\G\-Inf\b/)
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}));
}
;
## token number:numish { <numish> }
sub number__S_116numish__PEEK { $_[0]->_AUTOLEXpeek('number__S_116numish', $retree) }
sub number__S_116numish {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE number__S_116numish");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "numish";
$self->_MATCHIFYr($S, "number__S_116numish", $C->_SUBSUMEr(['numish'], sub {
my $C = shift;
$C->numish
}));
}
;
## token integer {
sub integer__PEEK { $_[0]->_AUTOLEXpeek('integer', $retree) }
sub integer {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE integer");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "integer", $C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'integer_0') {
$C->deb("Fate passed to integer_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT integer_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM integer_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'integer_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("integer_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (($C) = ($C->_EXACT("0"))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'integer_1') {
$C->deb("Fate passed to integer_1: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT integer_1';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM integer_1'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'integer_1', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("integer_1 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->_PATTERN(qr/\Gb(?:[01])++/))) {
$C->_STARr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
$C->_PATTERN(qr/\G_(?:[01])++/)
}))) { ($C) } else { () }
})
} else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->_PATTERN(qr/\Go(?:[0-7])++/))) {
$C->_STARr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
$C->_PATTERN(qr/\G_(?:[0-7])++/)
}))) { ($C) } else { () }
})
} else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->_PATTERN(qr/\Gx(?:[0-9a-fA-F])++/))) {
$C->_STARr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
$C->_PATTERN(qr/\G_(?:[0-9a-fA-F])++/)
}))) { ($C) } else { () }
})
} else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->_PATTERN(qr/\Gd\d++/))) {
$C->_STARr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
$C->_PATTERN(qr/\G_\d++/)
}))) { ($C) } else { () }
})
} else { () }
},
sub {
my $C=shift;
if (($C) = ($C->_PATTERN(qr/\G\d++/))
and ($C) = ($C->_STARr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
$C->_PATTERN(qr/\G_\d++/)
}))) { ($C) } else { () }
}))
and ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
(($C) x !!do {
$C->worry("Leading 0 does not indicate octal in Perl 6") })
}))) { ($C) } else { () }
}))) {
$C
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->_PATTERN(qr/\G\d++/))) {
$C->_STARr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
$C->_PATTERN(qr/\G_\d++/)
}))) { ($C) } else { () }
})
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}));
}
;
## token radint {
sub radint__PEEK { $_[0]->_AUTOLEXpeek('radint', $retree) }
sub radint {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE radint");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "radint", $C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'radint_0') {
$C->deb("Fate passed to radint_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT radint_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM radint_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'radint_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("radint_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_SUBSUMEr(['integer'], sub {
my $C = shift;
$C->integer
})
},
sub {
my $C=shift;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\:")
}))) { ($C) } else { () }
}))
and ($C) = ($C->_SUBSUMEr(['rad_number'], sub {
my $C = shift;
$C->rad_number
}))
and ($C) = ($C->before(sub {
my $C=shift;
(($C) x !!do {
my $M = $C;
defined $M->{'rad_number'}->{'intpart'}
and
not defined $M->{'rad_number'}->{'fracpart'}
})
}))) {
$C
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}));
}
;
## token escale {
sub escale__PEEK { $_[0]->_AUTOLEXpeek('escale', $retree) }
sub escale {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE escale");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "escale", do {
if (my ($C) = ($C->_PATTERN(qr/\G[Ee](?:[+\-])?+\d++/))) {
$C->_STARr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
$C->_PATTERN(qr/\G_\d++/)
}))) { ($C) } else { () }
})
} else { () }

});
}
;
## token dec_number {
sub dec_number__PEEK { $_[0]->_AUTOLEXpeek('dec_number', $retree) }
sub dec_number {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE dec_number");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'escale'} = [];
$self->_MATCHIFYr($S, "dec_number", do {
my $C = $C;
if (($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'dec_number_0') {
$C->deb("Fate passed to dec_number_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT dec_number_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM dec_number_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'dec_number_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("dec_number_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->_SUBSUMEr(['coeff'], sub {
my $C = shift;
$C->_BRACKETr(sub {
my $C=shift;
if (my ($C) = ($C->_PATTERN(qr/\G\.\d++/))) {
$C->_STARr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
$C->_PATTERN(qr/\G_\d++/)
}))) { ($C) } else { () }
})
} else { () }
})
}))) {
$C->_OPTr(sub {
my $C=shift;
$C->_SUBSUMEr(['escale'], sub {
my $C = shift;
$C->escale
})
})
} else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->_SUBSUMEr(['coeff'], sub {
my $C = shift;
$C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->_PATTERN(qr/\G\d++/))
and ($C) = ($C->_STARr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
$C->_PATTERN(qr/\G_\d++/)
}))) { ($C) } else { () }
}))
and ($C) = ($C->_PATTERN(qr/\G\.\d++/))) {
$C->_STARr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
$C->_PATTERN(qr/\G_\d++/)
}))) { ($C) } else { () }
})
} else { () }
})
}))) {
$C->_OPTr(sub {
my $C=shift;
$C->_SUBSUMEr(['escale'], sub {
my $C = shift;
$C->escale
})
})
} else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->_SUBSUMEr(['coeff'], sub {
my $C = shift;
$C->_BRACKETr(sub {
my $C=shift;
if (my ($C) = ($C->_PATTERN(qr/\G\d++/))) {
$C->_STARr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
$C->_PATTERN(qr/\G_\d++/)
}))) { ($C) } else { () }
})
} else { () }
})
}))) {
$C->_SUBSUMEr(['escale'], sub {
my $C = shift;
$C->escale
})
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))
and ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->_EXACT("\."))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G\d/)
}))) { ($C) } else { () }
}))
and ($C) = ($C->panic("Number contains two decimal points (missing 'v' for version number?)"))) {
$C
} else { () }
}))) { ($C) } else { () }
})
}))) { ($C) } else { () }
}))) { ($C) } else { () }
}))) {
$C
} else { () }

});
}
;
## token octints { [<.ws><octint><.ws>] ** ',' }
sub octints__PEEK { $_[0]->_AUTOLEXpeek('octints', $retree) }
sub octints {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE octints");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'octint'} = [];
$self->_MATCHIFYr($S, "octints", $C->_REPSEPr( sub {
my $C=shift;
$C->_EXACT("\,")
}, sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['octint'], sub {
my $C = shift;
$C->octint
}))
and ($C) = ($C->ws)) {
$C
} else { () }
}))) { ($C) } else { () }
}));
}
;
## token octint {
sub octint__PEEK { $_[0]->_AUTOLEXpeek('octint', $retree) }
sub octint {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE octint");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "octint", do {
if (my ($C) = ($C->_PATTERN(qr/\G(?:[0-7])++/))) {
$C->_STARr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
$C->_PATTERN(qr/\G_(?:[0-7])++/)
}))) { ($C) } else { () }
})
} else { () }

});
}
;
## token hexints { [<.ws><hexint><.ws>] ** ',' }
sub hexints__PEEK { $_[0]->_AUTOLEXpeek('hexints', $retree) }
sub hexints {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE hexints");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'hexint'} = [];
$self->_MATCHIFYr($S, "hexints", $C->_REPSEPr( sub {
my $C=shift;
$C->_EXACT("\,")
}, sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['hexint'], sub {
my $C = shift;
$C->hexint
}))
and ($C) = ($C->ws)) {
$C
} else { () }
}))) { ($C) } else { () }
}));
}
;
## token hexint {
sub hexint__PEEK { $_[0]->_AUTOLEXpeek('hexint', $retree) }
sub hexint {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE hexint");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "hexint", do {
if (my ($C) = ($C->_PATTERN(qr/\G(?:[0-9a-fA-F])++/))) {
$C->_STARr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
$C->_PATTERN(qr/\G_(?:[0-9a-fA-F])++/)
}))) { ($C) } else { () }
})
} else { () }

});
}
;
our @herestub_queue;
{ package STD::P5::Herestub;
use Moose ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::Herestub', 1 };
our $REGEXES = {
ALL => [ qw// ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

moose_has 'delim' => (isa => 'Str', is => 'rw');
moose_has 'orignode' => (is => 'rw');
moose_has 'lang' => (is => 'rw');
1; };
{ package STD::P5::herestop;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::herestop', 1 };
our $REGEXES = {
ALL => [ qw/stopper/ ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

$retree = YAML::XS::Load(Encode::encode_utf8(<<'RETREE_END'));
---
stopper: !!perl/hash:RE_ast
  dba: stopper
  dic: STD::P5::herestop
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_meta
      text: ^^
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_paren
        re: !!perl/hash:RE_quantified_atom
          atom: !!perl/hash:RE_meta
            min: 1
            text: \h
          quant:
          - '*'
    - !!perl/hash:RE_var
      var: $::DELIM
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_meta
        min: 1
        text: \h
      quant:
      - '*'
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_method
        name: unv
        rest: ''
      quant:
      - '?'
    - !!perl/hash:RE_meta
      text: $$
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_meta
        min: 1
        text: \v
      quant:
      - '?'
RETREE_END
## token stopper { ^^ {} $<ws>=(\h*?) $*DELIM \h* <.unv>?? $$ \v? }
sub stopper__PEEK { $_[0]->_AUTOLEXpeek('stopper', $retree) }
sub stopper {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE stopper");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "stopper", do {
my $C = $C;
if (($C) = ($C->_PATTERN(qr/\G(?m:^)/))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['ws'], sub {
my $C = shift;
$C->_PAREN( sub {
my $C=shift;
$C->_STARf(sub {
my $C=shift;
$C->_PATTERN(qr/\G[\x20\t\r]/)
})

})
}))
and ($C) = ($C->_EXACT($::DELIM))
and ($C) = ($C->_PATTERN(qr/\G[\x20\t\r]*+/))) {
STD::LazyMap::lazymap(sub {
my $C=shift;
$C->_PATTERN(qr/\G(?m:$)\n?+/)
},
$C->_OPTf(sub {
my $C=shift;
if (my ($C) = ($C->unv)) { ($C) } else { () }
}))
} else { () }

});
}
1; };
## method heredoc ()
sub heredoc {
no warnings 'recursion';
my $self = shift;
local $::CTX = $self->callm if $::DEBUG & DEBUG::trace_call;
return if $self->peek;
my $here = $self;
while (my $herestub = shift @herestub_queue) {
local $::DELIM = $herestub->delim;
my $lang = $herestub->lang->mixin( 'STD::P5::herestop' );
my $doc;
if (($doc) = $here->nibble($lang)) {
$here = $doc->trim_heredoc();
$herestub->orignode->{'doc'} = $doc;
}
else {
$self->panic("Ending delimiter $::DELIM not found")};
}
;
return $self->cursor($here->{'_pos'});
};
## token backslash { <...> }
sub backslash__PEEK { $_[0]->_AUTOLEXpeek('backslash:*',$retree); }
sub backslash {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE backslash');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'backslash') {
$C->deb("Fate passed to backslash: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT backslash';
}
else {
$x = 'ALTLTM backslash';
}
}
else {
$x = 'ALTLTM backslash';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'backslash:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("backslash trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "backslash", @gather);
};
@result;
}
;
## token escape { <...> }
sub escape__PEEK { $_[0]->_AUTOLEXpeek('escape:*',$retree); }
sub escape {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE escape');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'escape') {
$C->deb("Fate passed to escape: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT escape';
}
else {
$x = 'ALTLTM escape';
}
}
else {
$x = 'ALTLTM escape';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'escape:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("escape trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "escape", @gather);
};
@result;
}
;
## token starter { <!> }
sub starter__PEEK { $_[0]->_AUTOLEXpeek('starter', $retree) }
sub starter {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE starter");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "starter", $C->_NOTBEFORE(sub {
my $C=shift;
$C
}));
}
;
## token escape:none { <!> }
sub escape__S_117none__PEEK { $_[0]->_AUTOLEXpeek('escape__S_117none', $retree) }
sub escape__S_117none {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE escape__S_117none");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "none";
$self->_MATCHIFYr($S, "escape__S_117none", $C->_NOTBEFORE(sub {
my $C=shift;
$C
}));
}
;
## token babble ($l) {
sub babble__PEEK { $_[0]->_AUTOLEXpeek('babble', $retree) }
sub babble {
no warnings 'recursion';
my $self = shift;

die 'Required argument l omitted' unless @_;
my $l = @_ ? shift() : undef;
my $lang = $l;my $start;my $stop;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE babble");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'quotepair'} = [];
$self->_MATCHIFYr($S, "babble", do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = ($C->_STARr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->_SUBSUMEr(['quotepair'], sub {
my $C = shift;
$C->quotepair
}))
and ($C) = ($C->ws)) {
scalar(do {
my $M = $C;
my $kv = $M->{'quotepair'}->[-1];
$lang = $lang->tweak($kv->{'k'}, $kv->{'v'})
or $self->sorry("Unrecognized adverb :" . $kv->{'k'} . '(' . $kv->{'v'} . ')');
}, $C)
} else { () }
}))) { ($C) } else { () }
}))) {
scalar(do {
my $M = $C;
($start,$stop) = $C->peek_delimiters();
$lang = $start ne $stop ? $lang->balanced($start,$stop)
: $lang->unbalanced($stop);
$M->{'B'} = [$lang,$start,$stop];
}, $C)
} else { () }

});
}
;
## token quibble ($l) {
sub quibble__PEEK { $_[0]->_AUTOLEXpeek('quibble', $retree) }
sub quibble {
no warnings 'recursion';
my $self = shift;

die 'Required argument l omitted' unless @_;
my $l = @_ ? shift() : undef;
my ($lang, $start, $stop);
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE quibble");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "quibble", do {
my $C = $C;
if (($C) = ($C->_SUBSUMEr(['babble'], sub {
my $C = shift;
$C->babble($l)
}))
and ($C) = (scalar(do {
my $M = $C;
my $B = $M->{'babble'}->{'B'};
($lang,$start,$stop) = @$B;
}, $C))
and ($C) = ($C->_EXACT($start))
and ($C) = ($C->_SUBSUMEr(['nibble'], sub {
my $C = shift;
$C->nibble($lang)
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
if (my ($C) = ($C->_EXACT($stop))) { ($C) } else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->panic("Couldn't find terminator $stop"))) { ($C) } else { () }

}
};
@gather;
}
}))) {
scalar(do {
my $M = $C;
{
if ($lang->{'_herelang'}) {
push @herestub_queue,
'STD::P5::Herestub'->new(
delim => $M->{'nibble'}->{'nibbles'}->[0]->{'TEXT'},
orignode => $C,
lang => $lang->{'_herelang'},
)}}}, $C)
} else { () }

});
}
;
## token sibble ($l, $lang2) {
sub sibble__PEEK { $_[0]->_AUTOLEXpeek('sibble', $retree) }
sub sibble {
no warnings 'recursion';
my $self = shift;

die 'Required argument l omitted' unless @_;
my $l = @_ ? shift() : undef;
die 'Required argument lang2 omitted' unless @_;
my $lang2 = @_ ? shift() : undef;
my ($lang, $start, $stop);
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE sibble");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'nibble'} = [];
$self->_MATCHIFYr($S, "sibble", do {
my $C = $C;
if (($C) = ($C->_SUBSUMEr(['babble'], sub {
my $C = shift;
$C->babble($l)
}))
and ($C) = (scalar(do {
my $M = $C;
my $B = $M->{'babble'}->{'B'};
($lang,$start,$stop) = @$B;
}, $C))
and ($C) = ($C->_EXACT($start))
and ($C) = ($C->_SUBSUMEr(['left','nibble'], sub {
my $C = shift;
$C->nibble($lang)
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
if (my ($C) = ($C->_EXACT($stop))) { ($C) } else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->panic("Couldn't find terminator $stop"))) { ($C) } else { () }

}
};
@gather;
}
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->before(sub {
my $C=shift;
(($C) x !!do {
$start ne $stop })
}))
and ($C) = ($C->ws)) {
$C->_SUBSUMEr(['quibble'], sub {
my $C = shift;
$C->quibble($lang2)
})
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
my $C = $C;
if (($C) = (scalar(do {
$lang = $lang2->unbalanced($stop)}, $C))
and ($C) = ($C->_SUBSUMEr(['right','nibble'], sub {
my $C = shift;
$C->nibble($lang)
}))
and ($C) = ($C->_EXACT($stop))) {
$C
} else { () }

}
};
@gather;
}
}))) {
$C
} else { () }

});
}
;
## token tribble ($l, $lang2 = $l) {
sub tribble__PEEK { $_[0]->_AUTOLEXpeek('tribble', $retree) }
sub tribble {
no warnings 'recursion';
my $self = shift;

die 'Required argument l omitted' unless @_;
my $l = @_ ? shift() : undef;
my $lang2 = @_ ? shift() : $l;
my ($lang, $start, $stop);
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE tribble");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'nibble'} = [];
$self->_MATCHIFYr($S, "tribble", do {
my $C = $C;
if (($C) = ($C->_SUBSUMEr(['babble'], sub {
my $C = shift;
$C->babble($l)
}))
and ($C) = (scalar(do {
my $M = $C;
my $B = $M->{'babble'}->{'B'};
($lang,$start,$stop) = @$B;
}, $C))
and ($C) = ($C->_EXACT($start))
and ($C) = ($C->_SUBSUMEr(['left','nibble'], sub {
my $C = shift;
$C->nibble($lang)
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
if (my ($C) = ($C->_EXACT($stop))) { ($C) } else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->panic("Couldn't find terminator $stop"))) { ($C) } else { () }

}
};
@gather;
}
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->before(sub {
my $C=shift;
(($C) x !!do {
$start ne $stop })
}))
and ($C) = ($C->ws)) {
$C->_SUBSUMEr(['quibble'], sub {
my $C = shift;
$C->quibble($lang2)
})
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
my $C = $C;
if (($C) = (scalar(do {
$lang = $lang2->unbalanced($stop)}, $C))
and ($C) = ($C->_SUBSUMEr(['right','nibble'], sub {
my $C = shift;
$C->nibble($lang)
}))
and ($C) = ($C->_EXACT($stop))) {
$C
} else { () }

}
};
@gather;
}
}))) {
$C
} else { () }

});
}
;
## token quasiquibble ($l) {
sub quasiquibble__PEEK { $_[0]->_AUTOLEXpeek('quasiquibble', $retree) }
sub quasiquibble {
no warnings 'recursion';
my $self = shift;

die 'Required argument l omitted' unless @_;
my $l = @_ ? shift() : undef;
my ($lang, $start, $stop);local $::QUASIMODO = 0;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE quasiquibble");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "quasiquibble", do {
my $C = $C;
if (($C) = ($C->_SUBSUMEr(['babble'], sub {
my $C = shift;
$C->babble($l)
}))
and ($C) = (scalar(do {
my $M = $C;
my $B = $M->{'babble'}->{'B'};
($lang,$start,$stop) = @$B;
}, $C))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->before(sub {
my $C=shift;
(($C) x !!do {
$start eq '{' })
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
my $newlang = ($lang);
$C = bless($C, (ref($newlang) || $newlang));
$C->_SUBSUMEr(['block'], sub {
my $C = shift;
$C->block
})
}))) {
$C
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->_EXACT($start))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
my $newlang = ($lang);
$C = bless($C, (ref($newlang) || $newlang));
$C->_SUBSUMEr(['statementlist'], sub {
my $C = shift;
$C->statementlist
})
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
if (my ($C) = ($C->_EXACT($stop))) { ($C) } else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->panic("Couldn't find terminator $stop"))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }

}
};
@gather;
}
}))) {
$C
} else { () }

});
}
;
## token nibbler {
sub nibbler__PEEK { $_[0]->_AUTOLEXpeek('nibbler', $retree) }
sub nibbler {
no warnings 'recursion';
my $self = shift;

my $text = '';my $from = $self->{'_pos'};my $to = $from;my @nibbles = ();my $multiline = 0;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE nibbler");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'escape'} = [];
$C->{'nibbler'} = [];
$C->{'starter'} = [];
$C->{'stopper'} = [];
$self->_MATCHIFYr($S, "nibbler", do {
my $C = $C;
if (($C) = (scalar(do {
my $M = $C;
$M->{'_from'} = $self->{'_pos'}}, $C))
and ($C) = ($C->_STARr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->{'stopper'} = [];
$C->_SUBSUMEr(['stopper'], sub {
my $C = shift;
$C->stopper
})
}))) { ($C) } else { () }
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->_SUBSUMEr(['starter'], sub {
my $C = shift;
$C->starter
}))
and ($C) = ($C->_SUBSUMEr(['nibbler'], sub {
my $C = shift;
$C->nibbler
}))
and ($C) = ($C->_SUBSUMEr(['stopper'], sub {
my $C = shift;
$C->stopper
}))) {
scalar(do {
my $M = $C;
{
push @nibbles, $C->makestr(TEXT => $text, _from => $from, _pos => $to ) if $from != $to;
my $n = $M->{'nibbler'}->[-1]->{'nibbles'};
my @n = @$n;
push @nibbles, $M->{'starter'};
push @nibbles, @n;
push @nibbles, $M->{'stopper'};
$text = '';
$to = $from = $C->{'_pos'};
}}, $C)
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->_SUBSUMEr(['escape'], sub {
my $C = shift;
$C->escape
}))) {
scalar(do {
my $M = $C;
{
push @nibbles, $C->makestr(TEXT => $text, _from => $from, _pos => $to ) if $from != $to;
push @nibbles, $M->{'escape'}->[-1];
$text = '';
$to = $from = $C->{'_pos'};
}}, $C)
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->cursor_incr())) {
scalar(do {
{
my $ch = substr($::ORIG, $C->{'_pos'}-1, 1);
$text .= $ch;
$to = $C->{'_pos'};
if ($ch =~ "\n") {
$multiline++};
}}, $C)
} else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) { ($C) } else { () }
}))) {
scalar(do {
my $M = $C;
{
push @nibbles, $C->makestr(TEXT => $text, _from => $from, _pos => $to ) if $from != $to or !@nibbles;
$M->{'nibbles'} = \@nibbles;
$M->{'_pos'} = $C->{'_pos'};
delete $M->{'nibbler'};
delete $M->{'escape'};
delete $M->{'starter'};
delete $M->{'stopper'};
$::LAST_NIBBLE = $C;
$::LAST_NIBBLE_MULTILINE = $C if $multiline;
}}, $C)
} else { () }

});
}
;
## method nibble ($lang)
sub nibble {
no warnings 'recursion';
my $self = shift;
die 'Required argument lang omitted' unless @_;
my $lang = @_ ? shift() : undef;
$self->cursor_fresh($lang)->nibbler};
## token p5quote:sym<' '>   { "'" <nibble($¢.cursor_fresh( %*LANG<Q> ).tweak(:q).unbalanced("'"))> "'" 
sub p5quote__S_118Single_Single__PEEK { $_[0]->_AUTOLEXpeek('p5quote__S_118Single_Single', $retree) }
sub p5quote__S_118Single_Single {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5quote__S_118Single_Single");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\'\ \'";
$self->_MATCHIFYr($S, "p5quote__S_118Single_Single", do {
my $C = $C;
if (($C) = ($C->_EXACT("\'"))
and ($C) = ($C->_SUBSUMEr(['nibble'], sub {
my $C = shift;
$C->nibble($C->cursor_fresh( $::LANG{'Q'} )->tweak('q' => 1)->unbalanced("'"))
}))) {
$C->_EXACT("\'")
} else { () }

});
}
;
## token p5quote:sym<" ">   { '"' <nibble($¢.cursor_fresh( %*LANG<Q> ).tweak(:qq).unbalanced('"'))> '"'
sub p5quote__S_119Double_Double__PEEK { $_[0]->_AUTOLEXpeek('p5quote__S_119Double_Double', $retree) }
sub p5quote__S_119Double_Double {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5quote__S_119Double_Double");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\"\ \"";
$self->_MATCHIFYr($S, "p5quote__S_119Double_Double", do {
my $C = $C;
if (($C) = ($C->_EXACT("\""))
and ($C) = ($C->_SUBSUMEr(['nibble'], sub {
my $C = shift;
$C->nibble($C->cursor_fresh( $::LANG{'Q'} )->tweak('qq' => 1)->unbalanced('"'))
}))) {
$C->_EXACT("\"")
} else { () }

});
}
;
## token p5circumfix:sym«< >»   { '<'
sub p5circumfix__S_120Lt_Gt__PEEK { $_[0]->_AUTOLEXpeek('p5circumfix__S_120Lt_Gt', $retree) }
sub p5circumfix__S_120Lt_Gt {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5circumfix__S_120Lt_Gt");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\<\ \>";
$self->_MATCHIFYr($S, "p5circumfix__S_120Lt_Gt", do {
my $C = $C;
if (($C) = ($C->_EXACT("\<"))
and ($C) = ($C->_SUBSUMEr(['nibble'], sub {
my $C = shift;
$C->nibble($C->cursor_fresh( $::LANG{'Q'} )->tweak('qq' => 1)->tweak('w' => 1)->balanced('<','>'))
}))) {
$C->_EXACT("\>")
} else { () }

});
}
;
## token p5quote:sym</ />   {
sub p5quote__S_121Slash_Slash__PEEK { $_[0]->_AUTOLEXpeek('p5quote__S_121Slash_Slash', $retree) }
sub p5quote__S_121Slash_Slash {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5quote__S_121Slash_Slash");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'p5rx_mods'} = [];
$C->{sym} = "\/\ \/";
$self->_MATCHIFYr($S, "p5quote__S_121Slash_Slash", do {
my $C = $C;
if (($C) = ($C->_EXACT("\/"))
and ($C) = ($C->_SUBSUMEr(['nibble'], sub {
my $C = shift;
$C->nibble( $C->cursor_fresh( $::LANG{'Regex'} )->unbalanced("/") )
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\/")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->panic("Unable to parse regex; couldn't find final '/'"))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C->_OPTr(sub {
my $C=shift;
$C->_SUBSUMEr(['p5rx_mods'], sub {
my $C = shift;
$C->p5rx_mods
})
})
} else { () }

});
}
;
## token quote:qq {
sub quote__S_122qq__PEEK { $_[0]->_AUTOLEXpeek('quote__S_122qq', $retree) }
sub quote__S_122qq {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE quote__S_122qq");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "qq";
$self->_MATCHIFYr($S, "quote__S_122qq", do {
my $C = $C;
if (($C) = ($C->_EXACT("qq"))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->_PATTERN(qr/\G\b/))
and ($C) = ($C->ws)) {
$C->_SUBSUMEr(['quibble'], sub {
my $C = shift;
$C->quibble($C->cursor_fresh( $::LANG{'Q'} )->tweak('qq' => 1))
})
} else { () }
}))) {
$C
} else { () }

});
}
;
## token quote:q {
sub quote__S_123q__PEEK { $_[0]->_AUTOLEXpeek('quote__S_123q', $retree) }
sub quote__S_123q {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE quote__S_123q");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "q";
$self->_MATCHIFYr($S, "quote__S_123q", do {
my $C = $C;
if (($C) = ($C->_EXACT("q"))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->_PATTERN(qr/\G\b/))
and ($C) = ($C->ws)) {
$C->_SUBSUMEr(['quibble'], sub {
my $C = shift;
$C->quibble($C->cursor_fresh( $::LANG{'Q'} )->tweak('q' => 1))
})
} else { () }
}))) {
$C
} else { () }

});
}
;
## token quote:qr {
sub quote__S_124qr__PEEK { $_[0]->_AUTOLEXpeek('quote__S_124qr', $retree) }
sub quote__S_124qr {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE quote__S_124qr");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "qr";
$self->_MATCHIFYr($S, "quote__S_124qr", do {
my $C = $C;
if (($C) = ($C->_PATTERN(qr/\Gqr\b/))
and ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\(")
}))) { ($C) } else { () }
}))
and ($C) = ($C->_SUBSUMEr(['quibble'], sub {
my $C = shift;
$C->quibble( $C->cursor_fresh( $::LANG{'Regex'} ) )
}))) {
$C->_SUBSUMEr(['p5rx_mods'], sub {
my $C = shift;
$C->p5rx_mods
})
} else { () }

});
}
;
## token quote:m  {
sub quote__S_125m__PEEK { $_[0]->_AUTOLEXpeek('quote__S_125m', $retree) }
sub quote__S_125m {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE quote__S_125m");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "m";
$self->_MATCHIFYr($S, "quote__S_125m", do {
my $C = $C;
if (($C) = ($C->_PATTERN(qr/\Gm\b/))
and ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\(")
}))) { ($C) } else { () }
}))
and ($C) = ($C->_SUBSUMEr(['quibble'], sub {
my $C = shift;
$C->quibble( $C->cursor_fresh( $::LANG{'Regex'} ) )
}))) {
$C->_SUBSUMEr(['p5rx_mods'], sub {
my $C = shift;
$C->p5rx_mods
})
} else { () }

});
}
;
## token quote:s {
sub quote__S_126s__PEEK { $_[0]->_AUTOLEXpeek('quote__S_126s', $retree) }
sub quote__S_126s {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE quote__S_126s");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "s";
$self->_MATCHIFYr($S, "quote__S_126s", do {
my $C = $C;
if (($C) = ($C->_PATTERN(qr/\Gs\b/))
and ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\(")
}))) { ($C) } else { () }
}))
and ($C) = ($C->_SUBSUMEr(['pat','sibble'], sub {
my $C = shift;
$C->sibble( $C->cursor_fresh( $::LANG{'Regex'} ), $C->cursor_fresh( $::LANG{'Q'} )->tweak('qq' => 1))
}))) {
$C->_SUBSUMEr(['p5rx_mods'], sub {
my $C = shift;
$C->p5rx_mods
})
} else { () }

});
}
;
## token quote:tr {
sub quote__S_127tr__PEEK { $_[0]->_AUTOLEXpeek('quote__S_127tr', $retree) }
sub quote__S_127tr {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE quote__S_127tr");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "tr";
$self->_MATCHIFYr($S, "quote__S_127tr", do {
my $C = $C;
if (($C) = ($C->_PATTERN(qr/\Gtr\b/))
and ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\(")
}))) { ($C) } else { () }
}))
and ($C) = ($C->_SUBSUMEr(['pat','tribble'], sub {
my $C = shift;
$C->tribble( $C->cursor_fresh( $::LANG{'Q'} )->tweak('q' => 1))
}))) {
$C->_SUBSUMEr(['p5tr_mods'], sub {
my $C = shift;
$C->p5tr_mods
})
} else { () }

});
}
;
## token p5rx_mods {
sub p5rx_mods__PEEK { $_[0]->_AUTOLEXpeek('p5rx_mods', $retree) }
sub p5rx_mods {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5rx_mods");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "p5rx_mods", do {
if (my ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->after(sub {
my $C=shift;
$C->_PATTERN(qr/\G(?<=\w)/)
}))) { ($C) } else { () }
}))) {
$C->_SUBSUMEr(['0'], sub {
my $C = shift;
$C->_PAREN( sub {
my $C=shift;
$C->_PLUSr(sub {
my $C=shift;
if (my ($C) = ($C->_ARRAY( qw< i g s m x c e > ))) { ($C) } else { () }
})

})
})
} else { () }

});
}
;
## token p5tr_mods {
sub p5tr_mods__PEEK { $_[0]->_AUTOLEXpeek('p5tr_mods', $retree) }
sub p5tr_mods {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5tr_mods");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "p5tr_mods", $C->_SUBSUMEr(['0'], sub {
my $C = shift;
$C->_PAREN( sub {
my $C=shift;
$C->_PLUSr(sub {
my $C=shift;
if (my ($C) = ($C->_ARRAY( qw< c d s ] > ))) { ($C) } else { () }
})

})
}));
}
;
## method peek_delimiters
sub peek_delimiters {
no warnings 'recursion';
my $self = shift;
my $pos = $self->{'_pos'};
my $startpos = $pos;
my $char = substr($::ORIG,$pos++,1);
if ($char =~ /^\s$/) {
$self->panic("Whitespace character is not allowed as delimiter")}
elsif ($char =~ /^\w$/) {
$self->panic("Alphanumeric character is not allowed as delimiter")}
elsif ($STD::close2open{$char}) {
$self->panic("Use of a closing delimiter for an opener is reserved")};
my $rightbrack = $STD::open2close{$char};
if (not defined $rightbrack) {
return $char, $char};
while (substr($::ORIG,$pos,1) eq $char) {
$pos++}
;
my $len = $pos - $startpos;
my $start = $char x $len;
my $stop = $rightbrack x $len;
return $start, $stop;
};
{     package STD::P5::startstop;
require "mangle.pl";
our %INSTANTIATED;
sub __instantiate__ { my $self = shift;
my ($start, $stop) = @_;
my $mangle = ::mangle($start, $stop);
my $mixin = "STD::P5::startstop::" . $mangle;
return $mixin if $INSTANTIATED{$mixin}++;
::deb("         instantiating $mixin") if $::DEBUG & DEBUG::mixins;
my $eval = "package $mixin" . q{;
	    sub _PARAMS { { '$start' => $start, '$stop' => $stop } }
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::startstop', 1 };
our $REGEXES = {
ALL => [ qw/starter stopper/ ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

$retree = YAML::XS::Load(Encode::encode_utf8(<<'RETREE_END'));
---
starter: !!perl/hash:RE_ast
  dba: starter
  dic: STD::P5::startstop
  re: !!perl/hash:RE_var
    var: $start
stopper: !!perl/hash:RE_ast
  dba: stopper
  dic: STD::P5::startstop
  re: !!perl/hash:RE_var
    var: $stop
RETREE_END
## token starter { $start }
sub starter__PEEK { $_[0]->_AUTOLEXpeek('starter', $retree) }
sub starter {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE starter");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "starter", $C->_EXACT($start));
}
;
## token stopper { $stop }
sub stopper__PEEK { $_[0]->_AUTOLEXpeek('stopper', $retree) }
sub stopper {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE stopper");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "stopper", $C->_EXACT($stop));
}
;
	};
	eval $eval;
	die $@ if $@;
	return $mixin;
}
1; };
{     package STD::P5::stop;
require "mangle.pl";
our %INSTANTIATED;
sub __instantiate__ { my $self = shift;
my ($stop) = @_;
my $mangle = ::mangle($stop);
my $mixin = "STD::P5::stop::" . $mangle;
return $mixin if $INSTANTIATED{$mixin}++;
::deb("         instantiating $mixin") if $::DEBUG & DEBUG::mixins;
my $eval = "package $mixin" . q{;
	    sub _PARAMS { { '$stop' => $stop } }
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::stop', 1 };
our $REGEXES = {
ALL => [ qw/starter stopper/ ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

$retree = YAML::XS::Load(Encode::encode_utf8(<<'RETREE_END'));
---
starter: !!perl/hash:RE_ast
  dba: starter
  dic: STD::P5::stop
  re: !!perl/hash:RE_assertion
    assert: '!'
    re: !!perl/hash:RE_noop
      nobind: 1
stopper: !!perl/hash:RE_ast
  dba: stopper
  dic: STD::P5::stop
  re: !!perl/hash:RE_var
    var: $stop
RETREE_END
## token starter { <!> }
sub starter__PEEK { $_[0]->_AUTOLEXpeek('starter', $retree) }
sub starter {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE starter");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "starter", $C->_NOTBEFORE(sub {
my $C=shift;
$C
}));
}
;
## token stopper { $stop }
sub stopper__PEEK { $_[0]->_AUTOLEXpeek('stopper', $retree) }
sub stopper {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE stopper");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "stopper", $C->_EXACT($stop));
}
;
	};
	eval $eval;
	die $@ if $@;
	return $mixin;
}
1; };
{     package STD::P5::unitstop;
require "mangle.pl";
our %INSTANTIATED;
sub __instantiate__ { my $self = shift;
my ($stop) = @_;
my $mangle = ::mangle($stop);
my $mixin = "STD::P5::unitstop::" . $mangle;
return $mixin if $INSTANTIATED{$mixin}++;
::deb("         instantiating $mixin") if $::DEBUG & DEBUG::mixins;
my $eval = "package $mixin" . q{;
	    sub _PARAMS { { '$stop' => $stop } }
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::unitstop', 1 };
our $REGEXES = {
ALL => [ qw/unitstopper/ ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

$retree = YAML::XS::Load(Encode::encode_utf8(<<'RETREE_END'));
---
unitstopper: !!perl/hash:RE_ast
  dba: unitstopper
  dic: STD::P5::unitstop
  re: !!perl/hash:RE_var
    var: $stop
RETREE_END
## token unitstopper { $stop }
sub unitstopper__PEEK { $_[0]->_AUTOLEXpeek('unitstopper', $retree) }
sub unitstopper {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE unitstopper");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "unitstopper", $C->_EXACT($stop));
}
	};
	eval $eval;
	die $@ if $@;
	return $mixin;
}
1; };
## token unitstopper { $ }
sub unitstopper__PEEK { $_[0]->_AUTOLEXpeek('unitstopper', $retree) }
sub unitstopper {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE unitstopper");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "unitstopper", $C->_PATTERN(qr/\G\z/));
}
;
## method balanced ($start,$stop)
sub balanced {
no warnings 'recursion';
my $self = shift;
die 'Required argument start omitted' unless @_;
my $start = @_ ? shift() : undef;
die 'Required argument stop omitted' unless @_;
my $stop = @_ ? shift() : undef;
$self->mixin( STD::P5::startstop->__instantiate__($start,$stop) )};
## method unbalanced ($stop)
sub unbalanced {
no warnings 'recursion';
my $self = shift;
die 'Required argument stop omitted' unless @_;
my $stop = @_ ? shift() : undef;
$self->mixin( STD::P5::stop->__instantiate__($stop) )};
## method unitstop ($stop)
sub unitstop {
no warnings 'recursion';
my $self = shift;
die 'Required argument stop omitted' unless @_;
my $stop = @_ ? shift() : undef;
$self->mixin( STD::P5::unitstop->__instantiate__($stop) )};
## token charname {
sub charname__PEEK { $_[0]->_AUTOLEXpeek('charname', $retree) }
sub charname {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE charname");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "charname", do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'charname_0') {
$C->deb("Fate passed to charname_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT charname_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM charname_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'charname_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("charname_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_SUBSUMEr(['radint'], sub {
my $C = shift;
$C->radint
})
},
sub {
my $C=shift;
if (my ($C) = (do {
if (my ($C) = ($C->_PATTERN(qr/\G[a-zA-Z]/))) {
STD::LazyMap::lazymap(sub {
my $C=shift;
if (($C) = ($C->_PATTERN(qr/\G[a-zA-Z)]/))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G\s*+[\],\#]/)
}))) { ($C) } else { () }
}))) {
$C
} else { () }
},
$C->_STARf(sub {
my $C=shift;
$C->_PATTERN(qr/\G[^\],\#]/)
}))
} else { () }

})) { ($C) } else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) { ($C) } else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->panic("Unrecognized character name"))) { ($C) } else { () }

}
};
@gather;
});
}
;
## token charnames { [<.ws><charname><.ws>] ** ',' }
sub charnames__PEEK { $_[0]->_AUTOLEXpeek('charnames', $retree) }
sub charnames {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE charnames");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'charname'} = [];
$self->_MATCHIFYr($S, "charnames", $C->_REPSEPr( sub {
my $C=shift;
$C->_EXACT("\,")
}, sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['charname'], sub {
my $C = shift;
$C->charname
}))
and ($C) = ($C->ws)) {
$C
} else { () }
}))) { ($C) } else { () }
}));
}
;
## token charspec {
sub charspec__PEEK { $_[0]->_AUTOLEXpeek('charspec', $retree) }
sub charspec {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE charspec");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "charspec", $C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'charspec_0') {
$C->deb("Fate passed to charspec_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT charspec_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM charspec_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'charspec_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("charspec_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\]";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\["))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['charnames'], sub {
my $C = shift;
$C->charnames
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\]")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'character name', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) { ($C) } else { () }
},
sub {
my $C=shift;
$C->_PATTERN(qr/\G\d++/)
},
sub {
my $C=shift;
$C->_PATTERN(qr/\G[?-Z\\-_]/)
},
sub {
my $C=shift;
if (($C) = ($C->before(sub {
my $C=shift;
$C
}))
and ($C) = ($C->panic("Unrecognized \\c character"))) {
$C
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}));
}
;
## method truly ($bool,$opt)
sub truly {
no warnings 'recursion';
my $self = shift;
die 'Required argument bool omitted' unless @_;
my $bool = @_ ? shift() : undef;
die 'Required argument opt omitted' unless @_;
my $opt = @_ ? shift() : undef;
return $self if $bool;
$self->panic("Can't negate $opt adverb");
};
{ package STD::P5::Q;
use Moose ':all' => { -prefix => "moose_" };
use Encode;
moose_extends('STD');
our $ALLROLES = { 'STD::P5::Q', 1 };
our $REGEXES = {
ALL => [ qw// ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

{ package STD::P5::Q::b1;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::Q::b1', 1 };
our $REGEXES = {
ALL => [ qw/p5backslash p5escape/ ],
p5backslash => [ qw/p5backslash__S_001qq__PEEK p5backslash__S_002Back__PEEK p5backslash__S_003stopper__PEEK p5backslash__S_004a__PEEK p5backslash__S_005b__PEEK p5backslash__S_006c__PEEK p5backslash__S_007e__PEEK p5backslash__S_008f__PEEK p5backslash__S_009n__PEEK p5backslash__S_010o__PEEK p5backslash__S_011r__PEEK p5backslash__S_012t__PEEK p5backslash__S_013x__PEEK p5backslash__S_0140__PEEK/ ],
p5escape => [ qw/p5escape__S_000Back__PEEK/ ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

$retree = YAML::XS::Load(Encode::encode_utf8(<<'RETREE_END'));
---
p5backslash__S_001qq: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Q::b1
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_string
          i: 0
          text: q
    - !!perl/hash:RE_block {}
p5backslash__S_002Back: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Q::b1
  re: !!perl/hash:RE_bindnamed
    atom: !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: \
p5backslash__S_003stopper: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Q::b1
  re: !!perl/hash:RE_bindnamed
    atom: !!perl/hash:RE_method
      name: stopper
      rest: ''
p5backslash__S_004a: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Q::b1
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: a
p5backslash__S_005b: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Q::b1
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: b
p5backslash__S_006c: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Q::b1
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: c
    - !!perl/hash:RE_method
      name: charspec
      rest: ''
p5backslash__S_007e: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Q::b1
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: e
p5backslash__S_008f: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Q::b1
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: f
p5backslash__S_009n: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Q::b1
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: n
p5backslash__S_010o: !!perl/hash:RE_ast
  dba: octal character
  dic: STD::P5::Q::b1
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: o
    - !!perl/hash:RE_bracket
      re: &1 !!perl/hash:RE_any
        altname: p5backslash__S_010o_0
        dba: octal character
        dic: STD::P5::Q::b1
        zyg:
        - !!perl/hash:RE_method
          alt: p5backslash__S_010o_0 0
          name: octint
          rest: ''
        - !!perl/hash:RE_bracket
          alt: p5backslash__S_010o_0 1
          re: !!perl/hash:RE_sequence
            zyg:
            - !!perl/hash:RE_string
              i: 0
              text: '['
            - !!perl/hash:RE_block {}
            - !!perl/hash:RE_method
              name: octints
              rest: ''
            - !!perl/hash:RE_bracket
              re: !!perl/hash:RE_first
                zyg:
                - !!perl/hash:RE_string
                  i: 0
                  text: ']'
                - !!perl/hash:RE_method
                  name: FAILGOAL
                  rest: 1
p5backslash__S_010o_0: *1
p5backslash__S_011r: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Q::b1
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: r
p5backslash__S_012t: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Q::b1
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: t
p5backslash__S_013x: !!perl/hash:RE_ast
  dba: hex character
  dic: STD::P5::Q::b1
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: x
    - !!perl/hash:RE_bracket
      re: &2 !!perl/hash:RE_any
        altname: p5backslash__S_013x_0
        dba: hex character
        dic: STD::P5::Q::b1
        zyg:
        - !!perl/hash:RE_method
          alt: p5backslash__S_013x_0 0
          name: hexint
          rest: ''
        - !!perl/hash:RE_bracket
          alt: p5backslash__S_013x_0 1
          re: !!perl/hash:RE_sequence
            zyg:
            - !!perl/hash:RE_string
              i: 0
              text: '['
            - !!perl/hash:RE_block {}
            - !!perl/hash:RE_method
              name: hexints
              rest: ''
            - !!perl/hash:RE_bracket
              re: !!perl/hash:RE_first
                zyg:
                - !!perl/hash:RE_string
                  i: 0
                  text: ']'
                - !!perl/hash:RE_method
                  name: FAILGOAL
                  rest: 1
p5backslash__S_013x_0: *2
p5backslash__S_0140: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Q::b1
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: '0'
p5escape__S_000Back: !!perl/hash:RE_ast
  dba: p5escape
  dic: STD::P5::Q::b1
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: \
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: p5backslash
        rest: ''
RETREE_END
## token p5escape:sym<\\> { <sym> <item=p5backslash> }
sub p5escape__S_000Back__PEEK { $_[0]->_AUTOLEXpeek('p5escape__S_000Back', $retree) }
sub p5escape__S_000Back {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5escape__S_000Back");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\\";
$self->_MATCHIFYr($S, "p5escape__S_000Back", do {
if (my ($C) = ($C->_EXACT("\\"))) {
$C->_SUBSUMEr(['item','p5backslash'], sub {
my $C = shift;
$C->p5backslash
})
} else { () }

});
}
;
## token p5backslash:qq { <?before 'q'> { $<quote> = $¢.cursor_fresh(%*LANG<MAIN>).quote(); } }
sub p5backslash__S_001qq__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_001qq', $retree) }
sub p5backslash__S_001qq {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_001qq");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "qq";
$self->_MATCHIFYr($S, "p5backslash__S_001qq", do {
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("q")
}))) { ($C) } else { () }
}))) {
scalar(do {
my $M = $C;
$M->{'quote'} = $C->cursor_fresh($::LANG{'MAIN'})->quote()}, $C)
} else { () }

});
}
;
## token p5backslash:sym<\\> { <text=sym> }
sub p5backslash__S_002Back__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_002Back', $retree) }
sub p5backslash__S_002Back {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_002Back");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\\";
$self->_MATCHIFYr($S, "p5backslash__S_002Back", $C->_SUBSUMEr(['text'], sub {
my $C = shift;
$C->_EXACT("\\")
}));
}
;
## token p5backslash:stopper { <text=stopper> }
sub p5backslash__S_003stopper__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_003stopper', $retree) }
sub p5backslash__S_003stopper {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_003stopper");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "stopper";
$self->_MATCHIFYr($S, "p5backslash__S_003stopper", $C->_SUBSUMEr(['text','stopper'], sub {
my $C = shift;
$C->stopper
}));
}
;
## token p5backslash:a { <sym> }
sub p5backslash__S_004a__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_004a', $retree) }
sub p5backslash__S_004a {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_004a");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "a";
$self->_MATCHIFYr($S, "p5backslash__S_004a", $C->_EXACT("a"));
}
;
## token p5backslash:b { <sym> }
sub p5backslash__S_005b__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_005b', $retree) }
sub p5backslash__S_005b {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_005b");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "b";
$self->_MATCHIFYr($S, "p5backslash__S_005b", $C->_EXACT("b"));
}
;
## token p5backslash:c { <sym> <charspec> }
sub p5backslash__S_006c__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_006c', $retree) }
sub p5backslash__S_006c {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_006c");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "c";
$self->_MATCHIFYr($S, "p5backslash__S_006c", do {
if (my ($C) = ($C->_EXACT("c"))) {
$C->_SUBSUMEr(['charspec'], sub {
my $C = shift;
$C->charspec
})
} else { () }

});
}
;
## token p5backslash:e { <sym> }
sub p5backslash__S_007e__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_007e', $retree) }
sub p5backslash__S_007e {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_007e");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "e";
$self->_MATCHIFYr($S, "p5backslash__S_007e", $C->_EXACT("e"));
}
;
## token p5backslash:f { <sym> }
sub p5backslash__S_008f__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_008f', $retree) }
sub p5backslash__S_008f {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_008f");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "f";
$self->_MATCHIFYr($S, "p5backslash__S_008f", $C->_EXACT("f"));
}
;
## token p5backslash:n { <sym> }
sub p5backslash__S_009n__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_009n', $retree) }
sub p5backslash__S_009n {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_009n");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "n";
$self->_MATCHIFYr($S, "p5backslash__S_009n", $C->_EXACT("n"));
}
;
## token p5backslash:o { :dba('octal character') <sym> [ <octint> | '[' ~ ']' <octints> ] }
sub p5backslash__S_010o__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_010o', $retree) }
sub p5backslash__S_010o {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_010o");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "o";
$self->_MATCHIFYr($S, "p5backslash__S_010o", do {
my $C = $C;
if (($C) = ($C->_EXACT("o"))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'p5backslash__S_010o_0') {
$C->deb("Fate passed to p5backslash__S_010o_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5backslash__S_010o_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM p5backslash__S_010o_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Q::b1', 'p5backslash__S_010o_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("p5backslash__S_010o_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_SUBSUMEr(['octint'], sub {
my $C = shift;
$C->octint
})
},
sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\]";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\["))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['octints'], sub {
my $C = shift;
$C->octints
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\]")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'octal character', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) { ($C) } else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

});
}
;
## token p5backslash:r { <sym> }
sub p5backslash__S_011r__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_011r', $retree) }
sub p5backslash__S_011r {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_011r");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "r";
$self->_MATCHIFYr($S, "p5backslash__S_011r", $C->_EXACT("r"));
}
;
## token p5backslash:t { <sym> }
sub p5backslash__S_012t__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_012t', $retree) }
sub p5backslash__S_012t {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_012t");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "t";
$self->_MATCHIFYr($S, "p5backslash__S_012t", $C->_EXACT("t"));
}
;
## token p5backslash:x { :dba('hex character') <sym> [ <hexint> | '[' ~ ']' <hexints> ] }
sub p5backslash__S_013x__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_013x', $retree) }
sub p5backslash__S_013x {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_013x");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "x";
$self->_MATCHIFYr($S, "p5backslash__S_013x", do {
my $C = $C;
if (($C) = ($C->_EXACT("x"))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'p5backslash__S_013x_0') {
$C->deb("Fate passed to p5backslash__S_013x_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5backslash__S_013x_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM p5backslash__S_013x_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Q::b1', 'p5backslash__S_013x_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("p5backslash__S_013x_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_SUBSUMEr(['hexint'], sub {
my $C = shift;
$C->hexint
})
},
sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\]";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\["))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['hexints'], sub {
my $C = shift;
$C->hexints
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\]")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'hex character', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) { ($C) } else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

});
}
;
## token p5backslash:sym<0> { <sym> }
sub p5backslash__S_0140__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_0140', $retree) }
sub p5backslash__S_0140 {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_0140");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "p5backslash__S_0140", $C->_EXACT("0"));
}
;
1; };
{ package STD::P5::Q::b0;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::Q::b0', 1 };
our $REGEXES = {
ALL => [ qw/p5escape/ ],
p5escape => [ qw/p5escape__S_000Back__PEEK/ ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

$retree = YAML::XS::Load(Encode::encode_utf8(<<'RETREE_END'));
---
p5escape__S_000Back: !!perl/hash:RE_ast
  dba: p5escape
  dic: STD::P5::Q::b0
  re: !!perl/hash:RE_assertion
    assert: '!'
    re: !!perl/hash:RE_noop
      nobind: 1
RETREE_END
## token p5escape:sym<\\> { <!> }
sub p5escape__S_000Back__PEEK { $_[0]->_AUTOLEXpeek('p5escape__S_000Back', $retree) }
sub p5escape__S_000Back {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5escape__S_000Back");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\\";
$self->_MATCHIFYr($S, "p5escape__S_000Back", $C->_NOTBEFORE(sub {
my $C=shift;
$C
}));
}
1; };
{ package STD::P5::Q::c1;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::Q::c1', 1 };
our $REGEXES = {
ALL => [ qw/p5escape/ ],
p5escape => [ qw/p5escape__S_000Cur_Ly__PEEK/ ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

$retree = YAML::XS::Load(Encode::encode_utf8(<<'RETREE_END'));
---
p5escape__S_000Cur_Ly: !!perl/hash:RE_ast
  dba: p5escape
  dic: STD::P5::Q::c1
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_string
          i: 0
          text: '{'
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_sequence
        zyg:
        - !!perl/hash:RE_decl {}
        - !!perl/hash:RE_method
          name: block
          rest: ''
RETREE_END
## token p5escape:sym<{ }> { <?before '{'> [ :lang(%*LANG<MAIN>) <block> ] }
sub p5escape__S_000Cur_Ly__PEEK { $_[0]->_AUTOLEXpeek('p5escape__S_000Cur_Ly', $retree) }
sub p5escape__S_000Cur_Ly {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5escape__S_000Cur_Ly");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\{\ \}";
$self->_MATCHIFYr($S, "p5escape__S_000Cur_Ly", do {
my $C = $C;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\{")
}))) { ($C) } else { () }
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
my $newlang = ($::LANG{'MAIN'});
$C = bless($C, (ref($newlang) || $newlang));
$C->_SUBSUMEr(['block'], sub {
my $C = shift;
$C->block
})
}))) {
$C
} else { () }

});
}
1; };
{ package STD::P5::Q::c0;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::Q::c0', 1 };
our $REGEXES = {
ALL => [ qw/p5escape/ ],
p5escape => [ qw/p5escape__S_000Cur_Ly__PEEK/ ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

$retree = YAML::XS::Load(Encode::encode_utf8(<<'RETREE_END'));
---
p5escape__S_000Cur_Ly: !!perl/hash:RE_ast
  dba: p5escape
  dic: STD::P5::Q::c0
  re: !!perl/hash:RE_assertion
    assert: '!'
    re: !!perl/hash:RE_noop
      nobind: 1
RETREE_END
## token p5escape:sym<{ }> { <!> }
sub p5escape__S_000Cur_Ly__PEEK { $_[0]->_AUTOLEXpeek('p5escape__S_000Cur_Ly', $retree) }
sub p5escape__S_000Cur_Ly {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5escape__S_000Cur_Ly");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\{\ \}";
$self->_MATCHIFYr($S, "p5escape__S_000Cur_Ly", $C->_NOTBEFORE(sub {
my $C=shift;
$C
}));
}
1; };
{ package STD::P5::Q::s1;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::Q::s1', 1 };
our $REGEXES = {
ALL => [ qw/p5escape/ ],
p5escape => [ qw/p5escape__S_000Dollar__PEEK/ ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

$retree = YAML::XS::Load(Encode::encode_utf8(<<'RETREE_END'));
---
p5escape__S_000Dollar: !!perl/hash:RE_ast
  dba: p5escape
  dic: STD::P5::Q::s1
  re: !!perl/hash:RE_first
    zyg:
    - !!perl/hash:RE_sequence
      zyg:
      - !!perl/hash:RE_assertion
        assert: '?'
        re: !!perl/hash:RE_method_re
          name: before
          nobind: 1
          re: !!perl/hash:RE_string
            i: 0
            text: $
      - !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_decl {}
          - !!perl/hash:RE_method
            name: EXPR
            rest: 1
    - !!perl/hash:RE_method
      name: panic
      rest: 1
RETREE_END
## token p5escape:sym<$> {
sub p5escape__S_000Dollar__PEEK { $_[0]->_AUTOLEXpeek('p5escape__S_000Dollar', $retree) }
sub p5escape__S_000Dollar {
no warnings 'recursion';
my $self = shift;

local $::QSIGIL = '$';
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5escape__S_000Dollar");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$";
$self->_MATCHIFYr($S, "p5escape__S_000Dollar", do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\$")
}))) { ($C) } else { () }
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
my $newlang = ($::LANG{'MAIN'});
$C = bless($C, (ref($newlang) || $newlang));
$C->_SUBSUMEr(['EXPR'], sub {
my $C = shift;
$C->EXPR(\%methodcall)
})
}))) {
$C
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->panic("Non-variable \$ must be backslashed"))) { ($C) } else { () }

}
};
@gather;
});
}
1; };
{ package STD::P5::Q::s0;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::Q::s0', 1 };
our $REGEXES = {
ALL => [ qw/p5escape/ ],
p5escape => [ qw/p5escape__S_000Dollar__PEEK/ ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

$retree = YAML::XS::Load(Encode::encode_utf8(<<'RETREE_END'));
---
p5escape__S_000Dollar: !!perl/hash:RE_ast
  dba: p5escape
  dic: STD::P5::Q::s0
  re: !!perl/hash:RE_assertion
    assert: '!'
    re: !!perl/hash:RE_noop
      nobind: 1
RETREE_END
## token p5escape:sym<$> { <!> }
sub p5escape__S_000Dollar__PEEK { $_[0]->_AUTOLEXpeek('p5escape__S_000Dollar', $retree) }
sub p5escape__S_000Dollar {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5escape__S_000Dollar");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$";
$self->_MATCHIFYr($S, "p5escape__S_000Dollar", $C->_NOTBEFORE(sub {
my $C=shift;
$C
}));
}
1; };
{ package STD::P5::Q::a1;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::Q::a1', 1 };
our $REGEXES = {
ALL => [ qw/p5escape/ ],
p5escape => [ qw/p5escape__S_000At__PEEK/ ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

$retree = YAML::XS::Load(Encode::encode_utf8(<<'RETREE_END'));
---
p5escape__S_000At: !!perl/hash:RE_ast
  dba: p5escape
  dic: STD::P5::Q::a1
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_string
          i: 0
          text: '@'
    - !!perl/hash:RE_bracket
      re: &1 !!perl/hash:RE_any
        altname: p5escape__S_000At_0
        dba: p5escape
        dic: STD::P5::Q::a1
        zyg:
        - !!perl/hash:RE_sequence
          alt: p5escape__S_000At_0 0
          zyg:
          - !!perl/hash:RE_decl {}
          - !!perl/hash:RE_method
            name: EXPR
            rest: 1
        - !!perl/hash:RE_assertion
          alt: p5escape__S_000At_0 1
          assert: '!'
          re: !!perl/hash:RE_noop
            nobind: 1
p5escape__S_000At_0: *1
RETREE_END
## token p5escape:sym<@> {
sub p5escape__S_000At__PEEK { $_[0]->_AUTOLEXpeek('p5escape__S_000At', $retree) }
sub p5escape__S_000At {
no warnings 'recursion';
my $self = shift;

local $::QSIGIL = '@';
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5escape__S_000At");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\@";
$self->_MATCHIFYr($S, "p5escape__S_000At", do {
my $C = $C;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\@")
}))) { ($C) } else { () }
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'p5escape__S_000At_0') {
$C->deb("Fate passed to p5escape__S_000At_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5escape__S_000At_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM p5escape__S_000At_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Q::a1', 'p5escape__S_000At_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("p5escape__S_000At_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = (do {
my $newlang = ($::LANG{'MAIN'});
$C = bless($C, (ref($newlang) || $newlang));
$C->_SUBSUMEr(['EXPR'], sub {
my $C = shift;
$C->EXPR(\%methodcall)
})

})) { ($C) } else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
$C
}))) { ($C) } else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

});
}
1; };
{ package STD::P5::Q::a0;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::Q::a0', 1 };
our $REGEXES = {
ALL => [ qw/p5escape/ ],
p5escape => [ qw/p5escape__S_000At__PEEK/ ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

$retree = YAML::XS::Load(Encode::encode_utf8(<<'RETREE_END'));
---
p5escape__S_000At: !!perl/hash:RE_ast
  dba: p5escape
  dic: STD::P5::Q::a0
  re: !!perl/hash:RE_assertion
    assert: '!'
    re: !!perl/hash:RE_noop
      nobind: 1
RETREE_END
## token p5escape:sym<@> { <!> }
sub p5escape__S_000At__PEEK { $_[0]->_AUTOLEXpeek('p5escape__S_000At', $retree) }
sub p5escape__S_000At {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5escape__S_000At");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\@";
$self->_MATCHIFYr($S, "p5escape__S_000At", $C->_NOTBEFORE(sub {
my $C=shift;
$C
}));
}
1; };
{ package STD::P5::Q::h1;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::Q::h1', 1 };
our $REGEXES = {
ALL => [ qw/p5escape/ ],
p5escape => [ qw/p5escape__S_000Percent__PEEK/ ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

$retree = YAML::XS::Load(Encode::encode_utf8(<<'RETREE_END'));
---
p5escape__S_000Percent: !!perl/hash:RE_ast
  dba: p5escape
  dic: STD::P5::Q::h1
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_string
          i: 0
          text: '%'
    - !!perl/hash:RE_bracket
      re: &1 !!perl/hash:RE_any
        altname: p5escape__S_000Percent_0
        dba: p5escape
        dic: STD::P5::Q::h1
        zyg:
        - !!perl/hash:RE_sequence
          alt: p5escape__S_000Percent_0 0
          zyg:
          - !!perl/hash:RE_decl {}
          - !!perl/hash:RE_method
            name: EXPR
            rest: 1
        - !!perl/hash:RE_assertion
          alt: p5escape__S_000Percent_0 1
          assert: '!'
          re: !!perl/hash:RE_noop
            nobind: 1
p5escape__S_000Percent_0: *1
RETREE_END
## token p5escape:sym<%> {
sub p5escape__S_000Percent__PEEK { $_[0]->_AUTOLEXpeek('p5escape__S_000Percent', $retree) }
sub p5escape__S_000Percent {
no warnings 'recursion';
my $self = shift;

local $::QSIGIL = '%';
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5escape__S_000Percent");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\%";
$self->_MATCHIFYr($S, "p5escape__S_000Percent", do {
my $C = $C;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\%")
}))) { ($C) } else { () }
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'p5escape__S_000Percent_0') {
$C->deb("Fate passed to p5escape__S_000Percent_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5escape__S_000Percent_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM p5escape__S_000Percent_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Q::h1', 'p5escape__S_000Percent_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("p5escape__S_000Percent_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = (do {
my $newlang = ($::LANG{'MAIN'});
$C = bless($C, (ref($newlang) || $newlang));
$C->_SUBSUMEr(['EXPR'], sub {
my $C = shift;
$C->EXPR(\%methodcall)
})

})) { ($C) } else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
$C
}))) { ($C) } else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

});
}
1; };
{ package STD::P5::Q::h0;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::Q::h0', 1 };
our $REGEXES = {
ALL => [ qw/p5escape/ ],
p5escape => [ qw/p5escape__S_000Percent__PEEK/ ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

$retree = YAML::XS::Load(Encode::encode_utf8(<<'RETREE_END'));
---
p5escape__S_000Percent: !!perl/hash:RE_ast
  dba: p5escape
  dic: STD::P5::Q::h0
  re: !!perl/hash:RE_assertion
    assert: '!'
    re: !!perl/hash:RE_noop
      nobind: 1
RETREE_END
## token p5escape:sym<%> { <!> }
sub p5escape__S_000Percent__PEEK { $_[0]->_AUTOLEXpeek('p5escape__S_000Percent', $retree) }
sub p5escape__S_000Percent {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5escape__S_000Percent");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\%";
$self->_MATCHIFYr($S, "p5escape__S_000Percent", $C->_NOTBEFORE(sub {
my $C=shift;
$C
}));
}
1; };
{ package STD::P5::Q::f1;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::Q::f1', 1 };
our $REGEXES = {
ALL => [ qw/p5escape/ ],
p5escape => [ qw/p5escape__S_000Amp__PEEK/ ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

$retree = YAML::XS::Load(Encode::encode_utf8(<<'RETREE_END'));
---
p5escape__S_000Amp: !!perl/hash:RE_ast
  dba: p5escape
  dic: STD::P5::Q::f1
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_string
          i: 0
          text: '&'
    - !!perl/hash:RE_bracket
      re: &1 !!perl/hash:RE_any
        altname: p5escape__S_000Amp_0
        dba: p5escape
        dic: STD::P5::Q::f1
        zyg:
        - !!perl/hash:RE_sequence
          alt: p5escape__S_000Amp_0 0
          zyg:
          - !!perl/hash:RE_decl {}
          - !!perl/hash:RE_method
            name: EXPR
            rest: 1
        - !!perl/hash:RE_assertion
          alt: p5escape__S_000Amp_0 1
          assert: '!'
          re: !!perl/hash:RE_noop
            nobind: 1
p5escape__S_000Amp_0: *1
RETREE_END
## token p5escape:sym<&> {
sub p5escape__S_000Amp__PEEK { $_[0]->_AUTOLEXpeek('p5escape__S_000Amp', $retree) }
sub p5escape__S_000Amp {
no warnings 'recursion';
my $self = shift;

local $::QSIGIL = '&';
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5escape__S_000Amp");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\&";
$self->_MATCHIFYr($S, "p5escape__S_000Amp", do {
my $C = $C;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\&")
}))) { ($C) } else { () }
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'p5escape__S_000Amp_0') {
$C->deb("Fate passed to p5escape__S_000Amp_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5escape__S_000Amp_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM p5escape__S_000Amp_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Q::f1', 'p5escape__S_000Amp_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("p5escape__S_000Amp_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = (do {
my $newlang = ($::LANG{'MAIN'});
$C = bless($C, (ref($newlang) || $newlang));
$C->_SUBSUMEr(['EXPR'], sub {
my $C = shift;
$C->EXPR(\%methodcall)
})

})) { ($C) } else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
$C
}))) { ($C) } else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

});
}
1; };
{ package STD::P5::Q::f0;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::Q::f0', 1 };
our $REGEXES = {
ALL => [ qw/p5escape/ ],
p5escape => [ qw/p5escape__S_000Amp__PEEK/ ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

$retree = YAML::XS::Load(Encode::encode_utf8(<<'RETREE_END'));
---
p5escape__S_000Amp: !!perl/hash:RE_ast
  dba: p5escape
  dic: STD::P5::Q::f0
  re: !!perl/hash:RE_assertion
    assert: '!'
    re: !!perl/hash:RE_noop
      nobind: 1
RETREE_END
## token p5escape:sym<&> { <!> }
sub p5escape__S_000Amp__PEEK { $_[0]->_AUTOLEXpeek('p5escape__S_000Amp', $retree) }
sub p5escape__S_000Amp {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5escape__S_000Amp");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\&";
$self->_MATCHIFYr($S, "p5escape__S_000Amp", $C->_NOTBEFORE(sub {
my $C=shift;
$C
}));
}
1; };
{ package STD::P5::Q::w1;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::Q::w1', 1 };
our $REGEXES = {
ALL => [ qw// ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

## method postprocess ($s)
sub postprocess {
no warnings 'recursion';
my $self = shift;
die 'Required argument s omitted' unless @_;
my $s = @_ ? shift() : undef;
$s->words }  1; };
{ package STD::P5::Q::w0;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::Q::w0', 1 };
our $REGEXES = {
ALL => [ qw// ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

## method postprocess ($s)
sub postprocess {
no warnings 'recursion';
my $self = shift;
die 'Required argument s omitted' unless @_;
my $s = @_ ? shift() : undef;
$s }  1; };
{ package STD::P5::Q::ww1;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::Q::ww1', 1 };
our $REGEXES = {
ALL => [ qw// ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

## method postprocess ($s)
sub postprocess {
no warnings 'recursion';
my $self = shift;
die 'Required argument s omitted' unless @_;
my $s = @_ ? shift() : undef;
$s->words }  1; };
{ package STD::P5::Q::ww0;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::Q::ww0', 1 };
our $REGEXES = {
ALL => [ qw// ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

## method postprocess ($s)
sub postprocess {
no warnings 'recursion';
my $self = shift;
die 'Required argument s omitted' unless @_;
my $s = @_ ? shift() : undef;
$s }  1; };
{ package STD::P5::Q::x1;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::Q::x1', 1 };
our $REGEXES = {
ALL => [ qw// ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

## method postprocess ($s)
sub postprocess {
no warnings 'recursion';
my $self = shift;
die 'Required argument s omitted' unless @_;
my $s = @_ ? shift() : undef;
$s->run }  1; };
{ package STD::P5::Q::x0;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::Q::x0', 1 };
our $REGEXES = {
ALL => [ qw// ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

## method postprocess ($s)
sub postprocess {
no warnings 'recursion';
my $self = shift;
die 'Required argument s omitted' unless @_;
my $s = @_ ? shift() : undef;
$s }  1; };
{ package STD::P5::Q::q;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::Q::q', 1 };
our $REGEXES = {
ALL => [ qw/p5backslash p5escape stopper/ ],
p5backslash => [ qw/p5backslash__S_001qq__PEEK p5backslash__S_002Back__PEEK p5backslash__S_003stopper__PEEK p5backslash__S_004misc__PEEK/ ],
p5escape => [ qw/p5escape__S_000Back__PEEK/ ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

$retree = YAML::XS::Load(Encode::encode_utf8(<<'RETREE_END'));
---
p5backslash__S_001qq: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Q::q
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_string
          i: 0
          text: q
    - !!perl/hash:RE_block {}
p5backslash__S_002Back: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Q::q
  re: !!perl/hash:RE_bindnamed
    atom: !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: \
p5backslash__S_003stopper: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Q::q
  re: !!perl/hash:RE_bindnamed
    atom: !!perl/hash:RE_method
      name: stopper
      rest: ''
p5backslash__S_004misc: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Q::q
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_bindpos
      atom: !!perl/hash:RE_paren
        re: !!perl/hash:RE_meta
          min: 1
          text: .
    - !!perl/hash:RE_block {}
p5escape__S_000Back: !!perl/hash:RE_ast
  dba: p5escape
  dic: STD::P5::Q::q
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: \
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: p5backslash
        rest: ''
stopper: !!perl/hash:RE_ast
  dba: stopper
  dic: STD::P5::Q::q
  re: !!perl/hash:RE_meta
    min: 1
    text: \'
RETREE_END
## token stopper { \' }
sub stopper__PEEK { $_[0]->_AUTOLEXpeek('stopper', $retree) }
sub stopper {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE stopper");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "stopper", $C->_EXACT("\'"));
}
;
## token p5escape:sym<\\> { <sym> <item=p5backslash> }
sub p5escape__S_000Back__PEEK { $_[0]->_AUTOLEXpeek('p5escape__S_000Back', $retree) }
sub p5escape__S_000Back {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5escape__S_000Back");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\\";
$self->_MATCHIFYr($S, "p5escape__S_000Back", do {
if (my ($C) = ($C->_EXACT("\\"))) {
$C->_SUBSUMEr(['item','p5backslash'], sub {
my $C = shift;
$C->p5backslash
})
} else { () }

});
}
;
## token p5backslash:qq { <?before 'q'> { $<quote> = $¢.cursor_fresh(%*LANG<MAIN>).quote(); } }
sub p5backslash__S_001qq__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_001qq', $retree) }
sub p5backslash__S_001qq {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_001qq");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "qq";
$self->_MATCHIFYr($S, "p5backslash__S_001qq", do {
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("q")
}))) { ($C) } else { () }
}))) {
scalar(do {
my $M = $C;
$M->{'quote'} = $C->cursor_fresh($::LANG{'MAIN'})->quote()}, $C)
} else { () }

});
}
;
## token p5backslash:sym<\\> { <text=sym> }
sub p5backslash__S_002Back__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_002Back', $retree) }
sub p5backslash__S_002Back {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_002Back");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\\";
$self->_MATCHIFYr($S, "p5backslash__S_002Back", $C->_SUBSUMEr(['text'], sub {
my $C = shift;
$C->_EXACT("\\")
}));
}
;
## token p5backslash:stopper { <text=stopper> }
sub p5backslash__S_003stopper__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_003stopper', $retree) }
sub p5backslash__S_003stopper {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_003stopper");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "stopper";
$self->_MATCHIFYr($S, "p5backslash__S_003stopper", $C->_SUBSUMEr(['text','stopper'], sub {
my $C = shift;
$C->stopper
}));
}
;
## token p5backslash:misc { {} (.) { $<text> = "\\" ~ $0.Str; } }
sub p5backslash__S_004misc__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_004misc', $retree) }
sub p5backslash__S_004misc {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_004misc");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "misc";
$self->_MATCHIFYr($S, "p5backslash__S_004misc", do {
my $C = $C;
if (($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['0'], sub {
my $C = shift;
$C->_PAREN( sub {
my $C=shift;
$C->cursor_incr()

})
}))) {
scalar(do {
my $M = $C;
$M->{'text'} = "\\" . $M->{0}->Str}, $C)
} else { () }

});
}
;
## method tweak (:single(:$q)!)
;
## method tweak (:double(:$qq)!)
;
moose_around tweak  => sub {
my $orig = shift;
no warnings 'recursion';
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{single} || exists $args{q};
my $q = exists $args{single} ? delete $args{single} : exists $args{q} ? delete $args{q} : undef;
$self->panic("Too late for :q")     };
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{double} || exists $args{qq};
my $qq = exists $args{double} ? delete $args{double} : exists $args{qq} ? delete $args{qq} : undef;
$self->panic("Too late for :qq")     };
}
$orig->(@_);
};

1; };
{ package STD::P5::Q::qq;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
moose_with('STD::P5::Q::b1');
moose_with('STD::P5::Q::c1');
moose_with('STD::P5::Q::s1');
moose_with('STD::P5::Q::a1');
moose_with('STD::P5::Q::h1');
moose_with('STD::P5::Q::f1');
our $REGEXES = {
ALL => [ qw/p5backslash stopper/ ],
p5backslash => [ qw/p5backslash__S_000misc__PEEK/ ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

$retree = YAML::XS::Load(Encode::encode_utf8(<<'RETREE_END'));
---
p5backslash__S_000misc: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Q::qq
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_bracket
      re: &1 !!perl/hash:RE_any
        altname: p5backslash__S_000misc_0
        dba: p5backslash
        dic: STD::P5::Q::qq
        zyg:
        - !!perl/hash:RE_sequence
          alt: p5backslash__S_000misc_0 0
          zyg:
          - !!perl/hash:RE_bindpos
            atom: !!perl/hash:RE_paren
              re: !!perl/hash:RE_meta
                min: 1
                text: \W
          - !!perl/hash:RE_block {}
        - !!perl/hash:RE_sequence
          alt: p5backslash__S_000misc_0 1
          zyg:
          - !!perl/hash:RE_bindnamed
            atom: !!perl/hash:RE_paren
              re: !!perl/hash:RE_meta
                min: 1
                text: \w
          - !!perl/hash:RE_method
            name: panic
            rest: 1
p5backslash__S_000misc_0: *1
stopper: !!perl/hash:RE_ast
  dba: stopper
  dic: STD::P5::Q::qq
  re: !!perl/hash:RE_meta
    min: 1
    text: \"
RETREE_END
## token stopper { \" }
sub stopper__PEEK { $_[0]->_AUTOLEXpeek('stopper', $retree) }
sub stopper {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE stopper");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "stopper", $C->_EXACT("\""));
}
;
## token p5backslash:misc { {} [ (\W) { $<text> = $0.Str; } | $<x>=(\w) <.panic("Unrecognized backslash
sub p5backslash__S_000misc__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_000misc', $retree) }
sub p5backslash__S_000misc {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_000misc");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "misc";
$self->_MATCHIFYr($S, "p5backslash__S_000misc", do {
my $C = $C;
if (($C) = (scalar(do {
}, $C))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'p5backslash__S_000misc_0') {
$C->deb("Fate passed to p5backslash__S_000misc_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5backslash__S_000misc_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM p5backslash__S_000misc_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Q::qq', 'p5backslash__S_000misc_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("p5backslash__S_000misc_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->_SUBSUMEr(['0'], sub {
my $C = shift;
$C->_PAREN( sub {
my $C=shift;
$C->_PATTERN(qr/\G\W/)

})
}))) {
scalar(do {
my $M = $C;
$M->{'text'} = $M->{0}->Str}, $C)
} else { () }
},
sub {
my $C=shift;
if (($C) = ($C->_SUBSUMEr(['x'], sub {
my $C = shift;
$C->_PAREN( sub {
my $C=shift;
$C->_PATTERN(qr/\G\w/)

})
}))
and ($C) = (do {
my $M = $C;
$C->panic("Unrecognized backslash sequence: '\\" . $M->{'x'}->Str . "'")
})) {
$C
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

});
}
;
## method tweak (:single(:$q)!)
;
## method tweak (:double(:$qq)!)
;
moose_around tweak  => sub {
my $orig = shift;
no warnings 'recursion';
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{single} || exists $args{q};
my $q = exists $args{single} ? delete $args{single} : exists $args{q} ? delete $args{q} : undef;
$self->panic("Too late for :q")     };
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{double} || exists $args{qq};
my $qq = exists $args{double} ? delete $args{double} : exists $args{qq} ? delete $args{qq} : undef;
$self->panic("Too late for :qq")     };
}
$orig->(@_);
};

1; };
{ package STD::P5::Q::p5;
use Moose::Role ':all' => { -prefix => "moose_" };
use Encode;
our $ALLROLES = { 'STD::P5::Q::p5', 1 };
our $REGEXES = {
ALL => [ qw// ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

## method tweak (:$g!)
;
## method tweak (:$i!)
;
## method tweak (:$m!)
;
## method tweak (:$s!)
;
## method tweak (:$x!)
;
## method tweak (:$p!)
;
## method tweak (:$c!)
;
moose_around tweak  => sub {
my $orig = shift;
no warnings 'recursion';
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{g};
my $g = exists $args{g} ? delete $args{g} : undef;
$self     };
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{i};
my $i = exists $args{i} ? delete $args{i} : undef;
$self     };
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{m};
my $m = exists $args{m} ? delete $args{m} : undef;
$self     };
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{s};
my $s = exists $args{s} ? delete $args{s} : undef;
$self     };
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{x};
my $x = exists $args{x} ? delete $args{x} : undef;
$self     };
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{p};
my $p = exists $args{p} ? delete $args{p} : undef;
$self     };
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{c};
my $c = exists $args{c} ? delete $args{c} : undef;
$self     };
}
$orig->(@_);
};

1; };
## method tweak (:single(:$q)!)
;
## method tweak (:double(:$qq)!)
;
## method tweak (:backslash(:$b)!)
;
## method tweak (:scalar(:$s)!)
;
## method tweak (:array(:$a)!)
;
## method tweak (:hash(:$h)!)
;
## method tweak (:function(:$f)!)
;
## method tweak (:closure(:$c)!)
;
## method tweak (:exec(:$x)!)
;
## method tweak (:words(:$w)!)
;
## method tweak (:quotewords(:$ww)!)
;
## method tweak (:heredoc(:$to)!)
;
## method tweak (:$regex!)
;
## method tweak (:$trans!)
;
## method tweak (*%x)
;
moose_around tweak  => sub {
my $orig = shift;
no warnings 'recursion';
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{single} || exists $args{q};
my $q = exists $args{single} ? delete $args{single} : exists $args{q} ? delete $args{q} : undef;
$self->truly($q,':q');
$self->mixin( 'STD::P5::Q::q' );
};
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{double} || exists $args{qq};
my $qq = exists $args{double} ? delete $args{double} : exists $args{qq} ? delete $args{qq} : undef;
$self->truly($qq, ':qq');
$self->mixin( 'STD::P5::Q::qq' );
};
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{backslash} || exists $args{b};
my $b = exists $args{backslash} ? delete $args{backslash} : exists $args{b} ? delete $args{b} : undef;
$self->mixin($b ? 'STD::P5::Q::b1' : 'STD::P5::Q::b0')     };
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{scalar} || exists $args{s};
my $s = exists $args{scalar} ? delete $args{scalar} : exists $args{s} ? delete $args{s} : undef;
$self->mixin($s ? 'STD::P5::Q::s1' : 'STD::P5::Q::s0')     };
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{array} || exists $args{a};
my $a = exists $args{array} ? delete $args{array} : exists $args{a} ? delete $args{a} : undef;
$self->mixin($a ? 'STD::P5::Q::a1' : 'STD::P5::Q::a0')     };
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{hash} || exists $args{h};
my $h = exists $args{hash} ? delete $args{hash} : exists $args{h} ? delete $args{h} : undef;
$self->mixin($h ? 'STD::P5::Q::h1' : 'STD::P5::Q::h0')     };
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{function} || exists $args{f};
my $f = exists $args{function} ? delete $args{function} : exists $args{f} ? delete $args{f} : undef;
$self->mixin($f ? 'STD::P5::Q::f1' : 'STD::P5::Q::f0')     };
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{closure} || exists $args{c};
my $c = exists $args{closure} ? delete $args{closure} : exists $args{c} ? delete $args{c} : undef;
$self->mixin($c ? 'STD::P5::Q::c1' : 'STD::P5::Q::c0')     };
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{exec} || exists $args{x};
my $x = exists $args{exec} ? delete $args{exec} : exists $args{x} ? delete $args{x} : undef;
$self->mixin($x ? 'STD::P5::Q::x1' : 'STD::P5::Q::x0')     };
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{words} || exists $args{w};
my $w = exists $args{words} ? delete $args{words} : exists $args{w} ? delete $args{w} : undef;
$self->mixin($w ? 'STD::P5::Q::w1' : 'STD::P5::Q::w0')     };
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{quotewords} || exists $args{ww};
my $ww = exists $args{quotewords} ? delete $args{quotewords} : exists $args{ww} ? delete $args{ww} : undef;
$self->mixin($ww ? 'STD::P5::Q::ww1' : 'STD::P5::Q::ww0')     };
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{heredoc} || exists $args{to};
my $to = exists $args{heredoc} ? delete $args{heredoc} : exists $args{to} ? delete $args{to} : undef;
$self->truly($to, ':to');
$self->cursor_herelang;
};
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{regex};
my $regex = exists $args{regex} ? delete $args{regex} : undef;
return $::LANG{'Regex'}    };
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{trans};
my $trans = exists $args{trans} ? delete $args{trans} : undef;
return $::LANG{'Trans'}    };
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
my %x = %args;
my @k = keys(%x);
$self->panic("Unrecognized quote modifier: " . join('',@k));
};
}
$orig->(@_);
};

1; };
## token capterm {
sub capterm__PEEK { $_[0]->_AUTOLEXpeek('capterm', $retree) }
sub capterm {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE capterm");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'capture'} = [];
$self->_MATCHIFYr($S, "capterm", do {
my $C = $C;
if (($C) = ($C->_EXACT("\\"))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'capterm_0') {
$C->deb("Fate passed to capterm_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT capterm_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM capterm_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'capterm_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("capterm_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (($C) = ($C->_EXACT("\("))
and ($C) = ($C->_OPTr(sub {
my $C=shift;
$C->_SUBSUMEr(['capture'], sub {
my $C = shift;
$C->capture
})
}))) {
$C->_EXACT("\)")
} else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G\S/)
}))) { ($C) } else { () }
}))) {
$C->_SUBSUMEr(['termish'], sub {
my $C = shift;
$C->termish
})
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

});
}
;
## rule capture {
sub capture__PEEK { $_[0]->_AUTOLEXpeek('capture', $retree) }
sub capture {
no warnings 'recursion';
my $self = shift;

local $::INVOCANT_OK = 1;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE capture");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "capture", do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['EXPR'], sub {
my $C = shift;
$C->EXPR
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## rule param_sep { [','|':'|';'|';;'] }
sub param_sep__PEEK { $_[0]->_AUTOLEXpeek('param_sep', $retree) }
sub param_sep {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE param_sep");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "param_sep", do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'param_sep_0') {
$C->deb("Fate passed to param_sep_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT param_sep_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM param_sep_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'param_sep_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("param_sep_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_EXACT("\,")
},
sub {
my $C=shift;
$C->_EXACT("\:")
},
sub {
my $C=shift;
$C->_EXACT("\;")
},
sub {
my $C=shift;
$C->_EXACT("\;\;")
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## token signature ($lexsig = 0) {
sub signature__PEEK { $_[0]->_AUTOLEXpeek('signature', $retree) }
sub signature {
no warnings 'recursion';
my $self = shift;

my $lexsig = @_ ? shift() : 0;
local $::IN_DECL = 1;local $::zone = 'posreq';my $startpos = $self->{'_pos'};
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE signature");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'param_sep'} = [];
$C->{'parameter'} = [];
$C->{'typename'} = [];
$self->_MATCHIFYr($S, "signature", do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = ($C->_REPSEPr( sub {
my $C=shift;
$C->_SUBSUMEr(['param_sep'], sub {
my $C = shift;
$C->param_sep
})
}, sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'signature_0') {
$C->deb("Fate passed to signature_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT signature_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM signature_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'signature_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("signature_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = (do {
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'signature_1') {
$C->deb("Fate passed to signature_1: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT signature_1';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM signature_1'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'signature_1', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("signature_1 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_EXACT("\-\-\>")
},
sub {
my $C=shift;
$C->_EXACT("\)")
},
sub {
my $C=shift;
$C->_EXACT("\]")
},
sub {
my $C=shift;
$C->_EXACT("\{")
},
sub {
my $C=shift;
$C->_PATTERN(qr/\G\:\s/)
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};

})) { ($C) } else { () }
}))) { ($C) } else { () }
}))) { ($C) } else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_SUBSUMEr(['parameter'], sub {
my $C = shift;
$C->parameter
})
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->panic("Malformed parameter"))) { ($C) } else { () }

}
};
@gather;
}
}))) { ($C) } else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) { ($C) } else { () }
}))
and ($C) = ($C->ws)
and ($C) = (scalar(do {
$::IN_DECL = 0}, $C))
and ($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->_EXACT("\-\-\>"))
and ($C) = ($C->ws)) {
$C->_SUBSUMEr(['typename'], sub {
my $C = shift;
$C->typename
})
} else { () }
}))) { ($C) } else { () }
}))) {
scalar(do {
{
$::LEFTSIGIL = '@';
if ($lexsig) {
$::CURLEX->{'$?SIGNATURE'} .= '(' . substr($::ORIG, $startpos, $C->{'_pos'} - $startpos) . ')';
delete $::CURLEX->{'!NEEDSIG'};
};
}}, $C)
} else { () }

});
}
;
## token type_constraint {
sub type_constraint__PEEK { $_[0]->_AUTOLEXpeek('type_constraint', $retree) }
sub type_constraint {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE type_constraint");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "type_constraint", do {
my $C = $C;
if (($C) = ($C->_SUBSUMEr(['typename'], sub {
my $C = shift;
$C->typename
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## rule p5statement_prefix:do      {<sym> <block> }
sub p5statement_prefix__S_128do__PEEK { $_[0]->_AUTOLEXpeek('p5statement_prefix__S_128do', $retree) }
sub p5statement_prefix__S_128do {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_prefix__S_128do");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "do";
$self->_MATCHIFYr($S, "p5statement_prefix__S_128do", do {
my $C = $C;
if (($C) = ($C->_EXACT("do"))
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['block'], sub {
my $C = shift;
$C->block
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## rule p5statement_prefix:eval    {<sym> <block> }
sub p5statement_prefix__S_129eval__PEEK { $_[0]->_AUTOLEXpeek('p5statement_prefix__S_129eval', $retree) }
sub p5statement_prefix__S_129eval {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5statement_prefix__S_129eval");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "eval";
$self->_MATCHIFYr($S, "p5statement_prefix__S_129eval", do {
my $C = $C;
if (($C) = ($C->_EXACT("eval"))
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['block'], sub {
my $C = shift;
$C->block
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## token p5term:sym<undef> {
sub p5term__S_130undef__PEEK { $_[0]->_AUTOLEXpeek('p5term__S_130undef', $retree) }
sub p5term__S_130undef {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5term__S_130undef");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "undef";
$self->_MATCHIFYr($S, "p5term__S_130undef", do {
if (my ($C) = ($C->_PATTERN(qr/\Gundef\b/))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%term)
})
} else { () }

});
}
;
## token p5term:sym<continue>
sub p5term__S_131continue__PEEK { $_[0]->_AUTOLEXpeek('p5term__S_131continue', $retree) }
sub p5term__S_131continue {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5term__S_131continue");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "continue";
$self->_MATCHIFYr($S, "p5term__S_131continue", do {
if (my ($C) = ($C->_PATTERN(qr/\Gcontinue\b/))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%term)
})
} else { () }

});
}
;
## token p5circumfix:sigil
sub p5circumfix__S_132sigil__PEEK { $_[0]->_AUTOLEXpeek('p5circumfix__S_132sigil', $retree) }
sub p5circumfix__S_132sigil {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5circumfix__S_132sigil");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "sigil";
$self->_MATCHIFYr($S, "p5circumfix__S_132sigil", do {
my $C = $C;
if (($C) = ($C->_SUBSUMEr(['sigil','p5sigil'], sub {
my $C = shift;
$C->p5sigil
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\)";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\("))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['semilist'], sub {
my $C = shift;
$C->semilist
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\)")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'contextualizer', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))
and ($C) = (scalar(do {
my $M = $C;
$::LEFTSIGIL ||= $M->{'sigil'}->Str }, $C))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%term)
})
} else { () }

});
}
;
## token p5circumfix:sym<( )>
sub p5circumfix__S_133Paren_Thesis__PEEK { $_[0]->_AUTOLEXpeek('p5circumfix__S_133Paren_Thesis', $retree) }
sub p5circumfix__S_133Paren_Thesis {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5circumfix__S_133Paren_Thesis");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\(\ \)";
$self->_MATCHIFYr($S, "p5circumfix__S_133Paren_Thesis", do {
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\)";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\("))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['semilist'], sub {
my $C = shift;
$C->semilist
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\)")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'parenthesized expression', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%term)
})
} else { () }

});
}
;
## token p5circumfix:sym<[ ]>
sub p5circumfix__S_134Bra_Ket__PEEK { $_[0]->_AUTOLEXpeek('p5circumfix__S_134Bra_Ket', $retree) }
sub p5circumfix__S_134Bra_Ket {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5circumfix__S_134Bra_Ket");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\[\ \]";
$self->_MATCHIFYr($S, "p5circumfix__S_134Bra_Ket", do {
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\]";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\["))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['semilist'], sub {
my $C = shift;
$C->semilist
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\]")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'array composer', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%term)
})
} else { () }

});
}
;
## token PRE {
sub PRE__PEEK { $_[0]->_AUTOLEXpeek('PRE', $retree) }
sub PRE {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE PRE");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "PRE", do {
my $C = $C;
if (($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (my ($C) = ($C->_SUBSUMEr(['prefix','p5prefix'], sub {
my $C = shift;
$C->p5prefix
}))) {
scalar(do {
my $M = $C;
$M->{'O'} = $M->{'prefix'}->{'O'};
$M->{'sym'} = $M->{'prefix'}->{'sym'} ;
}, $C)
} else { () }
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## token infixish ($in_meta = $*IN_META) {
sub infixish__PEEK { $_[0]->_AUTOLEXpeek('infixish', $retree) }
sub infixish {
no warnings 'recursion';
my $self = shift;

my $in_meta = @_ ? shift() : $::IN_META;
local $::IN_META = $in_meta;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE infixish");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "infixish", do {
my $C = $C;
if (($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->stdstopper)) { ($C) } else { () }
}))
and ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->infixstopper)) { ($C) } else { () }
}))
and ($C) = ($C->_SUBSUMEr(['infix','p5infix'], sub {
my $C = shift;
$C->p5infix
}))) {
scalar(do {
my $M = $C;
$M->{'O'} = $M->{'infix'}->{'O'};
$M->{'sym'} = $M->{'infix'}->{'sym'};
}, $C)
} else { () }

});
}
;
## token p5dotty:sym«->» {
sub p5dotty__S_135MinusGt__PEEK { $_[0]->_AUTOLEXpeek('p5dotty__S_135MinusGt', $retree) }
sub p5dotty__S_135MinusGt {
no warnings 'recursion';
my $self = shift;

;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5dotty__S_135MinusGt");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\-\>";
$self->_MATCHIFYr($S, "p5dotty__S_135MinusGt", do {
my $C = $C;
if (($C) = ($C->_EXACT("\-\>"))
and ($C) = ($C->unspacey)
and ($C) = ($C->_SUBSUMEr(['dottyop'], sub {
my $C = shift;
$C->dottyop
}))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%methodcall)
})
} else { () }

});
}
;
## token dottyopish {
sub dottyopish__PEEK { $_[0]->_AUTOLEXpeek('dottyopish', $retree) }
sub dottyopish {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE dottyopish");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "dottyopish", $C->_SUBSUMEr(['term','dottyop'], sub {
my $C = shift;
$C->dottyop
}));
}
;
## token dottyop {
sub dottyop__PEEK { $_[0]->_AUTOLEXpeek('dottyop', $retree) }
sub dottyop {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE dottyop");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "dottyop", $C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'dottyop_0') {
$C->deb("Fate passed to dottyop_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT dottyop_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM dottyop_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'dottyop_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("dottyop_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_SUBSUMEr(['methodop'], sub {
my $C = shift;
$C->methodop
})
},
sub {
my $C=shift;
if (($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
$C->_PATTERN(qr/\G[_[:alpha:]]/)
}))
and ($C) = ($C->_SUBSUMEr(['postcircumfix','p5postcircumfix'], sub {
my $C = shift;
$C->p5postcircumfix
}))) {
scalar(do {
my $M = $C;
$M->{'O'} = $M->{'postcircumfix'}->{'O'};
$M->{'sym'} = $M->{'postcircumfix'}->{'sym'};
}, $C)
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}));
}
;
## token POST {
sub POST__PEEK { $_[0]->_AUTOLEXpeek('POST', $retree) }
sub POST {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE POST");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "POST", do {
my $C = $C;
if (($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->stdstopper)) { ($C) } else { () }
}))
and ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
(($C) x !!do {
$::MEMOS[$C->{'_pos'}]->{'ws'} })
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'POST_0') {
$C->deb("Fate passed to POST_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT POST_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM POST_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'POST_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("POST_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->_SUBSUMEr(['dotty','p5dotty'], sub {
my $C = shift;
$C->p5dotty
}))) {
scalar(do {
my $M = $C;
$M->{'O'} = $M->{'dotty'}->{'O'};
$M->{'sym'} = $M->{'dotty'}->{'sym'};
$M->{'~CAPS'} = $M->{'dotty'}->{'~CAPS'};
}, $C)
} else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->_SUBSUMEr(['postop'], sub {
my $C = shift;
$C->postop
}))) {
scalar(do {
my $M = $C;
$M->{'O'} = $M->{'postop'}->{'O'};
$M->{'sym'} = $M->{'postop'}->{'sym'};
$M->{'~CAPS'} = $M->{'postop'}->{'~CAPS'};
}, $C)
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

});
}
;
## token p5postcircumfix:sym<( )>
sub p5postcircumfix__S_136Paren_Thesis__PEEK { $_[0]->_AUTOLEXpeek('p5postcircumfix__S_136Paren_Thesis', $retree) }
sub p5postcircumfix__S_136Paren_Thesis {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5postcircumfix__S_136Paren_Thesis");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\(\ \)";
$self->_MATCHIFYr($S, "p5postcircumfix__S_136Paren_Thesis", do {
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\)";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\("))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['semiarglist'], sub {
my $C = shift;
$C->semiarglist
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\)")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'argument list', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%methodcall)
})
} else { () }

});
}
;
## token p5postcircumfix:sym<[ ]>
sub p5postcircumfix__S_137Bra_Ket__PEEK { $_[0]->_AUTOLEXpeek('p5postcircumfix__S_137Bra_Ket', $retree) }
sub p5postcircumfix__S_137Bra_Ket {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5postcircumfix__S_137Bra_Ket");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\[\ \]";
$self->_MATCHIFYr($S, "p5postcircumfix__S_137Bra_Ket", do {
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\]";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\["))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['semilist'], sub {
my $C = shift;
$C->semilist
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\]")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'subscript', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%methodcall)
})
} else { () }

});
}
;
## token p5postcircumfix:sym<{ }>
sub p5postcircumfix__S_138Cur_Ly__PEEK { $_[0]->_AUTOLEXpeek('p5postcircumfix__S_138Cur_Ly', $retree) }
sub p5postcircumfix__S_138Cur_Ly {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5postcircumfix__S_138Cur_Ly");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\{\ \}";
$self->_MATCHIFYr($S, "p5postcircumfix__S_138Cur_Ly", do {
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\}";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\{"))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['semilist'], sub {
my $C = shift;
$C->semilist
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\}")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'subscript', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%methodcall)
})
} else { () }

});
}
;
## token postop {
sub postop__PEEK { $_[0]->_AUTOLEXpeek('postop', $retree) }
sub postop {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE postop");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "postop", do {
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'postop_0') {
$C->deb("Fate passed to postop_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT postop_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM postop_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'postop_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("postop_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->_SUBSUMEr(['postfix','p5postfix'], sub {
my $C = shift;
$C->p5postfix
}))) {
scalar(do {
my $M = $C;
$M->{'O'} = $M->{'postfix'}->{'O'};
$M->{'sym'} = $M->{'postfix'}->{'sym'};
}, $C)
} else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->_SUBSUMEr(['postcircumfix','p5postcircumfix'], sub {
my $C = shift;
$C->p5postcircumfix
}))) {
scalar(do {
my $M = $C;
$M->{'O'} = $M->{'postcircumfix'}->{'O'};
$M->{'sym'} = $M->{'postcircumfix'}->{'sym'};
}, $C)
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};

});
}
;
## token methodop {
sub methodop__PEEK { $_[0]->_AUTOLEXpeek('methodop', $retree) }
sub methodop {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE methodop");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'args'} = [];
$self->_MATCHIFYr($S, "methodop", do {
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'methodop_0') {
$C->deb("Fate passed to methodop_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT methodop_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM methodop_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'methodop_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("methodop_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_SUBSUMEr(['longname'], sub {
my $C = shift;
$C->longname
})
},
sub {
my $C=shift;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = (do {
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'methodop_1') {
$C->deb("Fate passed to methodop_1: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT methodop_1';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM methodop_1'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'methodop_1', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("methodop_1 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_EXACT("\$")
},
sub {
my $C=shift;
$C->_EXACT("\@")
},
sub {
my $C=shift;
$C->_EXACT("\&")
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};

})) { ($C) } else { () }
}))) { ($C) } else { () }
}))
and ($C) = ($C->_SUBSUMEr(['variable'], sub {
my $C = shift;
$C->variable
}))) {
scalar(do {
my $M = $C;
$::VAR = $M->{'variable'} }, $C)
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G[\\(]/)
}))) {
$C->_SUBSUMEr(['args'], sub {
my $C = shift;
$C->args
})
} else { () }
}))) { ($C) } else { () }
})
} else { () }

});
}
;
## token semiarglist {
sub semiarglist__PEEK { $_[0]->_AUTOLEXpeek('semiarglist', $retree) }
sub semiarglist {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE semiarglist");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'arglist'} = [];
$self->_MATCHIFYr($S, "semiarglist", do {
my $C = $C;
if (($C) = ($C->_REPSEPr( sub {
my $C=shift;
$C->_EXACT("\;")
}, sub {
my $C=shift;
$C->_SUBSUMEr(['arglist'], sub {
my $C = shift;
$C->arglist
})
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## token arglist {
sub arglist__PEEK { $_[0]->_AUTOLEXpeek('arglist', $retree) }
sub arglist {
no warnings 'recursion';
my $self = shift;

my $inv_ok = $::INVOCANT_OK;local $::endargs = 0;local $::GOAL = 'endargs';local $::QSIGIL = '';
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE arglist");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "arglist", do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'arglist_0') {
$C->deb("Fate passed to arglist_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT arglist_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM arglist_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'arglist_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("arglist_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->stdstopper)) { ($C) } else { () }
}))) { ($C) } else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->_SUBSUMEr(['EXPR'], sub {
my $C = shift;
$C->EXPR(\%listop)
}))) {
scalar(do {
my $M = $C;
{
my $delims = $M->{'EXPR'}->{'delims'};
for (@$delims) {
if (($_->{'sym'} // '') eq ':') {
if ($inv_ok) {
$::INVOCANT_IS = $M->{'EXPR'}->{'list'}->[0]}}}
;
}}, $C)
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

});
}
;
## token p5circumfix:sym<{ }> {
sub p5circumfix__S_139Cur_Ly__PEEK { $_[0]->_AUTOLEXpeek('p5circumfix__S_139Cur_Ly', $retree) }
sub p5circumfix__S_139Cur_Ly {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5circumfix__S_139Cur_Ly");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\{\ \}";
$self->_MATCHIFYr($S, "p5circumfix__S_139Cur_Ly", do {
my $C = $C;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\{")
}))) { ($C) } else { () }
}))
and ($C) = ($C->_SUBSUMEr(['pblock'], sub {
my $C = shift;
$C->pblock
}))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%term)
})
} else { () }

});
}
;
## token p5postfix:sym['->'] ()
sub p5postfix__S_140MinusGt__PEEK { $_[0]->_AUTOLEXpeek('p5postfix__S_140MinusGt', $retree) }
sub p5postfix__S_140MinusGt {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5postfix__S_140MinusGt");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\-\>";
$self->_MATCHIFYr($S, "p5postfix__S_140MinusGt", $C->_EXACT("\-\>"));
}
;
## token p5postfix:sym<++>
sub p5postfix__S_141PlusPlus__PEEK { $_[0]->_AUTOLEXpeek('p5postfix__S_141PlusPlus', $retree) }
sub p5postfix__S_141PlusPlus {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5postfix__S_141PlusPlus");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\+\+";
$self->_MATCHIFYr($S, "p5postfix__S_141PlusPlus", do {
if (my ($C) = ($C->_EXACT("\+\+"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%autoincrement)
})
} else { () }

});
}
;
## token p5postfix:sym«--»
sub p5postfix__S_142MinusMinus__PEEK { $_[0]->_AUTOLEXpeek('p5postfix__S_142MinusMinus', $retree) }
sub p5postfix__S_142MinusMinus {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5postfix__S_142MinusMinus");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\-\-";
$self->_MATCHIFYr($S, "p5postfix__S_142MinusMinus", do {
if (my ($C) = ($C->_EXACT("\-\-"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%autoincrement)
})
} else { () }

});
}
;
## token p5prefix:sym<++>
sub p5prefix__S_143PlusPlus__PEEK { $_[0]->_AUTOLEXpeek('p5prefix__S_143PlusPlus', $retree) }
sub p5prefix__S_143PlusPlus {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5prefix__S_143PlusPlus");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\+\+";
$self->_MATCHIFYr($S, "p5prefix__S_143PlusPlus", do {
if (my ($C) = ($C->_EXACT("\+\+"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%autoincrement)
})
} else { () }

});
}
;
## token p5prefix:sym«--»
sub p5prefix__S_144MinusMinus__PEEK { $_[0]->_AUTOLEXpeek('p5prefix__S_144MinusMinus', $retree) }
sub p5prefix__S_144MinusMinus {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5prefix__S_144MinusMinus");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\-\-";
$self->_MATCHIFYr($S, "p5prefix__S_144MinusMinus", do {
if (my ($C) = ($C->_EXACT("\-\-"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%autoincrement)
})
} else { () }

});
}
;
## token p5infix:sym<**>
sub p5infix__S_145StarStar__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_145StarStar', $retree) }
sub p5infix__S_145StarStar {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_145StarStar");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\*\*";
$self->_MATCHIFYr($S, "p5infix__S_145StarStar", do {
if (my ($C) = ($C->_EXACT("\*\*"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%exponentiation)
})
} else { () }

});
}
;
## token p5prefix:sym<!>
sub p5prefix__S_146Bang__PEEK { $_[0]->_AUTOLEXpeek('p5prefix__S_146Bang', $retree) }
sub p5prefix__S_146Bang {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5prefix__S_146Bang");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\!";
$self->_MATCHIFYr($S, "p5prefix__S_146Bang", do {
if (my ($C) = ($C->_EXACT("\!"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%symbolic_unary)
})
} else { () }

});
}
;
## token p5prefix:sym<+>
sub p5prefix__S_147Plus__PEEK { $_[0]->_AUTOLEXpeek('p5prefix__S_147Plus', $retree) }
sub p5prefix__S_147Plus {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5prefix__S_147Plus");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\+";
$self->_MATCHIFYr($S, "p5prefix__S_147Plus", do {
if (my ($C) = ($C->_EXACT("\+"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%symbolic_unary)
})
} else { () }

});
}
;
## token p5prefix:sym<->
sub p5prefix__S_148Minus__PEEK { $_[0]->_AUTOLEXpeek('p5prefix__S_148Minus', $retree) }
sub p5prefix__S_148Minus {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5prefix__S_148Minus");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\-";
$self->_MATCHIFYr($S, "p5prefix__S_148Minus", do {
if (my ($C) = ($C->_EXACT("\-"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%symbolic_unary)
})
} else { () }

});
}
;
## token p5prefix:sym<~>
sub p5prefix__S_149Tilde__PEEK { $_[0]->_AUTOLEXpeek('p5prefix__S_149Tilde', $retree) }
sub p5prefix__S_149Tilde {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5prefix__S_149Tilde");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\~";
$self->_MATCHIFYr($S, "p5prefix__S_149Tilde", do {
if (my ($C) = ($C->_EXACT("\~"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%symbolic_unary)
})
} else { () }

});
}
;
## token p5infix:sym<!~>
sub p5infix__S_150BangTilde__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_150BangTilde', $retree) }
sub p5infix__S_150BangTilde {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_150BangTilde");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\!\~";
$self->_MATCHIFYr($S, "p5infix__S_150BangTilde", do {
if (my ($C) = ($C->_EXACT("\!\~"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%binding)
})
} else { () }

});
}
;
## token p5infix:sym<=~>
sub p5infix__S_151EqualTilde__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_151EqualTilde', $retree) }
sub p5infix__S_151EqualTilde {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_151EqualTilde");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\=\~";
$self->_MATCHIFYr($S, "p5infix__S_151EqualTilde", do {
if (my ($C) = ($C->_EXACT("\=\~"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%binding)
})
} else { () }

});
}
;
## token p5infix:sym<*>
sub p5infix__S_152Star__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_152Star', $retree) }
sub p5infix__S_152Star {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_152Star");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\*";
$self->_MATCHIFYr($S, "p5infix__S_152Star", do {
if (my ($C) = ($C->_EXACT("\*"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%multiplicative)
})
} else { () }

});
}
;
## token p5infix:sym</>
sub p5infix__S_153Slash__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_153Slash', $retree) }
sub p5infix__S_153Slash {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_153Slash");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\/";
$self->_MATCHIFYr($S, "p5infix__S_153Slash", do {
if (my ($C) = ($C->_EXACT("\/"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%multiplicative)
})
} else { () }

});
}
;
## token p5infix:sym<%>
sub p5infix__S_154Percent__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_154Percent', $retree) }
sub p5infix__S_154Percent {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_154Percent");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\%";
$self->_MATCHIFYr($S, "p5infix__S_154Percent", do {
if (my ($C) = ($C->_EXACT("\%"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%multiplicative)
})
} else { () }

});
}
;
## token p5infix:sym« << »
sub p5infix__S_155LtLt__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_155LtLt', $retree) }
sub p5infix__S_155LtLt {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_155LtLt");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\<\<";
$self->_MATCHIFYr($S, "p5infix__S_155LtLt", do {
if (my ($C) = ($C->_EXACT("\<\<"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%multiplicative)
})
} else { () }

});
}
;
## token p5infix:sym« >> »
sub p5infix__S_156GtGt__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_156GtGt', $retree) }
sub p5infix__S_156GtGt {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_156GtGt");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\>\>";
$self->_MATCHIFYr($S, "p5infix__S_156GtGt", do {
if (my ($C) = ($C->_EXACT("\>\>"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%multiplicative)
})
} else { () }

});
}
;
## token p5infix:sym<x>
sub p5infix__S_157x__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_157x', $retree) }
sub p5infix__S_157x {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_157x");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "x";
$self->_MATCHIFYr($S, "p5infix__S_157x", do {
if (my ($C) = ($C->_EXACT("x"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%multiplicative)
})
} else { () }

});
}
;
## token p5infix:sym<.> ()
sub p5infix__S_158Dot__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_158Dot', $retree) }
sub p5infix__S_158Dot {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_158Dot");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\.";
$self->_MATCHIFYr($S, "p5infix__S_158Dot", do {
if (my ($C) = ($C->_EXACT("\."))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%additive)
})
} else { () }

});
}
;
## token p5infix:sym<+>
sub p5infix__S_159Plus__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_159Plus', $retree) }
sub p5infix__S_159Plus {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_159Plus");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\+";
$self->_MATCHIFYr($S, "p5infix__S_159Plus", do {
if (my ($C) = ($C->_EXACT("\+"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%additive)
})
} else { () }

});
}
;
## token p5infix:sym<->
sub p5infix__S_160Minus__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_160Minus', $retree) }
sub p5infix__S_160Minus {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_160Minus");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\-";
$self->_MATCHIFYr($S, "p5infix__S_160Minus", do {
if (my ($C) = ($C->_EXACT("\-"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%additive)
})
} else { () }

});
}
;
## token p5infix:sym<&>
sub p5infix__S_161Amp__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_161Amp', $retree) }
sub p5infix__S_161Amp {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_161Amp");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\&";
$self->_MATCHIFYr($S, "p5infix__S_161Amp", do {
if (my ($C) = ($C->_EXACT("\&"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%bitwise_and)
})
} else { () }

});
}
;
## token p5infix:sym<also>
sub p5infix__S_162also__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_162also', $retree) }
sub p5infix__S_162also {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_162also");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "also";
$self->_MATCHIFYr($S, "p5infix__S_162also", do {
if (my ($C) = ($C->_EXACT("also"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%bitwise_and)
})
} else { () }

});
}
;
## token p5infix:sym<|>
sub p5infix__S_163Vert__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_163Vert', $retree) }
sub p5infix__S_163Vert {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_163Vert");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\|";
$self->_MATCHIFYr($S, "p5infix__S_163Vert", do {
if (my ($C) = ($C->_EXACT("\|"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%bitwise_or)
})
} else { () }

});
}
;
## token p5infix:sym<^>
sub p5infix__S_164Caret__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_164Caret', $retree) }
sub p5infix__S_164Caret {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_164Caret");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\^";
$self->_MATCHIFYr($S, "p5infix__S_164Caret", do {
if (my ($C) = ($C->_EXACT("\^"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%bitwise_or)
})
} else { () }

});
}
;
## token p5prefix:sleep
sub p5prefix__S_165sleep__PEEK { $_[0]->_AUTOLEXpeek('p5prefix__S_165sleep', $retree) }
sub p5prefix__S_165sleep {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5prefix__S_165sleep");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "sleep";
$self->_MATCHIFYr($S, "p5prefix__S_165sleep", do {
my $C = $C;
if (($C) = ($C->_PATTERN(qr/\Gsleep\b/))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G\s*+/)
}))) { ($C) } else { () }
}))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%named_unary)
})
} else { () }

});
}
;
## token p5prefix:abs
sub p5prefix__S_166abs__PEEK { $_[0]->_AUTOLEXpeek('p5prefix__S_166abs', $retree) }
sub p5prefix__S_166abs {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5prefix__S_166abs");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "abs";
$self->_MATCHIFYr($S, "p5prefix__S_166abs", do {
my $C = $C;
if (($C) = ($C->_PATTERN(qr/\Gabs\b/))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G\s*+/)
}))) { ($C) } else { () }
}))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%named_unary)
})
} else { () }

});
}
;
## token p5prefix:let
sub p5prefix__S_167let__PEEK { $_[0]->_AUTOLEXpeek('p5prefix__S_167let', $retree) }
sub p5prefix__S_167let {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5prefix__S_167let");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "let";
$self->_MATCHIFYr($S, "p5prefix__S_167let", do {
my $C = $C;
if (($C) = ($C->_PATTERN(qr/\Glet\b/))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G\s*+/)
}))) { ($C) } else { () }
}))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%named_unary)
})
} else { () }

});
}
;
## token p5prefix:temp
sub p5prefix__S_168temp__PEEK { $_[0]->_AUTOLEXpeek('p5prefix__S_168temp', $retree) }
sub p5prefix__S_168temp {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5prefix__S_168temp");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "temp";
$self->_MATCHIFYr($S, "p5prefix__S_168temp", do {
my $C = $C;
if (($C) = ($C->_PATTERN(qr/\Gtemp\b/))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G\s*+/)
}))) { ($C) } else { () }
}))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%named_unary)
})
} else { () }

});
}
;
## token p5infix:sym« <=> »
sub p5infix__S_169LtEqualGt__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_169LtEqualGt', $retree) }
sub p5infix__S_169LtEqualGt {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_169LtEqualGt");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\<\=\>";
$self->_MATCHIFYr($S, "p5infix__S_169LtEqualGt", do {
my $C = $C;
if (($C) = ($C->_EXACT("\<\=\>"))
and ($C) = ($C->before(sub {
my $C=shift;
(($C) x !!do {
my $M = $C;
$M->{'O'}->{'returns'} = "Order"})
}))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%comparison)
})
} else { () }

});
}
;
## token p5infix:cmp
sub p5infix__S_170cmp__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_170cmp', $retree) }
sub p5infix__S_170cmp {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_170cmp");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "cmp";
$self->_MATCHIFYr($S, "p5infix__S_170cmp", do {
my $C = $C;
if (($C) = ($C->_EXACT("cmp"))
and ($C) = ($C->before(sub {
my $C=shift;
(($C) x !!do {
my $M = $C;
$M->{'O'}->{'returns'} = "Order"})
}))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%comparison)
})
} else { () }

});
}
;
## token p5infix:sym« < »
sub p5infix__S_171Lt__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_171Lt', $retree) }
sub p5infix__S_171Lt {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_171Lt");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\<";
$self->_MATCHIFYr($S, "p5infix__S_171Lt", do {
if (my ($C) = ($C->_EXACT("\<"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%comparison)
})
} else { () }

});
}
;
## token p5infix:sym« <= »
sub p5infix__S_172LtEqual__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_172LtEqual', $retree) }
sub p5infix__S_172LtEqual {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_172LtEqual");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\<\=";
$self->_MATCHIFYr($S, "p5infix__S_172LtEqual", do {
if (my ($C) = ($C->_EXACT("\<\="))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%comparison)
})
} else { () }

});
}
;
## token p5infix:sym« > »
sub p5infix__S_173Gt__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_173Gt', $retree) }
sub p5infix__S_173Gt {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_173Gt");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\>";
$self->_MATCHIFYr($S, "p5infix__S_173Gt", do {
if (my ($C) = ($C->_EXACT("\>"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%comparison)
})
} else { () }

});
}
;
## token p5infix:sym« >= »
sub p5infix__S_174GtEqual__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_174GtEqual', $retree) }
sub p5infix__S_174GtEqual {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_174GtEqual");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\>\=";
$self->_MATCHIFYr($S, "p5infix__S_174GtEqual", do {
if (my ($C) = ($C->_EXACT("\>\="))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%comparison)
})
} else { () }

});
}
;
## token p5infix:sym<eq>
sub p5infix__S_175eq__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_175eq', $retree) }
sub p5infix__S_175eq {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_175eq");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "eq";
$self->_MATCHIFYr($S, "p5infix__S_175eq", do {
if (my ($C) = ($C->_EXACT("eq"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%equality)
})
} else { () }

});
}
;
## token p5infix:sym<ne>
sub p5infix__S_176ne__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_176ne', $retree) }
sub p5infix__S_176ne {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_176ne");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "ne";
$self->_MATCHIFYr($S, "p5infix__S_176ne", do {
if (my ($C) = ($C->_EXACT("ne"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%equality)
})
} else { () }

});
}
;
## token p5infix:sym<lt>
sub p5infix__S_177lt__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_177lt', $retree) }
sub p5infix__S_177lt {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_177lt");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "lt";
$self->_MATCHIFYr($S, "p5infix__S_177lt", do {
if (my ($C) = ($C->_EXACT("lt"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%comparison)
})
} else { () }

});
}
;
## token p5infix:sym<le>
sub p5infix__S_178le__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_178le', $retree) }
sub p5infix__S_178le {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_178le");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "le";
$self->_MATCHIFYr($S, "p5infix__S_178le", do {
if (my ($C) = ($C->_EXACT("le"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%comparison)
})
} else { () }

});
}
;
## token p5infix:sym<gt>
sub p5infix__S_179gt__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_179gt', $retree) }
sub p5infix__S_179gt {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_179gt");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "gt";
$self->_MATCHIFYr($S, "p5infix__S_179gt", do {
if (my ($C) = ($C->_EXACT("gt"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%comparison)
})
} else { () }

});
}
;
## token p5infix:sym<ge>
sub p5infix__S_180ge__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_180ge', $retree) }
sub p5infix__S_180ge {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_180ge");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "ge";
$self->_MATCHIFYr($S, "p5infix__S_180ge", do {
if (my ($C) = ($C->_EXACT("ge"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%comparison)
})
} else { () }

});
}
;
## token p5infix:sym<==>
sub p5infix__S_181EqualEqual__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_181EqualEqual', $retree) }
sub p5infix__S_181EqualEqual {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_181EqualEqual");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\=\=";
$self->_MATCHIFYr($S, "p5infix__S_181EqualEqual", do {
my $C = $C;
if (($C) = ($C->_EXACT("\=\="))
and ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\=")
}))) { ($C) } else { () }
}))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%equality)
})
} else { () }

});
}
;
## token p5infix:sym<!=>
sub p5infix__S_182BangEqual__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_182BangEqual', $retree) }
sub p5infix__S_182BangEqual {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_182BangEqual");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\!\=";
$self->_MATCHIFYr($S, "p5infix__S_182BangEqual", do {
my $C = $C;
if (($C) = ($C->_EXACT("\!\="))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G\s/)
}))) { ($C) } else { () }
}))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%equality)
})
} else { () }

});
}
;
## token p5infix:sym<&&>
sub p5infix__S_183AmpAmp__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_183AmpAmp', $retree) }
sub p5infix__S_183AmpAmp {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_183AmpAmp");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\&\&";
$self->_MATCHIFYr($S, "p5infix__S_183AmpAmp", do {
if (my ($C) = ($C->_EXACT("\&\&"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%tight_and)
})
} else { () }

});
}
;
## token p5infix:sym<||>
sub p5infix__S_184VertVert__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_184VertVert', $retree) }
sub p5infix__S_184VertVert {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_184VertVert");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\|\|";
$self->_MATCHIFYr($S, "p5infix__S_184VertVert", do {
if (my ($C) = ($C->_EXACT("\|\|"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%tight_or)
})
} else { () }

});
}
;
## token p5infix:sym<^^>
sub p5infix__S_185CaretCaret__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_185CaretCaret', $retree) }
sub p5infix__S_185CaretCaret {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_185CaretCaret");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\^\^";
$self->_MATCHIFYr($S, "p5infix__S_185CaretCaret", do {
if (my ($C) = ($C->_EXACT("\^\^"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%tight_or)
})
} else { () }

});
}
;
## token p5infix:sym<//>
sub p5infix__S_186SlashSlash__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_186SlashSlash', $retree) }
sub p5infix__S_186SlashSlash {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_186SlashSlash");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\/\/";
$self->_MATCHIFYr($S, "p5infix__S_186SlashSlash", do {
if (my ($C) = ($C->_EXACT("\/\/"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%tight_or)
})
} else { () }

});
}
;
## token p5infix:sym<..>
sub p5infix__S_187DotDot__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_187DotDot', $retree) }
sub p5infix__S_187DotDot {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_187DotDot");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\.\.";
$self->_MATCHIFYr($S, "p5infix__S_187DotDot", do {
if (my ($C) = ($C->_EXACT("\.\."))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%range)
})
} else { () }

});
}
;
## token p5infix:sym<...>
sub p5infix__S_188DotDotDot__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_188DotDotDot', $retree) }
sub p5infix__S_188DotDotDot {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_188DotDotDot");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\.\.\.";
$self->_MATCHIFYr($S, "p5infix__S_188DotDotDot", do {
if (my ($C) = ($C->_EXACT("\.\.\."))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%range)
})
} else { () }

});
}
;
## token p5infix:sym<? :> {
sub p5infix__S_189Question_Colon__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_189Question_Colon', $retree) }
sub p5infix__S_189Question_Colon {
no warnings 'recursion';
my $self = shift;

local $::GOAL = ':';
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_189Question_Colon");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\?\ \:";
$self->_MATCHIFYr($S, "p5infix__S_189Question_Colon", do {
my $C = $C;
if (($C) = ($C->_EXACT("\?"))
and ($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['EXPR'], sub {
my $C = shift;
$C->EXPR(\%assignment)
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\:")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\=")
}))) { ($C) } else { () }
}))
and ($C) = ($C->panic("Assignment not allowed within ?:"))) {
$C
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\!\!")
}))) { ($C) } else { () }
}))
and ($C) = ($C->panic("Please use : rather than !!"))) {
$C
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_SUBSUMEr(['infixish'], sub {
my $C = shift;
$C->infixish
})
}))) { ($C) } else { () }
}))
and ($C) = ($C->panic("Precedence too loose within ?:; use ?(): instead "))) {
$C
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->panic("Found ? but no :; possible precedence problem"))) { ($C) } else { () }

}
};
@gather;
}
}))) { ($C) } else { () }

}
};
@gather;
}
}))
and ($C) = (scalar(do {
my $M = $C;
$M->{'O'}->{'_reducecheck'} = 'raise_middle'}, $C))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%conditional)
})
} else { () }

});
}
;
## method raise_middle
sub raise_middle {
no warnings 'recursion';
my $self = shift;
$self->{'middle'} = $self->{'infix'}->{'EXPR'};
$self;
};
## token p5infix:sym<=> ()
sub p5infix__S_190Equal__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_190Equal', $retree) }
sub p5infix__S_190Equal {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_190Equal");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\=";
$self->_MATCHIFYr($S, "p5infix__S_190Equal", do {
if (my ($C) = ($C->_EXACT("\="))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%assignment)
})
} else { () }

});
}
;
## token p5infix:sym<,>
sub p5infix__S_191Comma__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_191Comma', $retree) }
sub p5infix__S_191Comma {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_191Comma");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\,";
$self->_MATCHIFYr($S, "p5infix__S_191Comma", do {
my $C = $C;
if (($C) = ($C->_EXACT("\,"))
and ($C) = (scalar(do {
my $M = $C;
$M->{'O'}->{'fiddly'} = 0}, $C))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%comma)
})
} else { () }

});
}
;
## token p5infix:sym« => »
sub p5infix__S_192EqualGt__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_192EqualGt', $retree) }
sub p5infix__S_192EqualGt {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_192EqualGt");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\=\>";
$self->_MATCHIFYr($S, "p5infix__S_192EqualGt", do {
my $C = $C;
if (($C) = ($C->_EXACT("\=\>"))
and ($C) = (scalar(do {
my $M = $C;
$M->{'O'}->{'fiddly'} = 0}, $C))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%comma)
})
} else { () }

});
}
;
## token p5term:identifier
sub p5term__S_193identifier__PEEK { $_[0]->_AUTOLEXpeek('p5term__S_193identifier', $retree) }
sub p5term__S_193identifier {
no warnings 'recursion';
my $self = shift;

my $name;my $pos;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5term__S_193identifier");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "identifier";
$self->_MATCHIFYr($S, "p5term__S_193identifier", do {
my $C = $C;
if (($C) = ($C->_SUBSUMEr(['identifier'], sub {
my $C = shift;
$C->identifier
}))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->{'unsp'} = [];
$C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'p5term__S_193identifier_0') {
$C->deb("Fate passed to p5term__S_193identifier_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5term__S_193identifier_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM p5term__S_193identifier_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5term__S_193identifier_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("p5term__S_193identifier_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_SUBSUMEr(['unsp'], sub {
my $C = shift;
$C->unsp
})
},
sub {
my $C=shift;
$C->_EXACT("\(")
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) { ($C) } else { () }
})
}))) { ($C) } else { () }
}))
and ($C) = (scalar(do {
my $M = $C;
$name = $M->{'identifier'}->Str;
$pos = $C->{'_pos'};
}, $C))
and ($C) = ($C->_SUBSUMEr(['args'], sub {
my $C = shift;
$C->args( $C->is_name($name) )
}))
and ($C) = (scalar(do {
my $M = $C;
$self->add_mystery($name,$pos,substr($::ORIG,$pos,1)) unless $M->{'args'}->{'invocant'}}, $C))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%term)
})
} else { () }

});
}
;
## token p5term:opfunc
sub p5term__S_194opfunc__PEEK { $_[0]->_AUTOLEXpeek('p5term__S_194opfunc', $retree) }
sub p5term__S_194opfunc {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5term__S_194opfunc");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'colonpair'} = [];
$C->{sym} = "opfunc";
$self->_MATCHIFYr($S, "p5term__S_194opfunc", do {
my $C = $C;
if (($C) = ($C->_SUBSUMEr(['category'], sub {
my $C = shift;
$C->category
}))
and ($C) = ($C->_PLUSr(sub {
my $C=shift;
$C->_SUBSUMEr(['colonpair'], sub {
my $C = shift;
$C->colonpair
})
}))
and ($C) = ($C->_SUBSUMEr(['args'], sub {
my $C = shift;
$C->args
}))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%term)
})
} else { () }

});
}
;
## token args ($istype = 0) {
sub args__PEEK { $_[0]->_AUTOLEXpeek('args', $retree) }
sub args {
no warnings 'recursion';
my $self = shift;

my $istype = @_ ? shift() : 0;
my $listopish = 0;local $::GOAL = '';local $::INVOCANT_OK = 1;local $::INVOCANT_IS;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE args");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'arglist'} = [];
$self->_MATCHIFYr($S, "args", do {
my $C = $C;
if (($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'args_0') {
$C->deb("Fate passed to args_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT args_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM args_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'args_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("args_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\)";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\("))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['semiarglist'], sub {
my $C = shift;
$C->semiarglist
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\)")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'argument list', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) { ($C) } else { () }
},
sub {
my $C=shift;
if (($C) = ($C->unsp)
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\)";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\("))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['semiarglist'], sub {
my $C = shift;
$C->semiarglist
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\)")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'argument list', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) {
$C
} else { () }
},
sub {
my $C=shift;
if (my ($C) = (scalar(do {
$listopish = 1 }, $C))) {
$C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G\s/)
}))) { ($C) } else { () }
}))
and ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
(($C) x !!do {
$istype })
}))
and ($C) = ($C->ws)
and ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->infixstopper)) { ($C) } else { () }
}))) {
$C->_SUBSUMEr(['arglist'], sub {
my $C = shift;
$C->arglist
})
} else { () }
}))) { ($C) } else { () }
})
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))
and ($C) = (scalar(do {
my $M = $C;
$M->{'invocant'} = $::INVOCANT_IS}, $C))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
if (my ($C) = ($C->before(sub {
my $C=shift;
(($C) x !!do {
$listopish })
}))) { ($C) } else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->_EXACT("\:"))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_PATTERN(qr/\G\s/)
}))) { ($C) } else { () }
}))) {
$C->_SUBSUMEr(['moreargs','arglist'], sub {
my $C = shift;
$C->arglist
})
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, scalar(do {
my $M = $C;
{
$M->{'O'} = {
}}}, $C)
};
@gather;
}
}))) {
$C
} else { () }

});
}
;
## token p5term:name
sub p5term__S_195name__PEEK { $_[0]->_AUTOLEXpeek('p5term__S_195name', $retree) }
sub p5term__S_195name {
no warnings 'recursion';
my $self = shift;

my $name;my $pos;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5term__S_195name");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'p5postcircumfix'} = [];
$C->{'postcircumfix'} = [];
$C->{sym} = "name";
$self->_MATCHIFYr($S, "p5term__S_195name", do {
my $C = $C;
if (($C) = ($C->_SUBSUMEr(['longname'], sub {
my $C = shift;
$C->longname
}))
and ($C) = (scalar(do {
my $M = $C;
$name = $M->{'longname'}->Str;
$pos = $C->{'_pos'};
}, $C))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
my $C = $C;
if (($C) = ($C->before(sub {
my $C=shift;
(($C) x !!do {
my $M = $C;
$C->is_name($M->{'longname'}->Str) or substr($M->{'longname'}->Str,0,2) eq '::'
})
}))
and ($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->unsp)) { ($C) } else { () }
}))
and ($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\[")
}))) { ($C) } else { () }
}))) {
$C->_SUBSUMEr(['postcircumfix','p5postcircumfix'], sub {
my $C = shift;
$C->p5postcircumfix
})
} else { () }
}))) { ($C) } else { () }
}))) {
$C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->_EXACT("\:\:"))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'p5term__S_195name_0') {
$C->deb("Fate passed to p5term__S_195name_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5term__S_195name_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM p5term__S_195name_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'p5term__S_195name_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("p5term__S_195name_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_EXACT("«")
},
sub {
my $C=shift;
$C->_EXACT("\<")
},
sub {
my $C=shift;
$C->_EXACT("\{")
},
sub {
my $C=shift;
$C->_EXACT("\<\<")
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) { ($C) } else { () }
}))) { ($C) } else { () }
}))) {
$C->_SUBSUMEr(['postcircumfix','p5postcircumfix'], sub {
my $C = shift;
$C->p5postcircumfix
})
} else { () }
}))) { ($C) } else { () }
})
} else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->_SUBSUMEr(['args'], sub {
my $C = shift;
$C->args
}))) {
scalar(do {
my $M = $C;
$self->add_mystery($name,$pos,'termish') unless $M->{'args'}->{'invocant'}}, $C)
} else { () }

}
};
@gather;
}
}))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%term)
})
} else { () }

});
}
;
## token p5infix:sym<and>
sub p5infix__S_196and__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_196and', $retree) }
sub p5infix__S_196and {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_196and");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "and";
$self->_MATCHIFYr($S, "p5infix__S_196and", do {
if (my ($C) = ($C->_EXACT("and"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%loose_and)
})
} else { () }

});
}
;
## token p5infix:sym<andthen>
sub p5infix__S_197andthen__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_197andthen', $retree) }
sub p5infix__S_197andthen {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_197andthen");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "andthen";
$self->_MATCHIFYr($S, "p5infix__S_197andthen", do {
if (my ($C) = ($C->_EXACT("andthen"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%loose_and)
})
} else { () }

});
}
;
## token p5infix:sym<or>
sub p5infix__S_198or__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_198or', $retree) }
sub p5infix__S_198or {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_198or");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "or";
$self->_MATCHIFYr($S, "p5infix__S_198or", do {
if (my ($C) = ($C->_EXACT("or"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%loose_or)
})
} else { () }

});
}
;
## token p5infix:sym<orelse>
sub p5infix__S_199orelse__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_199orelse', $retree) }
sub p5infix__S_199orelse {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_199orelse");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "orelse";
$self->_MATCHIFYr($S, "p5infix__S_199orelse", do {
if (my ($C) = ($C->_EXACT("orelse"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%loose_or)
})
} else { () }

});
}
;
## token p5infix:sym<xor>
sub p5infix__S_200xor__PEEK { $_[0]->_AUTOLEXpeek('p5infix__S_200xor', $retree) }
sub p5infix__S_200xor {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5infix__S_200xor");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "xor";
$self->_MATCHIFYr($S, "p5infix__S_200xor", do {
if (my ($C) = ($C->_EXACT("xor"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%loose_or)
})
} else { () }

});
}
;
## token p5terminator:sym<;>
sub p5terminator__S_201Semi__PEEK { $_[0]->_AUTOLEXpeek('p5terminator__S_201Semi', $retree) }
sub p5terminator__S_201Semi {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5terminator__S_201Semi");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\;";
$self->_MATCHIFYr($S, "p5terminator__S_201Semi", do {
if (my ($C) = ($C->_EXACT("\;"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%terminator)
})
} else { () }

});
}
;
## token p5terminator:sym<if>
sub p5terminator__S_202if__PEEK { $_[0]->_AUTOLEXpeek('p5terminator__S_202if', $retree) }
sub p5terminator__S_202if {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5terminator__S_202if");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "if";
$self->_MATCHIFYr($S, "p5terminator__S_202if", do {
my $C = $C;
if (($C) = ($C->_PATTERN(qr/\Gif\b/))
and ($C) = ($C->nofun)) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%terminator)
})
} else { () }

});
}
;
## token p5terminator:sym<unless>
sub p5terminator__S_203unless__PEEK { $_[0]->_AUTOLEXpeek('p5terminator__S_203unless', $retree) }
sub p5terminator__S_203unless {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5terminator__S_203unless");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "unless";
$self->_MATCHIFYr($S, "p5terminator__S_203unless", do {
my $C = $C;
if (($C) = ($C->_PATTERN(qr/\Gunless\b/))
and ($C) = ($C->nofun)) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%terminator)
})
} else { () }

});
}
;
## token p5terminator:sym<while>
sub p5terminator__S_204while__PEEK { $_[0]->_AUTOLEXpeek('p5terminator__S_204while', $retree) }
sub p5terminator__S_204while {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5terminator__S_204while");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "while";
$self->_MATCHIFYr($S, "p5terminator__S_204while", do {
my $C = $C;
if (($C) = ($C->_PATTERN(qr/\Gwhile\b/))
and ($C) = ($C->nofun)) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%terminator)
})
} else { () }

});
}
;
## token p5terminator:sym<until>
sub p5terminator__S_205until__PEEK { $_[0]->_AUTOLEXpeek('p5terminator__S_205until', $retree) }
sub p5terminator__S_205until {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5terminator__S_205until");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "until";
$self->_MATCHIFYr($S, "p5terminator__S_205until", do {
my $C = $C;
if (($C) = ($C->_PATTERN(qr/\Guntil\b/))
and ($C) = ($C->nofun)) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%terminator)
})
} else { () }

});
}
;
## token p5terminator:sym<for>
sub p5terminator__S_206for__PEEK { $_[0]->_AUTOLEXpeek('p5terminator__S_206for', $retree) }
sub p5terminator__S_206for {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5terminator__S_206for");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "for";
$self->_MATCHIFYr($S, "p5terminator__S_206for", do {
my $C = $C;
if (($C) = ($C->_PATTERN(qr/\Gfor\b/))
and ($C) = ($C->nofun)) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%terminator)
})
} else { () }

});
}
;
## token p5terminator:sym<given>
sub p5terminator__S_207given__PEEK { $_[0]->_AUTOLEXpeek('p5terminator__S_207given', $retree) }
sub p5terminator__S_207given {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5terminator__S_207given");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "given";
$self->_MATCHIFYr($S, "p5terminator__S_207given", do {
my $C = $C;
if (($C) = ($C->_PATTERN(qr/\Ggiven\b/))
and ($C) = ($C->nofun)) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%terminator)
})
} else { () }

});
}
;
## token p5terminator:sym<when>
sub p5terminator__S_208when__PEEK { $_[0]->_AUTOLEXpeek('p5terminator__S_208when', $retree) }
sub p5terminator__S_208when {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5terminator__S_208when");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "when";
$self->_MATCHIFYr($S, "p5terminator__S_208when", do {
my $C = $C;
if (($C) = ($C->_PATTERN(qr/\Gwhen\b/))
and ($C) = ($C->nofun)) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%terminator)
})
} else { () }

});
}
;
## token p5terminator:sym<)>
sub p5terminator__S_209Thesis__PEEK { $_[0]->_AUTOLEXpeek('p5terminator__S_209Thesis', $retree) }
sub p5terminator__S_209Thesis {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5terminator__S_209Thesis");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\)";
$self->_MATCHIFYr($S, "p5terminator__S_209Thesis", do {
if (my ($C) = ($C->_EXACT("\)"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%terminator)
})
} else { () }

});
}
;
## token p5terminator:sym<]>
sub p5terminator__S_210Ket__PEEK { $_[0]->_AUTOLEXpeek('p5terminator__S_210Ket', $retree) }
sub p5terminator__S_210Ket {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5terminator__S_210Ket");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\]";
$self->_MATCHIFYr($S, "p5terminator__S_210Ket", do {
if (my ($C) = ($C->_EXACT("\]"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%terminator)
})
} else { () }

});
}
;
## token p5terminator:sym<}>
sub p5terminator__S_211Ly__PEEK { $_[0]->_AUTOLEXpeek('p5terminator__S_211Ly', $retree) }
sub p5terminator__S_211Ly {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5terminator__S_211Ly");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\}";
$self->_MATCHIFYr($S, "p5terminator__S_211Ly", do {
if (my ($C) = ($C->_EXACT("\}"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%terminator)
})
} else { () }

});
}
;
## token p5terminator:sym<:>
sub p5terminator__S_212Colon__PEEK { $_[0]->_AUTOLEXpeek('p5terminator__S_212Colon', $retree) }
sub p5terminator__S_212Colon {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5terminator__S_212Colon");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\:";
$self->_MATCHIFYr($S, "p5terminator__S_212Colon", do {
my $C = $C;
if (($C) = ($C->_EXACT("\:"))
and ($C) = ($C->before(sub {
my $C=shift;
(($C) x !!do {
$::GOAL eq ':' })
}))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%terminator)
})
} else { () }

});
}
;
## regex infixstopper {
sub infixstopper__PEEK { $_[0]->_AUTOLEXpeek('infixstopper', $retree) }
sub infixstopper {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE infixstopper");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFY($S, "infixstopper", $C->_BRACKET(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'infixstopper_0') {
$C->deb("Fate passed to infixstopper_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT infixstopper_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM infixstopper_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'infixstopper_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("infixstopper_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->before(sub {
my $C=shift;
$C->_SUBSUME(['stopper'], sub {
my $C = shift;
$C->stopper
})
})
},
sub {
my $C=shift;
STD::LazyMap::lazymap(sub {
my $C=shift;
$C->before(sub {
my $C=shift;
(($C) x !!do {
$::GOAL eq ':' })
})
},
$C->before(sub {
my $C=shift;
$C->_EXACT("\:")
}))
},
sub {
my $C=shift;
$C->before(sub {
my $C=shift;
(($C) x !!do {
$::GOAL eq 'endargs' and $::MEMOS[$C->{'_pos'}]->{'endargs'} })
})
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}));
}
;
## token stopper { <!> }
sub stopper__PEEK { $_[0]->_AUTOLEXpeek('stopper', $retree) }
sub stopper {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE stopper");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "stopper", $C->_NOTBEFORE(sub {
my $C=shift;
$C
}));
}
;
## regex stdstopper {
sub stdstopper__PEEK { $_[0]->_AUTOLEXpeek('stdstopper', $retree) }
sub stdstopper {
no warnings 'recursion';
my $self = shift;

local @::STUB = @::STUB = return $self if exists $::MEMOS[$self->{'_pos'}]->{'endstmt'};
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE stdstopper");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFY($S, "stdstopper", STD::LazyMap::lazymap(sub {
my $C=shift;
scalar(do {
$::MEMOS[$C->{'_pos'}]->{'endstmt'} ||= 1}, $C)
},
$C->_BRACKET(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'stdstopper_0') {
$C->deb("Fate passed to stdstopper_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT stdstopper_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM stdstopper_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::STD::P5', 'stdstopper_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("stdstopper_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->before(sub {
my $C=shift;
$C->terminator
})
},
sub {
my $C=shift;
$C->before(sub {
my $C=shift;
$C->unitstopper
})
},
sub {
my $C=shift;
$C->_PATTERN(qr/\G\z/)
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
})));
}
;
{ package STD::P5::Regex;
use Moose ':all' => { -prefix => "moose_" };
use Encode;
moose_extends('STD');
our $ALLROLES = { 'STD::P5::Regex', 1 };
our $REGEXES = {
ALL => [ qw/atom category codeblock infixish infixstopper nibbler p5assertion p5backslash p5metachar p5mod p5mod_internal p5mods p5quantifier p5regex_infix quant_atom_list quantified_atom quantmod rx termish ws/ ],
category => [ qw/category__S_000p5metachar__PEEK category__S_001p5backslash__PEEK category__S_002p5assertion__PEEK category__S_003p5quantifier__PEEK category__S_004p5mod_internal__PEEK/ ],
p5assertion => [ qw/p5assertion__S_040Question__PEEK p5assertion__S_041Cur_Ly__PEEK p5assertion__S_042Lt__PEEK p5assertion__S_043Equal__PEEK p5assertion__S_044Bang__PEEK p5assertion__S_045Gt__PEEK p5assertion__S_046mod__PEEK p5assertion__S_047bogus__PEEK/ ],
p5backslash => [ qw/p5backslash__S_017A__PEEK p5backslash__S_018a__PEEK p5backslash__S_019b__PEEK p5backslash__S_020c__PEEK p5backslash__S_021d__PEEK p5backslash__S_022e__PEEK p5backslash__S_023f__PEEK p5backslash__S_024h__PEEK p5backslash__S_025l__PEEK p5backslash__S_026n__PEEK p5backslash__S_027o__PEEK p5backslash__S_028p__PEEK p5backslash__S_029Q__PEEK p5backslash__S_030r__PEEK p5backslash__S_031s__PEEK p5backslash__S_032t__PEEK p5backslash__S_033u__PEEK p5backslash__S_034v__PEEK p5backslash__S_035w__PEEK p5backslash__S_036x__PEEK p5backslash__S_037z__PEEK p5backslash__S_038misc__PEEK p5backslash__S_039oops__PEEK/ ],
p5metachar => [ qw/p5metachar__S_006Vert__PEEK p5metachar__S_007Thesis__PEEK p5metachar__S_008quant__PEEK p5metachar__S_009Bra_Ket__PEEK p5metachar__S_010ParenQuestion_Thesis__PEEK p5metachar__S_011Paren_Thesis__PEEK p5metachar__S_012Back__PEEK p5metachar__S_013Dot__PEEK p5metachar__S_014Caret__PEEK p5metachar__S_015Dollar__PEEK p5metachar__S_016var__PEEK/ ],
p5quantifier => [ qw/p5quantifier__S_048Star__PEEK p5quantifier__S_049Plus__PEEK p5quantifier__S_050Question__PEEK p5quantifier__S_051Cur_Ly__PEEK/ ],
p5regex_infix => [ qw/p5regex_infix__S_005Vert__PEEK/ ],
};


no warnings 'qw', 'recursion';
my $retree;

$DB::deep = $DB::deep = 1000; # suppress used-once warning

use YAML::XS;

$SIG{__WARN__} = sub { die @_,"   statement started at line ", 'STD::Cursor'->lineof($::LASTSTATE), "
" } if $::DEBUG;

$retree = YAML::XS::Load(Encode::encode_utf8(<<'RETREE_END'));
---
atom: !!perl/hash:RE_ast
  dba: atom
  dic: STD::P5::Regex
  re: !!perl/hash:RE_bracket
    re: &1 !!perl/hash:RE_any
      altname: atom_0
      dba: atom
      dic: STD::P5::Regex
      zyg:
      - !!perl/hash:RE_meta
        alt: atom_0 0
        min: 1
        text: \w
      - !!perl/hash:RE_bindnamed
        alt: atom_0 1
        atom: !!perl/hash:RE_method
          name: p5metachar
          rest: ''
      - !!perl/hash:RE_sequence
        alt: atom_0 2
        zyg:
        - !!perl/hash:RE_string
          i: 0
          text: \
        - !!perl/hash:RE_meta
          text: '::'
        - !!perl/hash:RE_meta
          min: 1
          text: .
atom_0: *1
category__S_000p5metachar: !!perl/hash:RE_ast
  dba: category
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5metachar
category__S_001p5backslash: !!perl/hash:RE_ast
  dba: category
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5backslash
category__S_002p5assertion: !!perl/hash:RE_ast
  dba: category
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5assertion
category__S_003p5quantifier: !!perl/hash:RE_ast
  dba: category
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5quantifier
category__S_004p5mod_internal: !!perl/hash:RE_ast
  dba: category
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: p5mod_internal
codeblock: !!perl/hash:RE_ast
  dba: codeblock
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: '{'
    - !!perl/hash:RE_meta
      text: '::'
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_sequence
        zyg:
        - !!perl/hash:RE_decl {}
        - !!perl/hash:RE_method
          name: statementlist
          rest: ''
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_first
        zyg:
        - !!perl/hash:RE_string
          i: 0
          text: '}'
        - !!perl/hash:RE_method
          name: panic
          rest: 1
infixish: !!perl/hash:RE_ast
  dba: infixish
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_assertion
      assert: '!'
      re: !!perl/hash:RE_method
        name: infixstopper
        rest: ''
    - !!perl/hash:RE_assertion
      assert: '!'
      re: !!perl/hash:RE_method
        name: stdstopper
        rest: ''
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: p5regex_infix
        rest: ''
    - !!perl/hash:RE_block {}
infixstopper: !!perl/hash:RE_ast
  dba: infix stopper
  dic: STD::P5::Regex
  re: !!perl/hash:RE_assertion
    assert: '?'
    re: !!perl/hash:RE_method_re
      name: before
      nobind: 1
      re: !!perl/hash:RE_method
        name: stopper
        rest: ''
nibbler: !!perl/hash:RE_ast
  dba: nibbler
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_method
      name: EXPR
      rest: ''
    - !!perl/hash:RE_method
      name: ws
      rest: ''
p5assertion:*:
  dic: STD::P5::Regex
p5assertion__S_040Question: !!perl/hash:RE_ast
  dba: p5assertion
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '?'
    - !!perl/hash:RE_method
      name: codeblock
      rest: ''
p5assertion__S_041Cur_Ly: !!perl/hash:RE_ast
  dba: p5assertion
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    name: codeblock
    rest: ''
p5assertion__S_042Lt: !!perl/hash:RE_ast
  dba: p5assertion
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: <
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: &2 !!perl/hash:RE_any
          altname: p5assertion__S_042Lt_0
          dba: p5assertion
          dic: STD::P5::Regex
          zyg:
          - !!perl/hash:RE_string
            alt: p5assertion__S_042Lt_0 0
            i: 0
            text: =
          - !!perl/hash:RE_string
            alt: p5assertion__S_042Lt_0 1
            i: 0
            text: '!'
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: p5assertion
        rest: ''
p5assertion__S_042Lt_0: *2
p5assertion__S_043Equal: !!perl/hash:RE_ast
  dba: p5assertion
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: =
    - !!perl/hash:RE_bracket
      re: &3 !!perl/hash:RE_any
        altname: p5assertion__S_043Equal_0
        dba: p5assertion
        dic: STD::P5::Regex
        zyg:
        - !!perl/hash:RE_assertion
          alt: p5assertion__S_043Equal_0 0
          assert: '?'
          re: !!perl/hash:RE_method_re
            name: before
            nobind: 1
            re: !!perl/hash:RE_string
              i: 0
              text: )
        - !!perl/hash:RE_method
          alt: p5assertion__S_043Equal_0 1
          name: rx
          rest: ''
p5assertion__S_043Equal_0: *3
p5assertion__S_044Bang: !!perl/hash:RE_ast
  dba: p5assertion
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '!'
    - !!perl/hash:RE_bracket
      re: &4 !!perl/hash:RE_any
        altname: p5assertion__S_044Bang_0
        dba: p5assertion
        dic: STD::P5::Regex
        zyg:
        - !!perl/hash:RE_assertion
          alt: p5assertion__S_044Bang_0 0
          assert: '?'
          re: !!perl/hash:RE_method_re
            name: before
            nobind: 1
            re: !!perl/hash:RE_string
              i: 0
              text: )
        - !!perl/hash:RE_method
          alt: p5assertion__S_044Bang_0 1
          name: rx
          rest: ''
p5assertion__S_044Bang_0: *4
p5assertion__S_045Gt: !!perl/hash:RE_ast
  dba: p5assertion
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '>'
    - !!perl/hash:RE_method
      name: rx
      rest: ''
p5assertion__S_046mod: !!perl/hash:RE_ast
  dba: p5assertion
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: p5mods
        rest: ''
    - !!perl/hash:RE_bracket
      re: &5 !!perl/hash:RE_any
        altname: p5assertion__S_046mod_0
        dba: p5assertion
        dic: STD::P5::Regex
        zyg:
        - !!perl/hash:RE_sequence
          alt: p5assertion__S_046mod_0 0
          zyg:
          - !!perl/hash:RE_string
            i: 0
            text: ':'
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_method
              name: rx
              rest: ''
            quant:
            - '?'
        - !!perl/hash:RE_assertion
          alt: p5assertion__S_046mod_0 1
          assert: '?'
          re: !!perl/hash:RE_method_re
            name: before
            nobind: 1
            re: !!perl/hash:RE_string
              i: 0
              text: )
p5assertion__S_046mod_0: *5
p5assertion__S_047bogus: !!perl/hash:RE_ast
  dba: p5assertion
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    name: panic
    rest: 1
p5backslash:*:
  dic: STD::P5::Regex
p5backslash__S_017A: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: A
p5backslash__S_018a: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: a
p5backslash__S_019b: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 1
    name: sym
    rest: ''
    sym: b
p5backslash__S_020c: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Regex
  re: !!perl/hash:RE_first
    zyg:
    - !!perl/hash:RE_sequence
      zyg:
      - !!perl/hash:RE_method
        i: 1
        name: sym
        rest: ''
        sym: c
      - !!perl/hash:RE_cclass
        i: 1
        text: '[ ?.._ ]'
    - !!perl/hash:RE_method
      name: panic
      rest: 1
p5backslash__S_021d: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 1
    name: sym
    rest: ''
    sym: d
p5backslash__S_022e: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 1
    name: sym
    rest: ''
    sym: e
p5backslash__S_023f: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 1
    name: sym
    rest: ''
    sym: f
p5backslash__S_024h: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 1
    name: sym
    rest: ''
    sym: h
p5backslash__S_025l: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 1
    name: sym
    rest: ''
    sym: l
p5backslash__S_026n: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 1
    name: sym
    rest: ''
    sym: n
p5backslash__S_027o: !!perl/hash:RE_ast
  dba: octal character
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: '0'
    - !!perl/hash:RE_bracket
      re: &6 !!perl/hash:RE_any
        altname: p5backslash__S_027o_0
        dba: octal character
        dic: STD::P5::Regex
        zyg:
        - !!perl/hash:RE_method
          alt: p5backslash__S_027o_0 0
          name: octint
          rest: ''
        - !!perl/hash:RE_bracket
          alt: p5backslash__S_027o_0 1
          re: !!perl/hash:RE_sequence
            zyg:
            - !!perl/hash:RE_string
              i: 0
              text: '{'
            - !!perl/hash:RE_block {}
            - !!perl/hash:RE_method
              name: octints
              rest: ''
            - !!perl/hash:RE_bracket
              re: !!perl/hash:RE_first
                zyg:
                - !!perl/hash:RE_string
                  i: 0
                  text: '}'
                - !!perl/hash:RE_method
                  name: FAILGOAL
                  rest: 1
p5backslash__S_027o_0: *6
p5backslash__S_028p: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 1
      name: sym
      rest: ''
      sym: p
    - !!perl/hash:RE_string
      i: 1
      text: '{'
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_cclass
        i: 1
        text: '[\w:]'
      quant:
      - +
    - !!perl/hash:RE_string
      i: 1
      text: '}'
p5backslash__S_029Q: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: Q
p5backslash__S_030r: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 1
    name: sym
    rest: ''
    sym: r
p5backslash__S_031s: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 1
    name: sym
    rest: ''
    sym: s
p5backslash__S_032t: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 1
    name: sym
    rest: ''
    sym: t
p5backslash__S_033u: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 1
    name: sym
    rest: ''
    sym: u
p5backslash__S_034v: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 1
    name: sym
    rest: ''
    sym: v
p5backslash__S_035w: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 1
    name: sym
    rest: ''
    sym: w
p5backslash__S_036x: !!perl/hash:RE_ast
  dba: hex character
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 1
      name: sym
      rest: ''
      sym: x
    - !!perl/hash:RE_bracket
      re: &7 !!perl/hash:RE_any
        altname: p5backslash__S_036x_0
        dba: hex character
        dic: STD::P5::Regex
        zyg:
        - !!perl/hash:RE_method
          alt: p5backslash__S_036x_0 0
          name: hexint
          rest: ''
        - !!perl/hash:RE_bracket
          alt: p5backslash__S_036x_0 1
          re: !!perl/hash:RE_sequence
            zyg:
            - !!perl/hash:RE_string
              i: 1
              text: '{'
            - !!perl/hash:RE_block {}
            - !!perl/hash:RE_method
              name: hexints
              rest: ''
            - !!perl/hash:RE_bracket
              re: !!perl/hash:RE_first
                zyg:
                - !!perl/hash:RE_string
                  i: 1
                  text: '}'
                - !!perl/hash:RE_method
                  name: FAILGOAL
                  rest: 1
p5backslash__S_036x_0: *7
p5backslash__S_037z: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 1
    name: sym
    rest: ''
    sym: z
p5backslash__S_038misc: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Regex
  re: &8 !!perl/hash:RE_any
    altname: p5backslash__S_038misc_0
    dba: p5backslash
    dic: STD::P5::Regex
    zyg:
    - !!perl/hash:RE_bindnamed
      alt: p5backslash__S_038misc_0 0
      atom: !!perl/hash:RE_paren
        re: !!perl/hash:RE_meta
          min: 1
          text: \W
    - !!perl/hash:RE_bindnamed
      alt: p5backslash__S_038misc_0 1
      atom: !!perl/hash:RE_paren
        re: !!perl/hash:RE_quantified_atom
          atom: !!perl/hash:RE_meta
            min: 1
            text: \d
          quant:
          - +
p5backslash__S_038misc_0: *8
p5backslash__S_039oops: !!perl/hash:RE_ast
  dba: p5backslash
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    name: panic
    rest: 1
p5metachar:*:
  dic: STD::P5::Regex
p5metachar__S_006Vert: !!perl/hash:RE_ast
  dba: p5metachar
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: '|'
    - !!perl/hash:RE_meta
      text: '::'
    - !!perl/hash:RE_method
      name: fail
      rest: ''
p5metachar__S_007Thesis: !!perl/hash:RE_ast
  dba: p5metachar
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: )
    - !!perl/hash:RE_meta
      text: '::'
    - !!perl/hash:RE_method
      name: fail
      rest: ''
p5metachar__S_008quant: !!perl/hash:RE_ast
  dba: p5metachar
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: p5quantifier
        rest: ''
    - !!perl/hash:RE_method
      name: panic
      rest: 1
p5metachar__S_009Bra_Ket: !!perl/hash:RE_ast
  dba: p5metachar
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method_re
      name: before
      re: !!perl/hash:RE_string
        i: 0
        text: '['
    - !!perl/hash:RE_method
      name: quibble
      rest: 1
p5metachar__S_010ParenQuestion_Thesis: !!perl/hash:RE_ast
  dba: p5metachar
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: (?
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: p5assertion
        rest: ''
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_first
        zyg:
        - !!perl/hash:RE_string
          i: 0
          text: )
        - !!perl/hash:RE_method
          name: panic
          rest: 1
p5metachar__S_011Paren_Thesis: !!perl/hash:RE_ast
  dba: p5metachar
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: (
    - !!perl/hash:RE_block {}
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_decl {}
          - !!perl/hash:RE_method
            name: nibbler
            rest: ''
      quant:
      - '?'
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_first
        zyg:
        - !!perl/hash:RE_string
          i: 0
          text: )
        - !!perl/hash:RE_method
          name: panic
          rest: 1
    - !!perl/hash:RE_block {}
p5metachar__S_012Back: !!perl/hash:RE_ast
  dba: p5metachar
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: \
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: p5backslash
        rest: ''
p5metachar__S_013Dot: !!perl/hash:RE_ast
  dba: p5metachar
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: .
p5metachar__S_014Caret: !!perl/hash:RE_ast
  dba: p5metachar
  dic: STD::P5::Regex
  re: !!perl/hash:RE_method
    i: 0
    name: sym
    rest: ''
    sym: ^
p5metachar__S_015Dollar: !!perl/hash:RE_ast
  dba: p5metachar
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: $
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: &9 !!perl/hash:RE_any
          altname: p5metachar__S_015Dollar_0
          dba: p5metachar
          dic: STD::P5::Regex
          zyg:
          - !!perl/hash:RE_meta
            alt: p5metachar__S_015Dollar_0 0
            min: 1
            text: \W
          - !!perl/hash:RE_meta
            alt: p5metachar__S_015Dollar_0 1
            text: $
p5metachar__S_015Dollar_0: *9
p5metachar__S_016var: !!perl/hash:RE_ast
  dba: p5metachar
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_method_re
        name: before
        nobind: 1
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_bindnamed
            atom: !!perl/hash:RE_method
              name: p5sigil
              rest: ''
          - !!perl/hash:RE_meta
            min: 1
            text: \w
    - !!perl/hash:RE_method
      name: panic
      rest: 1
p5mod: !!perl/hash:RE_ast
  dba: p5mod
  dic: STD::P5::Regex
  re: !!perl/hash:RE_quantified_atom
    atom: !!perl/hash:RE_cclass
      i: 0
      text: '[imox]'
    quant:
    - '*'
p5mod_internal:*:
  dic: STD::P5::Regex
p5mods: !!perl/hash:RE_ast
  dba: p5mods
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: p5mod
        rest: ''
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_string
            i: 0
            text: '-'
          - !!perl/hash:RE_bindnamed
            atom: !!perl/hash:RE_method
              name: p5mod
              rest: ''
      quant:
      - '?'
p5quantifier:*:
  dic: STD::P5::Regex
p5quantifier__S_048Star: !!perl/hash:RE_ast
  dba: p5quantifier
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '*'
    - !!perl/hash:RE_method
      name: quantmod
      rest: ''
p5quantifier__S_049Plus: !!perl/hash:RE_ast
  dba: p5quantifier
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: +
    - !!perl/hash:RE_method
      name: quantmod
      rest: ''
p5quantifier__S_050Question: !!perl/hash:RE_ast
  dba: p5quantifier
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '?'
    - !!perl/hash:RE_method
      name: quantmod
      rest: ''
p5quantifier__S_051Cur_Ly: !!perl/hash:RE_ast
  dba: p5quantifier
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_string
      i: 0
      text: '{'
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_meta
        min: 1
        text: \d
      quant:
      - +
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_string
            i: 0
            text: ','
          - !!perl/hash:RE_quantified_atom
            atom: !!perl/hash:RE_meta
              min: 1
              text: \d
            quant:
            - '*'
      quant:
      - '?'
    - !!perl/hash:RE_string
      i: 0
      text: '}'
    - !!perl/hash:RE_method
      name: quantmod
      rest: ''
p5regex_infix:*:
  dic: STD::P5::Regex
p5regex_infix__S_005Vert: !!perl/hash:RE_ast
  dba: p5regex_infix
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      i: 0
      name: sym
      rest: ''
      sym: '|'
    - !!perl/hash:RE_method
      name: O
      rest: 1
quant_atom_list: !!perl/hash:RE_ast
  dba: quant_atom_list
  dic: STD::P5::Regex
  re: !!perl/hash:RE_quantified_atom
    atom: !!perl/hash:RE_method
      name: quantified_atom
      rest: ''
    quant:
    - +
quantified_atom: !!perl/hash:RE_ast
  dba: quantified_atom
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_assertion
      assert: '!'
      re: !!perl/hash:RE_method
        name: stopper
        rest: ''
    - !!perl/hash:RE_assertion
      assert: '!'
      re: !!perl/hash:RE_method
        name: p5regex_infix
        rest: ''
    - !!perl/hash:RE_method
      name: atom
      rest: ''
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_method
            name: ws
            rest: ''
          - !!perl/hash:RE_bindnamed
            atom: !!perl/hash:RE_method
              name: p5quantifier
              rest: ''
      quant:
      - '?'
    - !!perl/hash:RE_method
      name: ws
      rest: ''
quantmod: !!perl/hash:RE_ast
  dba: quantmod
  dic: STD::P5::Regex
  re: !!perl/hash:RE_quantified_atom
    atom: !!perl/hash:RE_bracket
      re: &10 !!perl/hash:RE_any
        altname: quantmod_0
        dba: quantmod
        dic: STD::P5::Regex
        zyg:
        - !!perl/hash:RE_string
          alt: quantmod_0 0
          i: 0
          text: '?'
        - !!perl/hash:RE_string
          alt: quantmod_0 1
          i: 0
          text: +
    quant:
    - '?'
quantmod_0: *10
rx: !!perl/hash:RE_ast
  dba: rx
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: nibbler
      rest: ''
    - !!perl/hash:RE_bracket
      re: !!perl/hash:RE_first
        zyg:
        - !!perl/hash:RE_assertion
          assert: '?'
          re: !!perl/hash:RE_method_re
            name: before
            nobind: 1
            re: !!perl/hash:RE_string
              i: 0
              text: )
        - !!perl/hash:RE_method
          name: panic
          rest: 1
termish: !!perl/hash:RE_ast
  dba: termish
  dic: STD::P5::Regex
  re: !!perl/hash:RE_sequence
    zyg:
    - !!perl/hash:RE_method
      name: ws
      rest: ''
    - !!perl/hash:RE_bindnamed
      atom: !!perl/hash:RE_method
        name: quant_atom_list
        rest: ''
ws: !!perl/hash:RE_ast
  dba: ws
  dic: STD::P5::Regex
  re: !!perl/hash:RE_first
    zyg:
    - !!perl/hash:RE_assertion
      assert: '?'
      re: !!perl/hash:RE_block
        nobind: 1
    - !!perl/hash:RE_quantified_atom
      atom: !!perl/hash:RE_bracket
        re: !!perl/hash:RE_sequence
          zyg:
          - !!perl/hash:RE_assertion
            assert: '?'
            re: !!perl/hash:RE_method_re
              name: before
              nobind: 1
              re: &11 !!perl/hash:RE_any
                altname: ws_0
                dba: ws
                dic: STD::P5::Regex
                zyg:
                - !!perl/hash:RE_meta
                  alt: ws_0 0
                  min: 1
                  text: \s
                - !!perl/hash:RE_string
                  alt: ws_0 1
                  i: 0
                  text: '#'
          - !!perl/hash:RE_method
            name: nextsame
            rest: ''
      quant:
      - '?'
ws_0: *11
RETREE_END
## method tweak (:global(:$g)!)
;
## method tweak (:ignorecase(:$i)!)
;
## token category:p5metachar { <sym> }
sub category__S_000p5metachar__PEEK { $_[0]->_AUTOLEXpeek('category__S_000p5metachar', $retree) }
sub category__S_000p5metachar {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_000p5metachar");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5metachar";
$self->_MATCHIFYr($S, "category__S_000p5metachar", $C->_EXACT("p5metachar"));
}
;
## token p5metachar { <...> }
sub p5metachar__PEEK { $_[0]->_AUTOLEXpeek('p5metachar:*',$retree); }
sub p5metachar {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5metachar');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5metachar') {
$C->deb("Fate passed to p5metachar: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5metachar';
}
else {
$x = 'ALTLTM p5metachar';
}
}
else {
$x = 'ALTLTM p5metachar';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Regex', 'p5metachar:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5metachar trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5metachar", @gather);
};
@result;
}
;
## token category:p5backslash { <sym> }
sub category__S_001p5backslash__PEEK { $_[0]->_AUTOLEXpeek('category__S_001p5backslash', $retree) }
sub category__S_001p5backslash {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_001p5backslash");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5backslash";
$self->_MATCHIFYr($S, "category__S_001p5backslash", $C->_EXACT("p5backslash"));
}
;
## token p5backslash { <...> }
sub p5backslash__PEEK { $_[0]->_AUTOLEXpeek('p5backslash:*',$retree); }
sub p5backslash {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5backslash');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5backslash') {
$C->deb("Fate passed to p5backslash: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5backslash';
}
else {
$x = 'ALTLTM p5backslash';
}
}
else {
$x = 'ALTLTM p5backslash';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Regex', 'p5backslash:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5backslash trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5backslash", @gather);
};
@result;
}
;
## token category:p5assertion { <sym> }
sub category__S_002p5assertion__PEEK { $_[0]->_AUTOLEXpeek('category__S_002p5assertion', $retree) }
sub category__S_002p5assertion {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_002p5assertion");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5assertion";
$self->_MATCHIFYr($S, "category__S_002p5assertion", $C->_EXACT("p5assertion"));
}
;
## token p5assertion { <...> }
sub p5assertion__PEEK { $_[0]->_AUTOLEXpeek('p5assertion:*',$retree); }
sub p5assertion {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5assertion');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5assertion') {
$C->deb("Fate passed to p5assertion: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5assertion';
}
else {
$x = 'ALTLTM p5assertion';
}
}
else {
$x = 'ALTLTM p5assertion';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Regex', 'p5assertion:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5assertion trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5assertion", @gather);
};
@result;
}
;
## token category:p5quantifier { <sym> }
sub category__S_003p5quantifier__PEEK { $_[0]->_AUTOLEXpeek('category__S_003p5quantifier', $retree) }
sub category__S_003p5quantifier {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_003p5quantifier");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5quantifier";
$self->_MATCHIFYr($S, "category__S_003p5quantifier", $C->_EXACT("p5quantifier"));
}
;
## token p5quantifier { <...> }
sub p5quantifier__PEEK { $_[0]->_AUTOLEXpeek('p5quantifier:*',$retree); }
sub p5quantifier {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5quantifier');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5quantifier') {
$C->deb("Fate passed to p5quantifier: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5quantifier';
}
else {
$x = 'ALTLTM p5quantifier';
}
}
else {
$x = 'ALTLTM p5quantifier';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Regex', 'p5quantifier:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5quantifier trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5quantifier", @gather);
};
@result;
}
;
## token category:p5mod_internal { <sym> }
sub category__S_004p5mod_internal__PEEK { $_[0]->_AUTOLEXpeek('category__S_004p5mod_internal', $retree) }
sub category__S_004p5mod_internal {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE category__S_004p5mod_internal");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p5mod_internal";
$self->_MATCHIFYr($S, "category__S_004p5mod_internal", $C->_EXACT("p5mod_internal"));
}
;
## token p5mod_internal { <...> }
sub p5mod_internal__PEEK { $_[0]->_AUTOLEXpeek('p5mod_internal:*',$retree); }
sub p5mod_internal {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5mod_internal');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5mod_internal') {
$C->deb("Fate passed to p5mod_internal: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5mod_internal';
}
else {
$x = 'ALTLTM p5mod_internal';
}
}
else {
$x = 'ALTLTM p5mod_internal';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Regex', 'p5mod_internal:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5mod_internal trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5mod_internal", @gather);
};
@result;
}
;
## token p5regex_infix { <...> }
sub p5regex_infix__PEEK { $_[0]->_AUTOLEXpeek('p5regex_infix:*',$retree); }
sub p5regex_infix {
my $self = shift;
my $subs;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact('RULE p5regex_infix');
my $S = $C->{'_pos'};

my @result = do {
my ($tag, $try);
my @try;
my $relex;
my $x;
if (my $fate = $C->{'_fate'}) {
if ($fate->[1] eq 'p5regex_infix') {
$C->deb("Fate passed to p5regex_infix: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5regex_infix';
}
else {
$x = 'ALTLTM p5regex_infix';
}
}
else {
$x = 'ALTLTM p5regex_infix';
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Regex', 'p5regex_infix:*', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;       # next candidate fate
}

$C->deb("p5regex_infix trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, $C->$try(@_);
last if @gather;
last if $xact->[-2];  # committed?
}
$self->_MATCHIFYr($S, "p5regex_infix", @gather);
};
@result;
}
;
## token codeblock {
sub codeblock__PEEK { $_[0]->_AUTOLEXpeek('codeblock', $retree) }
sub codeblock {
no warnings 'recursion';
my $self = shift;

local $::GOAL = '}';
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE codeblock");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "codeblock", do {
my $C = $C;
if (($C) = ($C->_EXACT("\{"))
and ($C) = ($C->_COMMITLTM())
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
my $newlang = ($C->cursor_fresh($::LANG{'MAIN'}));
$C = bless($C, (ref($newlang) || $newlang));
$C->_SUBSUMEr(['statementlist'], sub {
my $C = shift;
$C->statementlist
})
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\}")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->panic("Unable to parse statement list; couldn't find right brace"))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }

});
}
;
## token ws {
sub ws__PEEK { $_[0]->_AUTOLEXpeek('ws', $retree) }
sub ws {
no warnings 'recursion';
my $self = shift;

my @origargs = @_;

local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE ws");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "ws", do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
if (my ($C) = ($C->before(sub {
my $C=shift;
(($C) x !!do {
$::RX->{'s'} })
}))) { ($C) } else { () }

}
}
or $xact->[-2] or
do {
push @gather, $C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = (do {
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'ws_0') {
$C->deb("Fate passed to ws_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT ws_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM ws_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Regex', 'ws_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("ws_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_PATTERN(qr/\G\s/)
},
sub {
my $C=shift;
$C->_EXACT("\#")
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};

})) { ($C) } else { () }
}))) { ($C) } else { () }
}))
and ($C) = ($self->SUPER::ws(@origargs))) {
$C
} else { () }
}))) { ($C) } else { () }
})
};
@gather;
});
}
;
## rule nibbler {
sub nibbler__PEEK { $_[0]->_AUTOLEXpeek('nibbler', $retree) }
sub nibbler {
no warnings 'recursion';
my $self = shift;

local $::ignorecase = $::ignorecase;
local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE nibbler");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "nibbler", do {
my $C = $C;
if (($C) = ($C->ws)
and ($C) = ($C->_SUBSUMEr(['EXPR'], sub {
my $C = shift;
$C->EXPR
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## token termish {
sub termish__PEEK { $_[0]->_AUTOLEXpeek('termish', $retree) }
sub termish {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE termish");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "termish", do {
if (my ($C) = ($C->ws)) {
$C->_SUBSUMEr(['term','quant_atom_list'], sub {
my $C = shift;
$C->quant_atom_list
})
} else { () }

});
}
;
## token quant_atom_list {
sub quant_atom_list__PEEK { $_[0]->_AUTOLEXpeek('quant_atom_list', $retree) }
sub quant_atom_list {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE quant_atom_list");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'quantified_atom'} = [];
$self->_MATCHIFYr($S, "quant_atom_list", $C->_PLUSr(sub {
my $C=shift;
$C->_SUBSUMEr(['quantified_atom'], sub {
my $C = shift;
$C->quantified_atom
})
}));
}
;
## token infixish {
sub infixish__PEEK { $_[0]->_AUTOLEXpeek('infixish', $retree) }
sub infixish {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE infixish");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "infixish", do {
my $C = $C;
if (($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->infixstopper)) { ($C) } else { () }
}))
and ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->stdstopper)) { ($C) } else { () }
}))
and ($C) = ($C->_SUBSUMEr(['regex_infix','p5regex_infix'], sub {
my $C = shift;
$C->p5regex_infix
}))) {
scalar(do {
my $M = $C;
$M->{'O'} = $M->{'regex_infix'}->{'O'};
$M->{'sym'} = $M->{'regex_infix'}->{'sym'};
}, $C)
} else { () }

});
}
;
## regex infixstopper {
sub infixstopper__PEEK { $_[0]->_AUTOLEXpeek('infixstopper', $retree) }
sub infixstopper {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE infixstopper");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFY($S, "infixstopper", $C->before(sub {
my $C=shift;
$C->_SUBSUME(['stopper'], sub {
my $C = shift;
$C->stopper
})
}));
}
;
## token p5regex_infix:sym<|> { <sym> <O(|%tight_or)>  }
sub p5regex_infix__S_005Vert__PEEK { $_[0]->_AUTOLEXpeek('p5regex_infix__S_005Vert', $retree) }
sub p5regex_infix__S_005Vert {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5regex_infix__S_005Vert");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\|";
$self->_MATCHIFYr($S, "p5regex_infix__S_005Vert", do {
if (my ($C) = ($C->_EXACT("\|"))) {
$C->_SUBSUMEr(['O'], sub {
my $C = shift;
$C->O(%tight_or)
})
} else { () }

});
}
;
## token quantified_atom {
sub quantified_atom__PEEK { $_[0]->_AUTOLEXpeek('quantified_atom', $retree) }
sub quantified_atom {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE quantified_atom");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'p5quantifier'} = [];
$C->{'quantifier'} = [];
$self->_MATCHIFYr($S, "quantified_atom", do {
my $C = $C;
if (($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->stopper)) { ($C) } else { () }
}))
and ($C) = ($C->_NOTBEFORE(sub {
my $C=shift;
if (my ($C) = ($C->p5regex_infix)) { ($C) } else { () }
}))
and ($C) = ($C->_SUBSUMEr(['atom'], sub {
my $C = shift;
$C->atom
}))
and ($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (my ($C) = ($C->ws)) {
$C->_SUBSUMEr(['quantifier','p5quantifier'], sub {
my $C = shift;
$C->p5quantifier
})
} else { () }
}))) { ($C) } else { () }
}))
and ($C) = ($C->ws)) {
$C
} else { () }

});
}
;
## token atom {
sub atom__PEEK { $_[0]->_AUTOLEXpeek('atom', $retree) }
sub atom {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE atom");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "atom", $C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'atom_0') {
$C->deb("Fate passed to atom_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT atom_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM atom_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Regex', 'atom_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("atom_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_PATTERN(qr/\G\w/)
},
sub {
my $C=shift;
$C->_SUBSUMEr(['metachar','p5metachar'], sub {
my $C = shift;
$C->p5metachar
})
},
sub {
my $C=shift;
if (($C) = ($C->_EXACT("\\"))
and ($C) = ($C->_COMMITLTM())) {
$C->cursor_incr()
} else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}));
}
;
## token p5metachar:sym<|>   { '|'  :: <fail> }
sub p5metachar__S_006Vert__PEEK { $_[0]->_AUTOLEXpeek('p5metachar__S_006Vert', $retree) }
sub p5metachar__S_006Vert {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5metachar__S_006Vert");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\|";
$self->_MATCHIFYr($S, "p5metachar__S_006Vert", do {
my $C = $C;
if (($C) = ($C->_EXACT("\|"))
and ($C) = ($C->_COMMITLTM())) {
$C->_SUBSUMEr(['fail'], sub {
my $C = shift;
$C->fail
})
} else { () }

});
}
;
## token p5metachar:sym<)>   { ')'  :: <fail> }
sub p5metachar__S_007Thesis__PEEK { $_[0]->_AUTOLEXpeek('p5metachar__S_007Thesis', $retree) }
sub p5metachar__S_007Thesis {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5metachar__S_007Thesis");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\)";
$self->_MATCHIFYr($S, "p5metachar__S_007Thesis", do {
my $C = $C;
if (($C) = ($C->_EXACT("\)"))
and ($C) = ($C->_COMMITLTM())) {
$C->_SUBSUMEr(['fail'], sub {
my $C = shift;
$C->fail
})
} else { () }

});
}
;
## token p5metachar:quant { <quantifier=p5quantifier> <.panic: "quantifier quantifies nothing"> }
sub p5metachar__S_008quant__PEEK { $_[0]->_AUTOLEXpeek('p5metachar__S_008quant', $retree) }
sub p5metachar__S_008quant {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5metachar__S_008quant");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "quant";
$self->_MATCHIFYr($S, "p5metachar__S_008quant", do {
my $C = $C;
if (($C) = ($C->_SUBSUMEr(['quantifier','p5quantifier'], sub {
my $C = shift;
$C->p5quantifier
}))
and ($C) = ($C->panic("quantifier quantifies nothing"))) {
$C
} else { () }

});
}
;
## token p5metachar:sym<[ ]> {
sub p5metachar__S_009Bra_Ket__PEEK { $_[0]->_AUTOLEXpeek('p5metachar__S_009Bra_Ket', $retree) }
sub p5metachar__S_009Bra_Ket {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5metachar__S_009Bra_Ket");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\[\ \]";
$self->_MATCHIFYr($S, "p5metachar__S_009Bra_Ket", do {
if (my ($C) = ($C->_SUBSUMEr(['before'], sub {
my $C = shift;
$C->before(sub {
my $C=shift;
$C->_EXACT("\[")
})
}))) {
$C->_SUBSUMEr(['quibble'], sub {
my $C = shift;
$C->quibble($C->cursor_fresh( $::LANG{'Q'} )->tweak('q' => 1))
})
} else { () }

});
}
;
## token p5metachar:sym«(? )» {
sub p5metachar__S_010ParenQuestion_Thesis__PEEK { $_[0]->_AUTOLEXpeek('p5metachar__S_010ParenQuestion_Thesis', $retree) }
sub p5metachar__S_010ParenQuestion_Thesis {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5metachar__S_010ParenQuestion_Thesis");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\(\?\ \)";
$self->_MATCHIFYr($S, "p5metachar__S_010ParenQuestion_Thesis", do {
my $C = $C;
if (($C) = ($C->_EXACT("\(\?"))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['assertion','p5assertion'], sub {
my $C = shift;
$C->p5assertion
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\)")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->panic("Perl 5 regex assertion not terminated by parenthesis"))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }

});
}
;
## token p5metachar:sym<( )> {
sub p5metachar__S_011Paren_Thesis__PEEK { $_[0]->_AUTOLEXpeek('p5metachar__S_011Paren_Thesis', $retree) }
sub p5metachar__S_011Paren_Thesis {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5metachar__S_011Paren_Thesis");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'nibbler'} = [];
$C->{sym} = "\(\ \)";
$self->_MATCHIFYr($S, "p5metachar__S_011Paren_Thesis", do {
my $C = $C;
if (($C) = ($C->_EXACT("\("))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
my $newlang = ($self->unbalanced(')'));
$C = bless($C, (ref($newlang) || $newlang));
$C->_SUBSUMEr(['nibbler'], sub {
my $C = shift;
$C->nibbler
})
}))) { ($C) } else { () }
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\)")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->panic("Unable to parse Perl 5 regex; couldn't find right parenthesis"))) { ($C) } else { () }

}
};
@gather;
}
}))) {
scalar(do {
my $M = $C;
$M->{'sym'} = <( )> }, $C)
} else { () }

});
}
;
## token p5metachar:sym<\\> { <sym> <backslash=p5backslash> }
sub p5metachar__S_012Back__PEEK { $_[0]->_AUTOLEXpeek('p5metachar__S_012Back', $retree) }
sub p5metachar__S_012Back {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5metachar__S_012Back");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\\";
$self->_MATCHIFYr($S, "p5metachar__S_012Back", do {
if (my ($C) = ($C->_EXACT("\\"))) {
$C->_SUBSUMEr(['backslash','p5backslash'], sub {
my $C = shift;
$C->p5backslash
})
} else { () }

});
}
;
## token p5metachar:sym<.>  { <sym> }
sub p5metachar__S_013Dot__PEEK { $_[0]->_AUTOLEXpeek('p5metachar__S_013Dot', $retree) }
sub p5metachar__S_013Dot {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5metachar__S_013Dot");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\.";
$self->_MATCHIFYr($S, "p5metachar__S_013Dot", $C->_EXACT("\."));
}
;
## token p5metachar:sym<^>  { <sym> }
sub p5metachar__S_014Caret__PEEK { $_[0]->_AUTOLEXpeek('p5metachar__S_014Caret', $retree) }
sub p5metachar__S_014Caret {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5metachar__S_014Caret");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\^";
$self->_MATCHIFYr($S, "p5metachar__S_014Caret", $C->_EXACT("\^"));
}
;
## token p5metachar:sym<$>  {
sub p5metachar__S_015Dollar__PEEK { $_[0]->_AUTOLEXpeek('p5metachar__S_015Dollar', $retree) }
sub p5metachar__S_015Dollar {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5metachar__S_015Dollar");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\$";
$self->_MATCHIFYr($S, "p5metachar__S_015Dollar", do {
my $C = $C;
if (($C) = ($C->_EXACT("\$"))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = (do {
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'p5metachar__S_015Dollar_0') {
$C->deb("Fate passed to p5metachar__S_015Dollar_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5metachar__S_015Dollar_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM p5metachar__S_015Dollar_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Regex', 'p5metachar__S_015Dollar_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("p5metachar__S_015Dollar_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_PATTERN(qr/\G\W/)
},
sub {
my $C=shift;
$C->_PATTERN(qr/\G\z/)
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};

})) { ($C) } else { () }
}))) { ($C) } else { () }
}))) {
$C
} else { () }

});
}
;
## token p5metachar:var {
sub p5metachar__S_016var__PEEK { $_[0]->_AUTOLEXpeek('p5metachar__S_016var', $retree) }
sub p5metachar__S_016var {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5metachar__S_016var");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "var";
$self->_MATCHIFYr($S, "p5metachar__S_016var", do {
my $C = $C;
if (($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->_SUBSUMEr(['sigil','p5sigil'], sub {
my $C = shift;
$C->p5sigil
}))) {
$C->_PATTERN(qr/\G\w/)
} else { () }
}))) { ($C) } else { () }
}))
and ($C) = ($C->panic("Can't interpolate variable in Perl 5 regex"))) {
$C
} else { () }

});
}
;
## token p5backslash:A { <sym> }
sub p5backslash__S_017A__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_017A', $retree) }
sub p5backslash__S_017A {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_017A");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "A";
$self->_MATCHIFYr($S, "p5backslash__S_017A", $C->_EXACT("A"));
}
;
## token p5backslash:a { <sym> }
sub p5backslash__S_018a__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_018a', $retree) }
sub p5backslash__S_018a {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_018a");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "a";
$self->_MATCHIFYr($S, "p5backslash__S_018a", $C->_EXACT("a"));
}
;
## token p5backslash:b { :i <sym> }
sub p5backslash__S_019b__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_019b', $retree) }
sub p5backslash__S_019b {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_019b");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "b";
$self->_MATCHIFYr($S, "p5backslash__S_019b", $C->_PATTERN(qr/\G(?i:b)/));
}
;
## token p5backslash:c { :i <sym>
sub p5backslash__S_020c__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_020c', $retree) }
sub p5backslash__S_020c {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_020c");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "c";
$self->_MATCHIFYr($S, "p5backslash__S_020c", do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_PATTERN(qr/\G(?i:c)(?i:[?-_])/)
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->panic("Unrecognized \\c character"))) { ($C) } else { () }

}
};
@gather;
});
}
;
## token p5backslash:d { :i <sym> }
sub p5backslash__S_021d__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_021d', $retree) }
sub p5backslash__S_021d {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_021d");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "d";
$self->_MATCHIFYr($S, "p5backslash__S_021d", $C->_PATTERN(qr/\G(?i:d)/));
}
;
## token p5backslash:e { :i <sym> }
sub p5backslash__S_022e__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_022e', $retree) }
sub p5backslash__S_022e {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_022e");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "e";
$self->_MATCHIFYr($S, "p5backslash__S_022e", $C->_PATTERN(qr/\G(?i:e)/));
}
;
## token p5backslash:f { :i <sym> }
sub p5backslash__S_023f__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_023f', $retree) }
sub p5backslash__S_023f {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_023f");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "f";
$self->_MATCHIFYr($S, "p5backslash__S_023f", $C->_PATTERN(qr/\G(?i:f)/));
}
;
## token p5backslash:h { :i <sym> }
sub p5backslash__S_024h__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_024h', $retree) }
sub p5backslash__S_024h {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_024h");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "h";
$self->_MATCHIFYr($S, "p5backslash__S_024h", $C->_PATTERN(qr/\G(?i:h)/));
}
;
## token p5backslash:l { :i <sym> }
sub p5backslash__S_025l__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_025l', $retree) }
sub p5backslash__S_025l {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_025l");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "l";
$self->_MATCHIFYr($S, "p5backslash__S_025l", $C->_PATTERN(qr/\G(?i:l)/));
}
;
## token p5backslash:n { :i <sym> }
sub p5backslash__S_026n__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_026n', $retree) }
sub p5backslash__S_026n {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_026n");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "n";
$self->_MATCHIFYr($S, "p5backslash__S_026n", $C->_PATTERN(qr/\G(?i:n)/));
}
;
## token p5backslash:o { :dba('octal character') '0' [ <octint> | '{' ~ '}' <octints> ] }
sub p5backslash__S_027o__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_027o', $retree) }
sub p5backslash__S_027o {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_027o");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "o";
$self->_MATCHIFYr($S, "p5backslash__S_027o", do {
my $C = $C;
if (($C) = ($C->_EXACT("0"))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'p5backslash__S_027o_0') {
$C->deb("Fate passed to p5backslash__S_027o_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5backslash__S_027o_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM p5backslash__S_027o_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Regex', 'p5backslash__S_027o_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("p5backslash__S_027o_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_SUBSUMEr(['octint'], sub {
my $C = shift;
$C->octint
})
},
sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\}";
my $goalpos = $C;
if (($C) = ($C->_EXACT("\{"))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['octints'], sub {
my $C = shift;
$C->octints
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_EXACT("\}")
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'octal character', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) { ($C) } else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

});
}
;
## token p5backslash:p { :i <sym> '{' <[\w:]>+ '}' }
sub p5backslash__S_028p__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_028p', $retree) }
sub p5backslash__S_028p {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_028p");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "p";
$self->_MATCHIFYr($S, "p5backslash__S_028p", $C->_PATTERN(qr/\G(?i:p)(?i:\{)(?i:[\w:])++(?i:\})/));
}
;
## token p5backslash:Q { <sym> }
sub p5backslash__S_029Q__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_029Q', $retree) }
sub p5backslash__S_029Q {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_029Q");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "Q";
$self->_MATCHIFYr($S, "p5backslash__S_029Q", $C->_EXACT("Q"));
}
;
## token p5backslash:r { :i <sym> }
sub p5backslash__S_030r__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_030r', $retree) }
sub p5backslash__S_030r {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_030r");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "r";
$self->_MATCHIFYr($S, "p5backslash__S_030r", $C->_PATTERN(qr/\G(?i:r)/));
}
;
## token p5backslash:s { :i <sym> }
sub p5backslash__S_031s__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_031s', $retree) }
sub p5backslash__S_031s {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_031s");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "s";
$self->_MATCHIFYr($S, "p5backslash__S_031s", $C->_PATTERN(qr/\G(?i:s)/));
}
;
## token p5backslash:t { :i <sym> }
sub p5backslash__S_032t__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_032t', $retree) }
sub p5backslash__S_032t {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_032t");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "t";
$self->_MATCHIFYr($S, "p5backslash__S_032t", $C->_PATTERN(qr/\G(?i:t)/));
}
;
## token p5backslash:u { :i <sym> }
sub p5backslash__S_033u__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_033u', $retree) }
sub p5backslash__S_033u {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_033u");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "u";
$self->_MATCHIFYr($S, "p5backslash__S_033u", $C->_PATTERN(qr/\G(?i:u)/));
}
;
## token p5backslash:v { :i <sym> }
sub p5backslash__S_034v__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_034v', $retree) }
sub p5backslash__S_034v {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_034v");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "v";
$self->_MATCHIFYr($S, "p5backslash__S_034v", $C->_PATTERN(qr/\G(?i:v)/));
}
;
## token p5backslash:w { :i <sym> }
sub p5backslash__S_035w__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_035w', $retree) }
sub p5backslash__S_035w {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_035w");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "w";
$self->_MATCHIFYr($S, "p5backslash__S_035w", $C->_PATTERN(qr/\G(?i:w)/));
}
;
## token p5backslash:x { :i :dba('hex character') <sym> [ <hexint> | '{' ~ '}' <hexints> ] }
sub p5backslash__S_036x__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_036x', $retree) }
sub p5backslash__S_036x {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_036x");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "x";
$self->_MATCHIFYr($S, "p5backslash__S_036x", do {
my $C = $C;
if (($C) = ($C->_PATTERN(qr/\G(?i:x)/))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'p5backslash__S_036x_0') {
$C->deb("Fate passed to p5backslash__S_036x_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5backslash__S_036x_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM p5backslash__S_036x_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Regex', 'p5backslash__S_036x_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("p5backslash__S_036x_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_SUBSUMEr(['hexint'], sub {
my $C = shift;
$C->hexint
})
},
sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
local $::GOAL = "\}";
my $goalpos = $C;
if (($C) = ($C->_PATTERN(qr/\G(?i:\{)/))
and ($C) = (scalar(do {
}, $C))
and ($C) = ($C->_SUBSUMEr(['hexints'], sub {
my $C = shift;
$C->hexints
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, $C->_PATTERN(qr/\G(?i:\})/)
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->FAILGOAL($::GOAL, 'hex character', $goalpos))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }
}))) { ($C) } else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

});
}
;
## token p5backslash:z { :i <sym> }
sub p5backslash__S_037z__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_037z', $retree) }
sub p5backslash__S_037z {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_037z");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "z";
$self->_MATCHIFYr($S, "p5backslash__S_037z", $C->_PATTERN(qr/\G(?i:z)/));
}
;
## token p5backslash:misc { $<litchar>=(\W) | $<number>=(\d+) }
sub p5backslash__S_038misc__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_038misc', $retree) }
sub p5backslash__S_038misc {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_038misc");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "misc";
$self->_MATCHIFYr($S, "p5backslash__S_038misc", do {
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'p5backslash__S_038misc_0') {
$C->deb("Fate passed to p5backslash__S_038misc_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5backslash__S_038misc_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM p5backslash__S_038misc_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Regex', 'p5backslash__S_038misc_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("p5backslash__S_038misc_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_SUBSUMEr(['litchar'], sub {
my $C = shift;
$C->_PAREN( sub {
my $C=shift;
$C->_PATTERN(qr/\G\W/)

})
})
},
sub {
my $C=shift;
$C->_SUBSUMEr(['number'], sub {
my $C = shift;
$C->_PAREN( sub {
my $C=shift;
$C->_PATTERN(qr/\G\d++/)

})
})
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};

});
}
;
## token p5backslash:oops { <.panic: "Unrecognized Perl 5 regex backslash sequence"> }
sub p5backslash__S_039oops__PEEK { $_[0]->_AUTOLEXpeek('p5backslash__S_039oops', $retree) }
sub p5backslash__S_039oops {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5backslash__S_039oops");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "oops";
$self->_MATCHIFYr($S, "p5backslash__S_039oops", $C->panic("Unrecognized Perl 5 regex backslash sequence"));
}
;
## token p5assertion:sym<?> { <sym> <codeblock> }
sub p5assertion__S_040Question__PEEK { $_[0]->_AUTOLEXpeek('p5assertion__S_040Question', $retree) }
sub p5assertion__S_040Question {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5assertion__S_040Question");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\?";
$self->_MATCHIFYr($S, "p5assertion__S_040Question", do {
if (my ($C) = ($C->_EXACT("\?"))) {
$C->_SUBSUMEr(['codeblock'], sub {
my $C = shift;
$C->codeblock
})
} else { () }

});
}
;
## token p5assertion:sym<{ }> { <codeblock> }
sub p5assertion__S_041Cur_Ly__PEEK { $_[0]->_AUTOLEXpeek('p5assertion__S_041Cur_Ly', $retree) }
sub p5assertion__S_041Cur_Ly {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5assertion__S_041Cur_Ly");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\{\ \}";
$self->_MATCHIFYr($S, "p5assertion__S_041Cur_Ly", $C->_SUBSUMEr(['codeblock'], sub {
my $C = shift;
$C->codeblock
}));
}
;
## token p5assertion:sym«<» { <sym> <?before '=' | '!'> <assertion=p5assertion> }
sub p5assertion__S_042Lt__PEEK { $_[0]->_AUTOLEXpeek('p5assertion__S_042Lt', $retree) }
sub p5assertion__S_042Lt {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5assertion__S_042Lt");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\<";
$self->_MATCHIFYr($S, "p5assertion__S_042Lt", do {
my $C = $C;
if (($C) = ($C->_EXACT("\<"))
and ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = (do {
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'p5assertion__S_042Lt_0') {
$C->deb("Fate passed to p5assertion__S_042Lt_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5assertion__S_042Lt_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM p5assertion__S_042Lt_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Regex', 'p5assertion__S_042Lt_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("p5assertion__S_042Lt_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_EXACT("\=")
},
sub {
my $C=shift;
$C->_EXACT("\!")
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};

})) { ($C) } else { () }
}))) { ($C) } else { () }
}))) {
$C->_SUBSUMEr(['assertion','p5assertion'], sub {
my $C = shift;
$C->p5assertion
})
} else { () }

});
}
;
## token p5assertion:sym<=> { <sym> [ <?before ')'> | <rx> ] }
sub p5assertion__S_043Equal__PEEK { $_[0]->_AUTOLEXpeek('p5assertion__S_043Equal', $retree) }
sub p5assertion__S_043Equal {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5assertion__S_043Equal");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\=";
$self->_MATCHIFYr($S, "p5assertion__S_043Equal", do {
my $C = $C;
if (($C) = ($C->_EXACT("\="))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'p5assertion__S_043Equal_0') {
$C->deb("Fate passed to p5assertion__S_043Equal_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5assertion__S_043Equal_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM p5assertion__S_043Equal_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Regex', 'p5assertion__S_043Equal_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("p5assertion__S_043Equal_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\)")
}))) { ($C) } else { () }
}))) { ($C) } else { () }
},
sub {
my $C=shift;
$C->_SUBSUMEr(['rx'], sub {
my $C = shift;
$C->rx
})
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

});
}
;
## token p5assertion:sym<!> { <sym> [ <?before ')'> | <rx> ] }
sub p5assertion__S_044Bang__PEEK { $_[0]->_AUTOLEXpeek('p5assertion__S_044Bang', $retree) }
sub p5assertion__S_044Bang {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5assertion__S_044Bang");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\!";
$self->_MATCHIFYr($S, "p5assertion__S_044Bang", do {
my $C = $C;
if (($C) = ($C->_EXACT("\!"))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'p5assertion__S_044Bang_0') {
$C->deb("Fate passed to p5assertion__S_044Bang_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5assertion__S_044Bang_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM p5assertion__S_044Bang_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Regex', 'p5assertion__S_044Bang_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("p5assertion__S_044Bang_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\)")
}))) { ($C) } else { () }
}))) { ($C) } else { () }
},
sub {
my $C=shift;
$C->_SUBSUMEr(['rx'], sub {
my $C = shift;
$C->rx
})
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

});
}
;
## token p5assertion:sym«>» { <sym> <rx> }
sub p5assertion__S_045Gt__PEEK { $_[0]->_AUTOLEXpeek('p5assertion__S_045Gt', $retree) }
sub p5assertion__S_045Gt {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5assertion__S_045Gt");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\>";
$self->_MATCHIFYr($S, "p5assertion__S_045Gt", do {
if (my ($C) = ($C->_EXACT("\>"))) {
$C->_SUBSUMEr(['rx'], sub {
my $C = shift;
$C->rx
})
} else { () }

});
}
;
## token rx {
sub rx__PEEK { $_[0]->_AUTOLEXpeek('rx', $retree) }
sub rx {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE rx");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "rx", do {
my $C = $C;
if (($C) = ($C->_SUBSUMEr(['nibbler'], sub {
my $C = shift;
$C->nibbler
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {    my $C = $C->cursor_xact('ALT ||');
my $xact = $C->xact;
my @gather;
do {
push @gather, do {
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\)")
}))) { ($C) } else { () }
}))) { ($C) } else { () }

}
}
or $xact->[-2] or
do {
push @gather, do {
if (my ($C) = ($C->panic("Unable to parse Perl 5 regex; couldn't find right parenthesis"))) { ($C) } else { () }

}
};
@gather;
}
}))) {
$C
} else { () }

});
}
;
## token p5mod { <[imox]>* }
sub p5mod__PEEK { $_[0]->_AUTOLEXpeek('p5mod', $retree) }
sub p5mod {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5mod");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "p5mod", $C->_PATTERN(qr/\G(?:[imox])*+/));
}
;
## token p5mods { <on=p5mod> [ '-' <off=p5mod> ]? }
sub p5mods__PEEK { $_[0]->_AUTOLEXpeek('p5mods', $retree) }
sub p5mods {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5mods");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'off'} = [];
$C->{'p5mod'} = [];
$self->_MATCHIFYr($S, "p5mods", do {
if (my ($C) = ($C->_SUBSUMEr(['on','p5mod'], sub {
my $C = shift;
$C->p5mod
}))) {
$C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
if (my ($C) = ($C->_EXACT("\-"))) {
$C->_SUBSUMEr(['off','p5mod'], sub {
my $C = shift;
$C->p5mod
})
} else { () }
}))) { ($C) } else { () }
})
} else { () }

});
}
;
## token p5assertion:mod { <mods=p5mods> [               # is qq right here?
sub p5assertion__S_046mod__PEEK { $_[0]->_AUTOLEXpeek('p5assertion__S_046mod', $retree) }
sub p5assertion__S_046mod {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5assertion__S_046mod");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{'rx'} = [];
$C->{sym} = "mod";
$self->_MATCHIFYr($S, "p5assertion__S_046mod", do {
my $C = $C;
if (($C) = ($C->_SUBSUMEr(['mods','p5mods'], sub {
my $C = shift;
$C->p5mods
}))
and ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'p5assertion__S_046mod_0') {
$C->deb("Fate passed to p5assertion__S_046mod_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT p5assertion__S_046mod_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM p5assertion__S_046mod_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Regex', 'p5assertion__S_046mod_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("p5assertion__S_046mod_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
if (my ($C) = ($C->_EXACT("\:"))) {
$C->_OPTr(sub {
my $C=shift;
$C->_SUBSUMEr(['rx'], sub {
my $C = shift;
$C->rx
})
})
} else { () }
},
sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
if (my ($C) = ($C->before(sub {
my $C=shift;
$C->_EXACT("\)")
}))) { ($C) } else { () }
}))) { ($C) } else { () }
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) {
$C
} else { () }

});
}
;
## token p5assertion:bogus { <.panic: "Unrecognized Perl 5 regex assertion"> }
sub p5assertion__S_047bogus__PEEK { $_[0]->_AUTOLEXpeek('p5assertion__S_047bogus', $retree) }
sub p5assertion__S_047bogus {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5assertion__S_047bogus");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "bogus";
$self->_MATCHIFYr($S, "p5assertion__S_047bogus", $C->panic("Unrecognized Perl 5 regex assertion"));
}
;
## token p5quantifier:sym<*>  { <sym> <quantmod> }
sub p5quantifier__S_048Star__PEEK { $_[0]->_AUTOLEXpeek('p5quantifier__S_048Star', $retree) }
sub p5quantifier__S_048Star {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5quantifier__S_048Star");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\*";
$self->_MATCHIFYr($S, "p5quantifier__S_048Star", do {
if (my ($C) = ($C->_EXACT("\*"))) {
$C->_SUBSUMEr(['quantmod'], sub {
my $C = shift;
$C->quantmod
})
} else { () }

});
}
;
## token p5quantifier:sym<+>  { <sym> <quantmod> }
sub p5quantifier__S_049Plus__PEEK { $_[0]->_AUTOLEXpeek('p5quantifier__S_049Plus', $retree) }
sub p5quantifier__S_049Plus {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5quantifier__S_049Plus");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\+";
$self->_MATCHIFYr($S, "p5quantifier__S_049Plus", do {
if (my ($C) = ($C->_EXACT("\+"))) {
$C->_SUBSUMEr(['quantmod'], sub {
my $C = shift;
$C->quantmod
})
} else { () }

});
}
;
## token p5quantifier:sym<?>  { <sym> <quantmod> }
sub p5quantifier__S_050Question__PEEK { $_[0]->_AUTOLEXpeek('p5quantifier__S_050Question', $retree) }
sub p5quantifier__S_050Question {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5quantifier__S_050Question");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\?";
$self->_MATCHIFYr($S, "p5quantifier__S_050Question", do {
if (my ($C) = ($C->_EXACT("\?"))) {
$C->_SUBSUMEr(['quantmod'], sub {
my $C = shift;
$C->quantmod
})
} else { () }

});
}
;
## token p5quantifier:sym<{ }> { '{' \d+ [','\d*]? '}' <quantmod> }
sub p5quantifier__S_051Cur_Ly__PEEK { $_[0]->_AUTOLEXpeek('p5quantifier__S_051Cur_Ly', $retree) }
sub p5quantifier__S_051Cur_Ly {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE p5quantifier__S_051Cur_Ly");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$C->{sym} = "\{\ \}";
$self->_MATCHIFYr($S, "p5quantifier__S_051Cur_Ly", do {
my $C = $C;
if (($C) = ($C->_PATTERN(qr/\G\{\d++/))
and ($C) = ($C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
$C->_PATTERN(qr/\G\,\d*+/)
}))) { ($C) } else { () }
}))
and ($C) = ($C->_EXACT("\}"))) {
$C->_SUBSUMEr(['quantmod'], sub {
my $C = shift;
$C->quantmod
})
} else { () }

});
}
;
## token quantmod { [ '?' | '+' ]? }
sub quantmod__PEEK { $_[0]->_AUTOLEXpeek('quantmod', $retree) }
sub quantmod {
no warnings 'recursion';
my $self = shift;


local $::CTX = $self->callm() if $::DEBUG & DEBUG::trace_call;

my $C = $self->cursor_xact("RULE quantmod");
my $xact = $C->xact;
my $S = $C->{'_pos'};
$self->_MATCHIFYr($S, "quantmod", $C->_OPTr(sub {
my $C=shift;
if (my ($C) = ($C->_BRACKETr(sub {
my $C=shift;
do {
my ($tag, $try);
my @try;
my $relex;

my $fate;
my $x;
if ($fate = $C->{'_fate'} and $fate->[1] eq 'quantmod_0') {
$C->deb("Fate passed to quantmod_0: ", ::fatestr($fate)) if $::DEBUG & DEBUG::fates;
($C->{'_fate'}, $tag, $try) = @$fate;
@try = ($try);
$x = 'ALT quantmod_0';    # some outer ltm is controlling us
}
else {
$x = 'ALTLTM quantmod_0'; # we are top level ltm
}
my $C = $C->cursor_xact($x);
my $xact = $C->{_xact};

my @gather = ();
for (;;) {
unless (@try) {
$relex //= $C->cursor_fate('STD::P5::Regex', 'quantmod_0', $retree);
@try = $relex->($C) or last;
}
$try = shift(@try) // next;

if (ref $try) {
($C->{'_fate'}, $tag, $try) = @$try;   # next candidate fate
}

$C->deb("quantmod_0 trying $tag $try") if $::DEBUG & DEBUG::try_processing;
push @gather, ((
sub {
my $C=shift;
$C->_EXACT("\?")
},
sub {
my $C=shift;
$C->_EXACT("\+")
}
)[$try])->($C);
last if @gather;
last if $xact->[-2];  # committed?
}
@gather;
};
}))) { ($C) } else { () }
}));
}
;
moose_around tweak  => sub {
my $orig = shift;
no warnings 'recursion';
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{global} || exists $args{g};
my $g = exists $args{global} ? delete $args{global} : exists $args{g} ? delete $args{g} : undef;
$self     };
}
{
local @_ = @_;
return scalar do { # work around #38809
my $self = shift;
my %args = @_;
last unless exists $args{ignorecase} || exists $args{i};
my $i = exists $args{ignorecase} ? delete $args{ignorecase} : exists $args{i} ? delete $args{i} : undef;
$self     };
}
$orig->(@_);
};

1; };
1; }
