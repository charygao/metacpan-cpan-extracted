package Perl::ToPerl6::Transformer::Variables::QuoteHashKeys;

use 5.006001;
use strict;
use warnings;
use Readonly;

use Perl::ToPerl6::Utils qw{ :severities };

use base 'Perl::ToPerl6::Transformer';

#-----------------------------------------------------------------------------

Readonly::Scalar my $DESC => q{Transform %x{a} to %x{'a'} depending upon mode};
Readonly::Scalar my $EXPL =>
    q{Perl6 assumes that braces are code blocks, so any content must be compilable};

#-----------------------------------------------------------------------------

sub supported_parameters {
    return ( {
        name           => 'perl6_mode',
        description    => q{Controls whether <> or {''} are used},
        default_string => 0,
        behavior       => 'boolean'
    } )
}
sub default_necessity    { return $NECESSITY_HIGHEST }
sub default_themes       { return qw( core )         }
sub applies_to           {
    return sub {
        $_[1]->isa('PPI::Structure::Subscript') and
        $_[1]->start->content eq '{' and
        $_[1]->finish->content eq '}' and
        ( $_[1]->sprevious_sibling->isa('PPI::Token::Symbol') or
          $_[1]->sprevious_sibling->isa('PPI::Token::Operator') ) and
        not $_[1]->schild(0)->schild(0)->isa('PPI::Token::Quote')
    }
}

#-----------------------------------------------------------------------------

sub transform {
    my ($self, $elem, $doc) = @_;
    my $token = $elem;

    while ( $token and
            $token->isa('PPI::Structure::Subscript') ) {
        if ( $token->start and
             $token->start->content eq '{' ) {
            if ( $self->{_perl6_mode} ) {
                $token->start->set_content('<');
                $token->finish->set_content('>');
            }
            else {
                 my $bareword = $token->schild(0)->schild(0);
                 my $old_content = $bareword->content;
                 $old_content =~ s{'}{\\'}g;
             
                 my $new_content = "'" . $old_content . "'";
             
                 $bareword->insert_after(
                     PPI::Token::Quote::Single->new($new_content)
                 );
                 $bareword->delete;
            }
        }
        $token = $token->snext_sibling;
    }

    return $self->transformation( $DESC, $EXPL, $elem );
}

1;

#-----------------------------------------------------------------------------

__END__

=pod

=head1 NAME

Perl::ToPerl6::Transformer::Variables::QuoteHashKeys - Transform bareword hash keys into quoted hash keys


=head1 AFFILIATION

This Transformer is part of the core L<Perl::ToPerl6|Perl::ToPerl6>
distribution.


=head1 DESCRIPTION

Anything enclosed in braces should be compilable code in Perl6, and unfortunately bareword hash keys such as C<%foo{a}> are interpreted as C<%foo{a()}>, so when the function a() can't be found, the block fails to compile:

  %foo{a} --> %foo{'a'}
  %foo{'a'} --> %foo{'a'}

The transformer also supports a C<perl6_mode> option, which replaces C<%foo{a}> with C<< %foo<a> >> style "pointy blocks". The default, though, is to a more perl5ish style.

Transforms variables outside of comments, heredocs, strings and POD.

=head1 CONFIGURATION

This Transformer is not configurable except for the standard options.

=head1 AUTHOR

Jeffrey Goff <drforr@pobox.com>

=head1 COPYRIGHT

Copyright (c) 2015 Jeffrey Goff

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

##############################################################################
# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab shiftround :
