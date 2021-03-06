use strict;
use warnings;
use ExtUtils::MakeMaker;
use Config;

our ($hdf_include_path, $hdf_lib_path, $hdf_libs, $szip);

my $msg = "";
my $forcebuild=0;

if (defined $PDL::Config{WITH_HDF} && $PDL::Config{WITH_HDF}==0) {
    $msg = "\n   Will skip build of PDL::IO::HDF on this system   \n";
    goto skip;
}

if (defined $PDL::Config{WITH_HDF} && $PDL::Config{WITH_HDF}==1) {
    print "\n   Will forcibly try and build PDL::IO::HDF on this system   \n\n";
    $forcebuild=1;
}

($hdf_include_path, $hdf_lib_path, $hdf_libs, $szip, my $hdf_defs, $msg) = get_hdf_info($msg);

sub get_hdf_info {
    my ($msg) = @_;
    my ($hdf_include_path, $hdf_lib_path, $hdf_libs, $szip, $hdf_defs);
    # Look for HDF4 includes/libs
    # default locations:
    my @HDF_lib_locations = (
        '/usr/lib64',
        '/usr/local/netcdf/lib',
        '/usr/local/lib',
        '/usr/local/lib64',
        '/usr/lib64/hdf',
        '/opt/local/lib',
        '/usr/lib',
        '/usr/lib/hdf',
        '/opt/lib',
        split(/ /, $Config{libpth}),
    );
    my @HDF_inc_locations = (
        '/usr/local/include',
        '/usr/local/netcdf/include',
        '/opt/local/include',
        '/usr/include',
        '/usr/include/hdf',
        '/opt/include',
        $Config{usrinc},
    );

    # get locations from perldl.conf, if specified there:
    @HDF_lib_locations = @{$PDL::Config{HDF_LIBS}}
        if( defined $PDL::Config{HDF_LIBS} );
    @HDF_inc_locations = @{$PDL::Config{HDF_INC}}
        if( defined $PDL::Config{HDF_INC} );

    #
    # Do the search:
    #
    my $found_df = 0;
    my $found_sz = 0;

    # Look for the libs:
    foreach my $libdir ( @HDF_lib_locations ) {
        if (-e "$libdir/libdfalt.a" && !$found_df) {
            $found_df = 1;
            $hdf_lib_path = $libdir;
                        $hdf_libs = '-lmfhdfalt -ldfalt';
            print "Found libdfalt.a at $libdir/libdfalt.a\n";
        }

        if (-e "$libdir/libdf.a" && !$found_df) {
            $found_df = 1;
            $hdf_lib_path = $libdir;
                        $hdf_libs = '-lmfhdf -ldf';
            print "Found libdf.a at $libdir/libdf.a\n";
        }

        if (-e "$libdir/libhdf.a" && !$found_df) {
            $found_df = 1;
            $hdf_lib_path = $libdir;
            $hdf_libs = '-lmfhdf -lhdf -lxdr';
            print "Found libhdf.a at $libdir/libhdf.a\n";
        }

        # Look for the szip library, which HDF >= 4.2r0 needs, but older versions don't!

        if (-e "$libdir/libsz.$Config{so}" && !$found_sz) {
            $found_sz = 1;
            print "Found libsz.$Config{so} at $libdir/libsz.$Config{so}\n";
        }

        if (-e "$libdir/libsz$Config{lib_ext}" && !$found_sz) {
            $found_sz = 1;
            print "Found libsz.$Config{lib_ext} at $libdir/libsz.$Config{lib_ext}\n";
        }
    } # foreach $libdir...

    unless( defined( $hdf_lib_path ) ) {
        $msg .= "Cannot find hdf library, libdf.a.\n"
              . "Please add the correct library path to Makefile.PL or install HDF\n";
    }

    warn "Warning: Did not find libsz, necessary for HDF >= 4.2r0\n" unless $found_sz;
    $szip = $found_sz ? "-lsz" : "";

    # Look for the include files:
    foreach my $incdir ( @HDF_inc_locations ) {
        if (-e "$incdir/hdf.h") {
            $hdf_include_path = ($incdir eq '/usr/local/include' ) ? "" : $incdir;
            print "Found hdf.h at $incdir/hdf.h\n";
            last;
        }
    }

    unless( defined( $hdf_include_path ) ) {
        $msg .= "Cannot find hdf header file, hdf.h.\n"
              . "Please add the correct library path to Makefile.PL or install HDF\n";
    }

    # Set up architecture dependent stuff:
    # NOTE TO SELF: The main PDL developers may not like this...
    my $cpu = `uname -m`;
    chomp $cpu;
    if ($cpu eq 'x86_64') {
        $hdf_defs = "-DSWAP -DNDEBUG -DHDF -DBIG_LONGS -DIA64 " .
                    "-D_BSD_SOURCE -DLINUX -DGCC32";
    } elsif ($cpu eq 'i686') {
        $hdf_defs = "-DNDEBUG -D_BSD_SOURCE -DLINUX -DGCC32";
    } else {
        print "WARNING: Unknown cpu type $cpu! Not setting \$hdf_defs. (This may not be a bad thing)\n";
    }
    print "Final \$hdf_defs flags: \'$hdf_defs\'\n\n";
    return (
        $hdf_include_path,
        $hdf_lib_path,
        $hdf_libs,
        $szip,
        $hdf_defs,
        $msg,
    );
}

# Make sure everything we wanted is found:
my $donot = 1;
if( defined( $hdf_include_path ) && defined( $hdf_lib_path ) ) {
    $donot = 0;
}

if ( $donot ) {
    $msg .= "\n Skipping build of PDL::IO::HDF.\n";
}

skip:

if ($msg ne "" && $forcebuild==0) {
    write_dummy_make( $msg );
    $donot = 1;
    $PDL::Config{WITH_HDF}=0;
} else {
    $PDL::Config{WITH_HDF}=1;
    print "\n   Building PDL::IO::HDF. Turn off WITH_HDF if there are any problems\n\n";
}

return if $donot;

WriteMakefile(
    NAME => 'PDL::IO::HDF',
    DEFINE => $hdf_defs,
    #OPTIMIZE => "$hdf_defs",
    VERSION_FROM => 'HDF.pm',
    TYPEMAPS => [ &PDL_TYPEMAP() ],
    PM => {
        'HDF.pm' => '$(INST_LIBDIR)/HDF.pm',
    },
    INC => &PDL_INCLUDE() . " -I$hdf_include_path",
    LIBS => [ "-L$hdf_lib_path $hdf_libs -ljpeg -lz $szip" ],
    dist => {
        COMPRESS => 'gzip',
        SUFFIX => 'gz',
    },
    DIR => [ 'SD', 'VS' ],
    (eval ($ExtUtils::MakeMaker::VERSION) >= 6.57_02 ? ('NO_MYMETA' => 1) : ()),
);
