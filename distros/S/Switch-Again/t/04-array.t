use Test::More;

use Switch::Again qw/all/;

my $switch = switch(
	[qw/a b c d/] => sub {
		return 1;
	},
	[{ a => 'b', c => 'd' }] => sub {
		return 2;
	},
	[['a'], ['b'], ['c']] => sub {
		return 3;
	},
	'default' => sub {
		return 4;
	}
);
my $val = $switch->([qw/a b c d/]);
=pod
is ($val, 1);
$val = $switch->([{ a => 'b', c => 'd' }]);
is ($val, 2);
$val = $switch->([['a'], ['b'], ['c']]);
is ($val, 3);
=cut
$val = $switch->('d');
is ($val, 4);
=pod
$val = switch([qw/a b c d/], 
	[qw/a b c d/] => sub {
		return 1;
	},
	'default' => sub {
		return 4;
	}
);

is ($val, 1);

$val = $switch->([qw/a b c d/]);
is ($val, 1);
$val = $switch->([{ a => 'b', c => 'd' }]);
is ($val, 2);
$val = $switch->([['a'], ['b'], ['c']]);
is ($val, 3);
$val = $switch->('d');
is ($val, 4);
=cut
done_testing();
