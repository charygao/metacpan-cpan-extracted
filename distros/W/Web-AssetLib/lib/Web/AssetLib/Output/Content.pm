package Web::AssetLib::Output::Content;

use Moo;
use Types::Standard qw/Str/;

extends 'Web::AssetLib::Output';

has 'content' => (
    is       => 'rw',
    isa      => Str,
    required => 1
);

1;

=pod
 
=encoding UTF-8
 
=head1 NAME

Web::AssetLib::Output::Content - output generated by L<Web::AssetLib::OutputEngine::String>

=head1 SEE ALSO

L<Web::AssetLib::OutputEngine::String>
L<Web::AssetLib::Output::Link>

=head1 AUTHOR
 
Ryan Lang <rlang@cpan.org>

=cut
