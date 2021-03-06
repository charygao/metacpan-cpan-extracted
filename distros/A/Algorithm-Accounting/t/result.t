#!/usr/bin/perl

use Test::More tests => 3;

use Algorithm::Accounting;

my $fields = [qw/id author file date/];
my $data = [
	    [1, 'alice', '/foo.txt', '2004-05-01' ],
	    [2, 'bob',   '/foo.txt', '2004-05-03' ],
	    [3, 'alice', '/foo.txt', '2004-05-04' ],
	    [4, 'john', '/foo.txt', '2004-05-04' ],
	   ];

my $acc = Algorithm::Accounting->new();

# give the object information
$acc->fields($fields);
$acc->append_data($data);

my $result = $acc->result;
ok($result->[0]->{1}==1);

my $author_result = $acc->result('author');
ok($author_result->{alice} == 2);

ok(1);

