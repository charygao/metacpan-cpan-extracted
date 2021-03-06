use strict;
use warnings;
use Test::More;

# generated by Dist::Zilla::Plugin::Test::PodSpelling 2.006008
use Test::Spelling 0.12;
use Pod::Wordlist;


add_stopwords(<DATA>);
all_pod_files_spelling_ok( qw( bin lib  ) );
__DATA__
mckeeman
multipass
typedef
enums
grammarName
lexemeCallback
logInfo
earley
bnf
lhs
rhs
recognizer
recognizer's
marpa
marpa's
scanless
lexeme
ast
trigerred
conditionMode
subscriptionMode
callbackArgs
wantedArgs
Jean
Durand
jeandamiendurand
jddurand
lib
MarpaX
Languages
ECMAScript
AST
Exceptions
Grammar
Base
DefaultSemanticsPackage
CharacterClasses
ECMAScript_262_5
JSON
Lexical
NumericLiteral
RegularExpressionLiteral
StringLiteral
Semantics
Pattern
Program
SpacesAny
StringNumericLiteral
NativeNumberSemantics
Template
URI
Impl
Logger
Singleton
Util
