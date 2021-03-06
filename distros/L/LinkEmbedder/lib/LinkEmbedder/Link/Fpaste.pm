package LinkEmbedder::Link::Fpaste;
use Mojo::Base 'LinkEmbedder::Link::Basic';

has provider_name => 'Fedoraproject';
has provider_url  => sub { Mojo::URL->new('https://fedoraproject.org/') };

sub learn_p {
  my $self = shift;
  my $url  = $self->url->to_string;
  my @promises;

  $url =~ s![^\w-]+$!!;
  push @promises, $self->SUPER::learn_p;
  push @promises, $self->_get_p(Mojo::URL->new("$url/raw"))->then(sub { $self->_parse_fpaste(shift) })
    if $url =~ m!/paste/([^/]+)$!;

  return $promises[0] if @promises == 1;
  return Mojo::Promise->all(@promises)->then(sub { $_[0]->[0] });
}

sub _parse_fpaste {
  my ($self, $tx) = @_;
  $self->{paste} = $tx->res->body;
  $self->template->[1] = 'paste.html.ep';
  return $self->type('rich');
}

1;
