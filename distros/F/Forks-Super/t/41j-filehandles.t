use Forks::Super qw(:test overload);
use Test::More tests => 26;
use strict;
use warnings;

my $pid = fork {
    child_fh => 'in,out',
    sub => sub {
	print STDOUT "hELLO\n";
	sleep 4;
	print STDOUT "wORLD\n";
	sleep 4;
	print STDOUT "abc\n123\n";
    }
};

ok(isValidPid($pid), "$$\\job launched");
sleep 2;
my $t = Time::HiRes::time();
my $y = $pid->read_stdout();
$t = Time::HiRes::time() - $t;
ok($y eq "hELLO\n", "\$obj->read_stdout() ok");
okl($t <= 3.05, "fast return [1] ${t}s expected <=1s"); ### 3 ### was 1,obs 3.03

$t = Time::HiRes::time();
my $z = $pid->read_stdout();
$t = Time::HiRes::time() - $t;
ok($z eq '', "\$obj->read_stdout() empty while waiting")
    or diag("Got '$z', expected empty");
okl($t <= 1, "fast return [2] ${t}s expected <= 1s");

$t = Time::HiRes::time();
# TODO with $] >= 5.018:  test <$pid> in list context.
$z = $] >= 5.008008 ? <$pid> : $pid->read_stdout();
$t = Time::HiRes::time() - $t;
ok($z eq '', "<\$obj> empty while waiting");
okl($t <= 1, "fast return [3] ${t}s expected <= 1s");
sleep 4;

$t = Time::HiRes::time();
$_ = $] >= 5.008008 ? <$pid> : $pid->read_stdout();
$t = Time::HiRes::time() - $t;
ok($_ eq "wORLD\n", "while (<\$obj>) auto-assign to \$_")
    or diag("got '$_', expected 'wORLD\n'");
okl($t <= 1.3, "fast return [4] ${t}s expected <= 1s");    ### 9 ### obs 1.28

$t = Time::HiRes::time();
$z = $pid->read_stdout(block => 1);
$t = Time::HiRes::time() - $t;
ok($z eq "abc\n", "blocking \$obj->read_stdout() ok");
okl($t >= 1.35, "blocking read took ${t}s expected ~4s");  ### 11 ### obs 1.41

$t = Time::HiRes::time();
$z = $] >= 5.008008 ? <$pid> : $pid->read_stdout();
$t = Time::HiRes::time() - $t;
ok($z eq "123\n", "<\$pid> ok");
okl($t <= 1, "fast return [5] ${t}s expected <= 1s");
waitall;

for (1 .. 4) {
    $z = $] >= 5.008008 ? <$pid> : $pid->read_stdout();
    last if !defined $z;
    sleep 2;
}

ok(!defined($z), "<\$pid> undef on empty stream")          ### 14 ###
  or diag("\$z was \"$z\"");

################# repeat, with blocking #############

$pid = fork {
    child_fh => 'in,out,block',
    sub => sub {
	print STDOUT "hELLO\n";
	sleep 4;
	print STDOUT "wORLD\n";
	sleep 4;
	print STDOUT "abc\n123\n";
    }
};

ok(isValidPid($pid), "$$\\job launched");
sleep 1;
$t = Time::HiRes::time();
$y = $pid->read_stdout();
$t = Time::HiRes::time() - $t;
ok($y eq "hELLO\n", "\$obj->read_stdout() ok");
okl($t <= 1, "fast return [11] ${t}s expected <=1s");   ### 17 ###

$t = Time::HiRes::time();
$y = $pid->read_stdout(block => 0);
$t = Time::HiRes::time() - $t;
ok($y eq '', "\$obj->read_stdout(), no block empty while waiting");
okl($t <= 1, "fast return [12] ${t}s expected <=1s");

$t = Time::HiRes::time();
$z = $] >= 5.008008 ? <$pid> : $pid->read_stdout();
$t = Time::HiRes::time() - $t;
ok($z eq "wORLD\n", "<\$obj> ok");
okl($t >= 2.0, "block return took ${t}s, expected ~4s");

$t = Time::HiRes::time();
$_ = $] >= 5.008008 ? <$pid> : $pid->read_stdout();

$t = Time::HiRes::time() - $t;
ok($_ eq "abc\n", "while (<\$obj>) auto-assign to \$_");
okl($t >= 2.0, "block return [2] took ${t}s, expected ~4s");

$t = Time::HiRes::time();
$z = $] >= 5.008008 ? <$pid> : $pid->read_stdout();
$t = Time::HiRes::time() - $t;
ok($z eq "123\n", "<\$pid> ok");
okl($t <= 1, "fast return [5] ${t}s expected <= 1s");
waitall;

$z = $] >= 5.008008 ? <$pid> : $pid->read_stdout();
if (defined $z) {
    sleep 5;
    $z = $] >= 5.008008 ? <$pid> : $pid->read_stdout();
}
ok(!defined($z), "<\$pid> undef on empty stream")
    or diag("\$z was \"$z\"");
