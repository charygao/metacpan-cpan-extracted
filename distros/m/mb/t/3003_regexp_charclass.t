# This file is encoded in Shift_JIS.
die "This file is not encoded in Shift_JIS.\n" if 'あ' ne "\x82\xA0";
die "This script is for perl only. You are using $^X.\n" if $^X =~ /jperl/i;

use strict;
use FindBin;
use lib "$FindBin::Bin/../lib";
use mb;
mb::set_script_encoding('sjis');
use vars qw(@test);

@test = (
    sub { eval mb::parse(<<'END'); }, # test no 1
'ABC' =~ /A([ABC])C/;
END
    sub { eval mb::parse(<<'END'); }, # test no 2
'ABC' =~ /A([ABC])C/; $1 eq 'B';
END
    sub { eval mb::parse(<<'END'); }, # test no 3
'あいう' =~ /あ([あいう])う/;
END
    sub { eval mb::parse(<<'END'); }, # test no 4
'あいう' =~ /あ([あいう])う/; $1 eq 'い';
END
    sub { eval mb::parse(<<'END'); }, # test no 5
'ABC' !~ /A([^ABC])C/;
END
    sub { eval mb::parse(<<'END'); }, # test no 6
'あいう' !~ /あ([^あいう])う/;
END
    sub { eval mb::parse(<<'END'); }, # test no 7
'ABC' !~ /A([XYZ])C/;
END
    sub { eval mb::parse(<<'END'); }, # test no 8
'あいう' !~ /あ([かきく])う/;
END
    sub { eval mb::parse(<<'END'); }, # test no 9
'ABC' =~ /A([^XYZ])C/;
END
    sub { eval mb::parse(<<'END'); }, # test no 10
'ABC' =~ /A([^XYZ])C/; $1 eq 'B';
END
    sub { eval mb::parse(<<'END'); }, # test no 11
'あいう' =~ /あ([^かきく])う/;
END
    sub { eval mb::parse(<<'END'); }, # test no 12
'あいう' =~ /あ([^かきく])う/; $1 eq 'い';
END
    sub { eval mb::parse(<<'END'); }, # test no 13
'あいう' =~ /い/;
END
    sub { eval mb::parse(<<'END'); }, # test no 14
'ABC' =~ /abc/i;
END
    sub { eval mb::parse(<<'END'); }, # test no 15
'abc' =~ /ABC/i;
END
    sub { eval mb::parse(<<'END'); }, # test no 16
'ア' !~ /A/;
END
    sub { eval mb::parse(<<'END'); }, # test no 17
'ア' !~ /A/i;
END
    sub { eval mb::parse(<<'END'); }, # test no 18
'ア' !~ /a/;
END
    sub { eval mb::parse(<<'END'); }, # test no 19
'ア' !~ /a/i;
END
    sub { eval mb::parse(<<'END'); }, # test no 20
'ヂ' !~ /A/;
END
    sub { eval mb::parse(<<'END'); }, # test no 21
'ヂ' !~ /A/i;
END
    sub { eval mb::parse(<<'END'); }, # test no 22
'ヂ' !~ /a/;
END
    sub { eval mb::parse(<<'END'); }, # test no 23
'ヂ' !~ /a/i;
END
);

$|=1; print "1..",scalar(@test),"\n"; my $testno=1; sub ok { print $_[0]?'ok ':'not ok ',$testno++,$_[1]?" - $_[1]\n":"\n" } ok($_->()) for @test;

__END__
