use t::Helper;

plan skip_all => 'Reconnect is disabled';

my $port = Mojo::IOLoop::Server->generate_port;
my $core = $t->app->core;
my $conn;

redis_do(
  [hmset => 'user:doe',                            digest => 'E2G3goEIb8gpw', email => ''],
  [srem  => 'user:doe:connections',                "localhost:$port"],
  [hmset => "user:doe:connection:localhost:$port", nick   => 'doe',           host  => "localhost:$port"],
);

{
  $core->ctrl_start('doe', "localhost:$port");
  Mojo::IOLoop->start;
  ok $conn = $core->{connections}{"doe:localhost:$port"}, 'connection added';
  ok !$conn->_irc->{stream}, 'irc has no stream';
}

Mojo::IOLoop->server(
  {port => $port},
  sub {
    my ($ioloop, $stream) = @_;
    Mojo::IOLoop->timer(0.01 => sub { $stream->close });
  },
);

{
  no warnings 'redefine';
  $core->ctrl_start('doe', "localhost:$port");
  Mojo::IOLoop->start;
  ok !$conn->_irc->{stream}, 'irc has no stream';
}

{
  no warnings 'redefine';
  $core->ctrl_start('doe', "localhost:$port");
  Mojo::IOLoop->start;
}

done_testing;
