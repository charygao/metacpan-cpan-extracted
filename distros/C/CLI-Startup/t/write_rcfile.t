# Test writing of RC files

use File::Compare 'compare';
use Test::Exit;
use Test::More;
use Test::Trap;
use Test::Exception;

use File::Copy;
use Data::Dumper;

eval "use CLI::Startup";
plan skip_all => "Can't load CLI::Startup" if $@;

use Cwd;

# Create a temp directory
my $dir    = getcwd();
my $tmp    = "$dir/tmp.$$";
my $rcfile = "$tmp/rcfile.$$";
mkdir $tmp;

# Identify the supported formats:
my $libs = {
    ini  => 'Config::INI::Writer',
    xml  => 'XML::Simple',
    json => 'JSON::MaybeXS',
    yaml => 'YAML::Any',
    perl => 'Data::Dumper',
};

# Build a fairly complex config file structure,
# with extra data beyond the command line options.
my $config = {
    default => {
        boolean   => 1,
        negatable => 0,
        integer   => 25,
        float     => 1.25,
        string    => 'Nobody expects the Spanish inquisition!',
        array     => [qw{ red yellow pink green purple orange blue }],
        hash      => { x => 1, y => 1, z => 1, },
    },
    extras  => {
        string    => 'Supporting data for the app',
        array     => [qw{ a handy list of things }],
        deep      => {
            string => 'A deep data structure!',
            deeper => {
                string  => 'A deeper data structure!',
                deepest => {
                    string => 'The deepest data structure yet!',
                    home   => 'Yellow submarine',
                },
            },
        },
    },
};

# Save this to a Perl-based RC file, so our app object can slurp it up.
$Data::Dumper::Terse = 1;
open RC, ">", $rcfile or
    plan skip_all => "Couldn't create $rcfile: $!";
print RC "# This is a manually created file\n" or
    plan skip_all => "Couldn't write $rcfile: $!";
print RC Dumper($config) or
    plan skip_all => "Couldn't write $rcfile: $!";
close RC or
    plan skip_all => "Couldn't close $rcfile: $!";

# Define an optspec matching the above data structure.
my $defaults = $config->{default};
my $options  = {
    rcfile   => $rcfile,
    defaults => $defaults,
    options  => {
        'boolean'       => 'A flag',
        'negatable!'    => 'A negatable flag',
        'integer=i'     => 'An integer option',
        'float=f'       => 'A floating-point option',
        'string=s'      => 'A string option',
        'array=s@'      => 'An array option',
        'hash=s%'       => 'A hash option',
    },
};

# Initialize an app object for which the defaults match the
# current settings.
my $app = CLI::Startup->new($options);
lives_ok { $app->init } "Loaded perl-format rc file.";
is_deeply $app->get_config, $config, "Contents of rc file are correct.";

# Make a backup of the rc file.
ok move($rcfile, "$rcfile.orig"), "Wrote backup of original perl-format RC file";

# Now create a new config file for each file type, if available, and test
# that it matches expectations.
for my $format ( sort keys %$libs )
{
    SKIP: {
        eval "use $libs->{$format}";
        skip( "Skipping $format format: $libs->{$format} is not installed", 1 ) if $@;

        # Restore from backup
        ok copy("$rcfile.orig", $rcfile), "Copied original perl-format RC file.";

        # Load the file
        eval {
            local @ARGV = ( '--rcfile', $rcfile, '--rcfile-format', $format, '--write-rcfile' );
            my $app1 = CLI::Startup->new($options);

            exits_zero { $app1->init } "Wrote ${format}-format rc file.";
            is_deeply $app1->get_config, $config, "Settings are correct.";
        };

        ok compare($rcfile, "$rcfile.orig") == 1, "File contents have changed."
            or system "cat $rcfile";

        # Load it a second time
        my $config2;
        {
            local @ARGV = ();
            my $app2 = CLI::Startup->new($options);

            lives_ok { $app2->init } "Read ${format}-format rc file.";
            $config2 = $app2->get_config;
        }

        # Ini files don't support deep structure, except for our enhancements
        # for array and hash command-line options. Cheat by forcing the "extras"
        # to match.
        if ( $format eq 'ini' )
        {
            $config2->{extras} = $config->{extras}
        }

        is_deeply $config2, $config, "Settings are correct again.";
    }
}



# Clean up
unlink $_ for glob("$tmp/*");
rmdir "$tmp";

done_testing();
