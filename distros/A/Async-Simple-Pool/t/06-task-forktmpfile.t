#!perl -T

use Modern::Perl;
use POSIX;
use Test::Spec;
use Test::Exception;
use Time::HiRes qw/ sleep /;

plan tests => 21;

# use lib '../lib';

use Async::Simple::Task::ForkTmpFile;

my $task;
my $timeout    = 1;
my $sub        = sub { sleep $timeout; return $_[0]-1  };
my $sub_scalar = sub { return $_[0]+1                  };
my $sub_hash   = sub { return { y => $_[0]->{x}+1 }    };
my $sub_array  = sub { return [ reverse @{ $_[0] } ]   };

describe 'All' => sub {

    describe 'init data' => sub {

#         it 'init errors' => sub {
#             # Create a fork process, which will wait for data and execute &$sub if data will be passed
#             ok( ! eval{ Async::Simple::Task::ForkTmpFile->new( ) } && $@, 'no params' );
#             undef $@;
#             ok( ! eval{ Async::Simple::Task::ForkTmpFile->new( task => 1234 ) } && $@, 'bad params' );
#             undef $@;
#         };

        it 'init ok' => sub {
            my $task = Async::Simple::Task::ForkTmpFile->new( task => $sub, id => 12345 );
            my $pid = $task->pid;

            isa_ok( $task, 'Async::Simple::Task::ForkTmpFile', 'successful init.' );
            is( ref $task->reader, '', 'have scalar reader=' . $task->reader );
            is( ref $task->writer, '', 'have scalar writer=' . $task->writer );
            isa_ok( $task->task, 'CODE', 'task exists and is a CODE' );

            is( $task->timeout, 0.01, 'default timeout' );
            is( $task->id, 12345, 'id found' );
            ok( $task->pid =~ /^-?\d{2,}$/, 'fork done, pid setted' );
            is( $task->kill_on_exit, 1, 'default kill_on_exit' );
            ok( -d $task->tmp_dir, 'tmp directory exists:' . $task->tmp_dir );
            ok( -w $task->tmp_dir, 'tmp dir is writable' . $task->tmp_dir );
            is( waitpid( $task->pid, WNOHANG ), 0, 'kid is active' );
            undef $task;
            sleep 0.2;
            ok( waitpid( $pid, WNOHANG ) =~ /^-?\d{1,}$/, 'kid closed' ); # win: -1, linux: pid
        };

        it 'init params check' => sub {
            my $task = Async::Simple::Task::ForkTmpFile->new( task => $sub, timeout => 1, kill_on_exit => 0, tmp_dir => 'var_tmp' );
            is( $task->timeout, 1, 'timeout setted' );
            is( $task->tmp_dir, 'var_tmp', 'tmpdir setted to user`s' );
            is( $task->kill_on_exit, 0, 'kill_on_exit setted' );
            $task->kill_on_exit(1);
            undef $task;
        };
    };

    describe 'simple task' => sub {

        my $task;

        it 'init task' => sub {
            $task = Async::Simple::Task::ForkTmpFile->new( task => $sub );
            $task->put( 111 ); # Put a task to task
            isa_ok( $task->serializer, 'Data::Serializer' );
        };

        it 'no result' => sub {
            my $result = $task->get(); # Put a task to work
            is( $result, undef, 'kid doing his timeout' );
        };

        it 'has result after timeout' => sub {
            sleep $timeout * 2.5;
            my $result = $task->get(); # Put a task to task
            is( $result, 110, 'result ok' );
        };
    };

    describe 'any data type tasks' => sub {
        my $result;

        it 'scalar' => sub {
            $task = Async::Simple::Task::ForkTmpFile->new( task => $sub_scalar );
            $task->put( 111 ); # Put a task to task
            sleep $timeout;
            $result = $task->get(); # Put a task to task
            is( $result, 112, 'kid did his job for scalar' );
        };

        it 'hash' => sub {
            $task = Async::Simple::Task::ForkTmpFile->new( task => $sub_hash );
            $task->put( { x => 10 } ); # Put a task to task
            sleep $timeout;
            $result = $task->get(); # Put a task to task
            is_deeply( $result, { y => 11 }, 'kid did his job for hash' );
        };

        it 'array' => sub {
            $task = Async::Simple::Task::ForkTmpFile->new( task => $sub_array );
            $task->put( [ 10, 20 ] ); # Put a task to task
            sleep $timeout;
            $result = $task->get(); # Put a task to task
            is_deeply( $result, [ 20, 10 ], 'kid did his job for array' );
        };
    };
};

runtests unless caller;
