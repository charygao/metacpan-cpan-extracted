use strict;
use warnings;
use Test::More;

# generated by Dist::Zilla::Plugin::Test::PodSpelling 2.007005
use Test::Spelling 0.12;
use Pod::Wordlist;


add_stopwords(<DATA>);
all_pod_files_spelling_ok( qw( examples lib script t xt ) );
__DATA__
Daniel
David
Etheridge
Gavin
Haigh
Ishigaki
Karen
Kenichi
Kwalitee
Nathan
Perrett
Sherlock
Steinbrunner
Test
Znet
Zoffix
chromatic
cpan
dsteinbrunner
ether
irc
ishigaki
kwalitee
lib
nathanhaigh
perrettdl
script
sherlock
