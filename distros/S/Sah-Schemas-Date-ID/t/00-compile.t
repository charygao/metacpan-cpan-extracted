use 5.006;
use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::Compile 2.058

use Test::More;

plan tests => 35 + ($ENV{AUTHOR_TESTING} ? 1 : 0);

my @module_files = (
    'Data/Sah/Coerce/perl/To_int/From_str/convert_en_or_id_dow_name_to_num.pm',
    'Data/Sah/Coerce/perl/To_int/From_str/convert_en_or_id_month_name_to_num.pm',
    'Data/Sah/Coerce/perl/To_int/From_str/convert_id_dow_name_to_num.pm',
    'Data/Sah/Coerce/perl/To_int/From_str/convert_id_month_name_to_num.pm',
    'Perinci/Sub/XCompletion/date_dow_num_en_or_id.pm',
    'Perinci/Sub/XCompletion/date_dow_num_id.pm',
    'Perinci/Sub/XCompletion/date_dow_nums_en_or_id.pm',
    'Perinci/Sub/XCompletion/date_dow_nums_id.pm',
    'Perinci/Sub/XCompletion/date_month_num_en_or_id.pm',
    'Perinci/Sub/XCompletion/date_month_num_id.pm',
    'Perinci/Sub/XCompletion/date_month_nums_en_or_id.pm',
    'Perinci/Sub/XCompletion/date_month_nums_id.pm',
    'Sah/Schema/date/dow_name/id.pm',
    'Sah/Schema/date/dow_num/en_or_id.pm',
    'Sah/Schema/date/dow_num/id.pm',
    'Sah/Schema/date/dow_nums/en_or_id.pm',
    'Sah/Schema/date/dow_nums/id.pm',
    'Sah/Schema/date/month/id.pm',
    'Sah/Schema/date/month_name/id.pm',
    'Sah/Schema/date/month_num/en_or_id.pm',
    'Sah/Schema/date/month_num/id.pm',
    'Sah/Schema/date/month_nums/en_or_id.pm',
    'Sah/Schema/date/month_nums/id.pm',
    'Sah/SchemaR/date/dow_name/id.pm',
    'Sah/SchemaR/date/dow_num/en_or_id.pm',
    'Sah/SchemaR/date/dow_num/id.pm',
    'Sah/SchemaR/date/dow_nums/en_or_id.pm',
    'Sah/SchemaR/date/dow_nums/id.pm',
    'Sah/SchemaR/date/month/id.pm',
    'Sah/SchemaR/date/month_name/id.pm',
    'Sah/SchemaR/date/month_num/en_or_id.pm',
    'Sah/SchemaR/date/month_num/id.pm',
    'Sah/SchemaR/date/month_nums/en_or_id.pm',
    'Sah/SchemaR/date/month_nums/id.pm',
    'Sah/Schemas/Date/ID.pm'
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


