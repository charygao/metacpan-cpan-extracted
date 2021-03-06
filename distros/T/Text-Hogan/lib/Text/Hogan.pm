package Text::Hogan;
$Text::Hogan::VERSION = '2.03';
use strict;
use warnings;

1;

__END__

=head1 NAME

Text::Hogan - A mustache templating engine statement-for-statement cloned from hogan.js

=head1 VERSION

version 2.03

=head1 DESCRIPTION

Text::Hogan is a statement-for-statement rewrite of
L<hogan.js|http://twitter.github.io/hogan.js/> in Perl.

It is a L<mustache|https://mustache.github.io/> templating engine which
supports pre-compilation of your templates into pure Perl code, which then
renders very quickly.

It passes the full L<mustache spec|https://github.com/mustache/spec>.

=head1 SYNOPSIS

    use Text::Hogan::Compiler;

    my $text = "Hello, {{name}}!";

    my $compiler = Text::Hogan::Compiler->new;
    my $template = $compiler->compile($text);

    say $template->render({ name => "Alex" });

See L<Text::Hogan::Compiler|Text::Hogan::Compiler> and
L<Text::Hogan::Template|Text::Hogan::Template> for more details.

=head1 TEMPLATE FORMAT

The template format is documented in
L<mustache(5)|https://mustache.github.io/mustache.5.html>.

=head1 SEE ALSO

=head2 hogan.js

L<hogan.js|http://twitter.github.io/hogan.js/> is the original library that
Text::Hogan is based on. It was written and is maintained by Twitter. It runs
on Node.js and pre-compiles templates to pure JavaScript.

=head2 Text::Caml

L<Text::Caml|Text::Caml> supports searching for partials by file name, by
default .caml but that can be configured.

=head2 Template::Mustache

L<Template::Mustache|Template::Mustache> is used by Dancer::Template::Mustache
and Dancer2::Template::Mustache. It supports compile once, render many times,
but does not allow dumping the compiled form to disk.

=head2 Mustache::Simple

L<Mustache::Simple|Mustache::Simple> largely supports the Mustache spec, but
skips the whitespace and decimal tests (its behaviour with decimals is the same
as Text::Hogan with 'numeric_string_as_string' option enabled.) It supports
passing objects with getters to the context hash, so that {{name}} can be
rendered from $object->name if $object->can('name') returns true.

=head1 AUTHORS

Started out statement-for-statement copied from hogan.js by Twitter!

Initial translation by Alex Balhatchet (alex@balhatchet.net)

Further improvements from:

Ed Freyfogle
Mohammad S Anwar
Ricky Morse
Jerrad Pierce
Tom Hukins
Tony Finch
Yanick Champoux

=cut
