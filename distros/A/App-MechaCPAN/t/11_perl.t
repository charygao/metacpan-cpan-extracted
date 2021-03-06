use strict;
use FindBin;
use Test::More;
use Cwd qw/cwd/;
use File::Temp qw/tempdir/;

require q[./t/helper.pm];

if ( $^O eq 'MSWin32' )
{
  plan skip_all => 'Cannot build perl on Win32';
}

my $pwd = cwd;
my $tmpdir = tempdir( TEMPLATE => File::Spec->tmpdir . "/mechacpan_t_XXXXXXXX", CLEANUP => 1 );
chdir $tmpdir;
my $dir = cwd;

*App::MechaCPAN::logmsg = sub
{
  Test::More::diag(@_);
};

is(
  App::MechaCPAN::main(
    'perl',
    "$FindBin::Bin/../test_dists/FakePerl-5.12.0.tar.gz"
  ),
  0,
  'Can install "perl" from a tar.gz'
);

chdir $pwd;
done_testing;
