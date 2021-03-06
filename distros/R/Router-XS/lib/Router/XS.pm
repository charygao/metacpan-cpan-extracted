package Router::XS;
use Exporter 'import';

my @STD  = qw(check_route add_route);
my @REST = qw(get post put patch del head conn options any);
our @EXPORT_OK = (@STD, @REST);
our %EXPORT_TAGS = (std => \@STD, rest => \@REST, all => [@STD, @REST]);

our $VERSION = 0.02;

require XSLoader;
XSLoader::load();

sub get ($&) {
  add_route("GET/$_[0]", $_[1]);
}

sub post ($&) {
  add_route("POST/$_[0]", $_[1]);
}

sub put ($&) {
  add_route("PUT/$_[0]", $_[1]);
}

sub patch ($&) {
  add_route("PATCH/$_[0]", $_[1]);
}

sub del ($&) {
  add_route("DELETE/$_[0]", $_[1]);
}

sub head ($&) {
  add_route("HEAD/$_[0]", $_[1]);
}

sub conn ($&) {
  add_route("CONNECT/$_[0]", $_[1]);
}

sub options ($&) {
  add_route("OPTIONS/$_[0]", $_[1]);
}

sub any ($&) {
  add_route("*/$_[0]", $_[1]);
}

1;

=encoding utf8

=head1 NAME

Router::XS - Fast URI path to value lookup

=head1 SYNOPSIS

  use Router::XS ':all';

  my $user_home_page = sub  { ... };

  add_route('/user/*', $user_home_page);
  my ($sub, @captures) = check_route('/user/foobar');

  # or use HTTP method verbs to add routes
  get '/user/*' => sub { ... };

  my ($sub, @captures) = check_route('GET/user/foobar');

=head1 FUNCTIONS

=head2 add_route ($path, $sub)

Adds a new route associated with a subroutine to the router. Will C<die> if a
matching route has already been added. Accepts asterisks (C<*>) as wildcards
for captures. C<$path> may be prepended with an HTTP method:

  add_route('POST/some/path', $sub);

=head2 check_route ($path)

Checks a URI path against the added routes and returns C<undef> if no match is
found, otherwise returning the associated subroutine reference and any captures
from wildcards:

  my ($sub, @captures) = check_route('POST/some/path');

=head2 get/post/put/patch/del/head/conn/options/any

Sugar for C<add_route>: adds a route using C<$path> for the associated HTTP
method:

  put '/product/*' => sub { ... };

The C<any> function accepts any HTTP method. When an incoming request is
received, C<check_route> must still be called.

See the test file included in this distribution for further examples.

=head1 THREAD SAFETY

Router::XS is not thread safe: however if you add all routes at the startup of
an application under a single thread, and do not call C<add_route> thereafter,
it should be thread safe.

=head1 BENCHMARKS

On my machine Router::XS performs well against other fast Routers. The test
conditions add 200 routes, and then check how fast the router can match the
path '/interstitial/track':

                     Rate  Router::Boom  Router::R3  Router::XS
  Router::Boom   344536/s            --        -85%        -93%
  Router::R3    2235343/s          549%          --        -54%
  Router::XS    4860641/s         1311%        117%          --

=head2 DEPENDENCIES

This module uses L<uthash|http://troydhanson.github.com/uthash/> to build a
n-ary tree of paths. C<uthash> is a single C header file, included in this
distribution. uthash is copyright (c) 2003-2017, Troy D. Hanson.

=head1 INSTALLATION

  perl Makefile.PL
  make
  make test
  make install

=head1 AUTHOR

E<copy> 2017 David Farrell

=head1 LICENSE

The (two-clause) FreeBSD License

=head1 ACKNOWLEDGEMENTS

Thanks to L<ZipRecruiter|https://www.ziprecruiter.com> for letting their employees contribute to Open Source.

=head1 SEE ALSO

There are many routers on L<CPAN|https://metacpan.org/search?size=20&q=Router> including:

=over 4

=item * L<HTTP::Router>

=item * L<Path::Router>

=item * L<Router::Boom>

=item * L<Router::R3>

=back

=cut
