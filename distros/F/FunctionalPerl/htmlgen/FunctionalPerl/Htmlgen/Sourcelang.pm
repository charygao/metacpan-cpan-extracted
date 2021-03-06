#
# Copyright (c) 2019 Christian Jaeger, copying@christianjaeger.ch
#
# This is free software, offered under either the same terms as perl 5
# or the terms of the Artistic License version 2 or the terms of the
# MIT License (Expat version). See the file COPYING.md that came
# bundled with this file.
#

=head1 NAME

FunctionalPerl::Htmlgen::Sourcelang -- detect programming language

=head1 SYNOPSIS

    use FunctionalPerl::Htmlgen::Sourcelang;
    is sourcelang("use Foo;"), "Perl";

=head1 DESCRIPTION

Detect if a piece of code is Perl, or more likely some other language.

=head1 NOTE

This is alpha software! Read the status section in the package README
or on the L<website|http://functional-perl.org/>.

=cut


package FunctionalPerl::Htmlgen::Sourcelang;
@ISA="Exporter"; require Exporter;
@EXPORT=qw(sourcelang);
@EXPORT_OK=qw();
%EXPORT_TAGS=(all=>[@EXPORT,@EXPORT_OK]);

use strict; use warnings; use warnings FATAL => 'uninitialized';
use Function::Parameters qw(:strict);
use Sub::Call::Tail;
use FP::Docstring;

sub sourcelang {
    __  '($codestr) -> $langname '.
        '-- langname is either "perl", or some other string';
    my ($str)= @_;
    my $perl=0;
    my $sh=0;
    
    $perl++ if $str=~ /(?:^|\n)\s*use\s+\w+/;
    $perl++ if $str=~ /\w+::\w+/;
    $perl++ if $str=~ /\$\w+\s*->\s*\w+/;
    $perl++ if $str=~ /\bmy\s+\$\w+\s*(?:=\s*[^;]*)?;/;
    $perl++ if $str=~ /\bmy\s+\(\$\w+/;
    $perl++ if $str=~ /\bsub\s*\{/;
    $perl+= 1 if $str=~ /\bfunc?\b\s*(?:\w+\s*)?\((?:(?:\s*\$\w+\s*,)*\s*\$\w+\s*)?\)\s*\{/s;
    $perl+= 0.5 if $str=~ /\@\{\s*/;
    $perl+= 0.5 if $str=~ /\bcompose\s*\(/;
    $perl+= 0.5 if $str=~ /\\\&\w+/;
    $perl+= 0.5 if $str=~ /->/;
    $perl+= 0.5 if $str=~ /\(\s*\*\w+/;
    $perl+= 0.5 if $str=~ /\(.*?,.*?\)/; # (1,3,4) or ([1,3,4])
    $perl+= 0.5 if $str=~ /\(\s*\[.*?\].*?\)/; # ([1,3,4])
    do { $perl+= 0.5; $sh+= 0.5 } if $str=~ /\$\w+/;
    $perl+= 1 if $str=~ /(?:^|\n|;)\s*push\s+\@\w+\s*,\s*/;
    $perl+= 1 if $str=~ /\$VAR\d+\b/;
    $perl+= 1 if $str=~ /(?:perlrepl|fperl)(?: *\d+)?>.*\bF\b/;
    $perl+= 1 if $str=~ /\blazy\s*\{/;
    $sh+=2 if $str=~ /(?:^|\n)\s*(?:#\s*)?(?:git|gpg|ls|chmod|cd) /;
    ($perl>=1 and $perl>$sh) ? "Perl" : "shell"
}

use Chj::TEST;
use FP::PureArray;

TEST {
    purearray('Foo::bar;', 'Foo;', 'use Foo;', 'my $a', 'my $a;',
              'my $abc= 2+ 2;', 'tar -xzf foo.tgz', 'fun inverse ($x) { 1 / $x }')
        ->map(*sourcelang)
} purearray("Perl", "shell", "Perl", "shell", "Perl", 
            "Perl", "shell", "Perl");

1
