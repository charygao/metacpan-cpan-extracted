use 5.006;
use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::Compile 2.054

use Test::More;

plan tests => 9 + ($ENV{AUTHOR_TESTING} ? 1 : 0);

my @module_files = (
    'MarpaX/Role/Parameterized/ResourceIdentifier.pm',
    'MarpaX/Role/Parameterized/ResourceIdentifier/BNF.pm',
    'MarpaX/Role/Parameterized/ResourceIdentifier/Impl/Segment.pm',
    'MarpaX/Role/Parameterized/ResourceIdentifier/Impl/_top.pm',
    'MarpaX/Role/Parameterized/ResourceIdentifier/MarpaTrace.pm',
    'MarpaX/Role/Parameterized/ResourceIdentifier/Role/_common.pm',
    'MarpaX/Role/Parameterized/ResourceIdentifier/Role/_generic.pm',
    'MarpaX/Role/Parameterized/ResourceIdentifier/Setup.pm',
    'MarpaX/Role/Parameterized/ResourceIdentifier/Types.pm'
);



# fake home for cpan-testers
use File::Temp;
local $ENV{HOME} = File::Temp::tempdir( CLEANUP => 1 );


my $inc_switch = -d 'blib' ? '-Mblib' : '-Ilib';

use File::Spec;
use IPC::Open3;
use IO::Handle;

open my $stdin, '<', File::Spec->devnull or die "can't open devnull: $!";

my @warnings;
for my $lib (@module_files)
{
    # see L<perlfaq8/How can I capture STDERR from an external command?>
    my $stderr = IO::Handle->new;

    my $pid = open3($stdin, '>&STDERR', $stderr, $^X, $inc_switch, '-e', "require q[$lib]");
    binmode $stderr, ':crlf' if $^O eq 'MSWin32';
    my @_warnings = <$stderr>;
    waitpid($pid, 0);
    is($?, 0, "$lib loaded ok");

    shift @_warnings if @_warnings and $_warnings[0] =~ /^Using .*\bblib/
        and not eval { require blib; blib->VERSION('1.01') };

    if (@_warnings)
    {
        warn @_warnings;
        push @warnings, @_warnings;
    }
}



is(scalar(@warnings), 0, 'no warnings found')
    or diag 'got warnings: ', ( Test::More->can('explain') ? Test::More::explain(\@warnings) : join("\n", '', @warnings) ) if $ENV{AUTHOR_TESTING};


