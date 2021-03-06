use 5.012;
use lib 't/lib';
use MyTest;
use Test::Catch;
use Net::SockAddr;

variate_catch('[tcp-connect]', qw/ssl buf/);

my $loop = UniEvent::Loop->default_loop;

subtest 'connect-diconnect' => sub {
    my $s = new UniEvent::Tcp;
    $s->bind_addr(SA_LOOPBACK_ANY);
    $s->listen;
    $s->connection_callback(sub {});
    my $sa = $s->sockaddr;
    
    my $cl = new UniEvent::Tcp;
    $cl->connect_addr($sa, sub {
        my ($handler, $err) = @_;
        fail $err if $err;
        pass "first connected";
    });
    $cl->write('1');
    $cl->disconnect;
    $cl->connect_addr($sa, sub {
        my ($handler, $err) = @_;
        fail $err if $err;
        pass "second connected";
        $loop->stop;
    });
    
    $loop->update_time;
    $loop->run;
    
    done_testing(2);
};

done_testing();
 