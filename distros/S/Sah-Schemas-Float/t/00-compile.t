use 5.006;
use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::Compile 2.058

use Test::More;

plan tests => 27 + ($ENV{AUTHOR_TESTING} ? 1 : 0);

my @module_files = (
    'Data/Sah/Coerce/perl/To_float/From_str/as_percent.pm',
    'Data/Sah/Coerce/perl/To_float/From_str/share.pm',
    'Sah/Schema/inf.pm',
    'Sah/Schema/int_or_inf.pm',
    'Sah/Schema/nan.pm',
    'Sah/Schema/negfloat.pm',
    'Sah/Schema/neginf.pm',
    'Sah/Schema/percent.pm',
    'Sah/Schema/posfloat.pm',
    'Sah/Schema/posinf.pm',
    'Sah/Schema/posint_or_posinf.pm',
    'Sah/Schema/share.pm',
    'Sah/Schema/ufloat.pm',
    'Sah/Schema/uint_or_posinf.pm',
    'Sah/SchemaR/inf.pm',
    'Sah/SchemaR/int_or_inf.pm',
    'Sah/SchemaR/nan.pm',
    'Sah/SchemaR/negfloat.pm',
    'Sah/SchemaR/neginf.pm',
    'Sah/SchemaR/percent.pm',
    'Sah/SchemaR/posfloat.pm',
    'Sah/SchemaR/posinf.pm',
    'Sah/SchemaR/posint_or_posinf.pm',
    'Sah/SchemaR/share.pm',
    'Sah/SchemaR/ufloat.pm',
    'Sah/SchemaR/uint_or_posinf.pm',
    'Sah/Schemas/Float.pm'
);



# no fake home requested

my @switches = (
    -d 'blib' ? '-Mblib' : '-Ilib',
);

use File::Spec;
use IPC::Open3;
use IO::Handle;

open my $stdin, '<', File::Spec->devnull or die "can't open devnull: $!";

my @warnings;
for my $lib (@module_files)
{
    # see L<perlfaq8/How can I capture STDERR from an external command?>
    my $stderr = IO::Handle->new;

    diag('Running: ', join(', ', map { my $str = $_; $str =~ s/'/\\'/g; q{'} . $str . q{'} }
            $^X, @switches, '-e', "require q[$lib]"))
        if $ENV{PERL_COMPILE_TEST_DEBUG};

    my $pid = open3($stdin, '>&STDERR', $stderr, $^X, @switches, '-e', "require q[$lib]");
    binmode $stderr, ':crlf' if $^O eq 'MSWin32';
    my @_warnings = <$stderr>;
    waitpid($pid, 0);
    is($?, 0, "$lib loaded ok");

    shift @_warnings if @_warnings and $_warnings[0] =~ /^Using .*\bblib/
        and not eval { +require blib; blib->VERSION('1.01') };

    if (@_warnings)
    {
        warn @_warnings;
        push @warnings, @_warnings;
    }
}



is(scalar(@warnings), 0, 'no warnings found')
    or diag 'got warnings: ', ( Test::More->can('explain') ? Test::More::explain(\@warnings) : join("\n", '', @warnings) ) if $ENV{AUTHOR_TESTING};


