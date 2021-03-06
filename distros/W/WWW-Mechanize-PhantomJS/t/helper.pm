package # hide from CPAN indexer
    t::helper;
use strict;
use Test::More;
use File::Glob qw(bsd_glob);
use Config '%Config';
use File::Spec;
use Time::HiRes qw( time sleep );
use Carp qw(croak);

delete $ENV{HTTP_PROXY};
delete $ENV{HTTPS_PROXY};

sub browser_instances {
    my ($filter) = @_;
    $filter ||= qr/^/;
    my @instances;
    # default PhantomJS instance
    my ($default)=
        map { my $exe= File::Spec->catfile($_,"phantomjs$Config{_exe}");
              -x $exe ? $exe : ()
            } File::Spec->path();
    push @instances, $default
        if $default;

    # add author tests with local versions
    my $spec = $ENV{TEST_WWW_MECHANIZE_PHANTOMJS_VERSIONS}
             || 'phantomjs-versions/*/{*/,}phantomjs*$Config{_exe}'; # sorry, likely a bad default
    push @instances, sort {$a cmp $b} grep { -x } bsd_glob $spec;

    # Consider filtering for unsupported PhantomJS versions here

    grep { ($_ ||'') =~ /$filter/ } @instances;
};

sub default_unavailable {
    !scalar browser_instances
};

sub run_across_instances {
    my ($instances, $port, $new_mech, $test_count, $code) = @_;

    croak "No test count given"
        unless $test_count;

    for my $browser_instance (@$instances) {
        if ($browser_instance) {
            note sprintf "Testing with %s",
                $browser_instance;
        };
        my @launch = $browser_instance
                   ? ( launch_exe => $browser_instance,
                       #port => $port
                     )
                   : ();

        my $mech = eval { $new_mech->(@launch) };

        if( ! $mech ) {
            SKIP: {
                skip "Couldn't create new object: $@", $test_count;
            };
            my $version = eval {
                WWW::Mechanize::PhantomJS::phantomjs_version({
                    launch_exe => $browser_instance
                });
            };
            note sprintf "PhantomJS version '%s'", $version;
            next
        };

        note sprintf "PhantomJS version '%s', ghostdriver version '%s'",
            $mech->phantomjs_version, $mech->ghostdriver_version;

        # Run the user-supplied tests
        $code->($browser_instance, $mech);

        # Quit in 500ms, so we have time to shut our socket down
        my $pid = $mech->{pid};
        undef $mech;

        my $timeout = time + 2;
        while( kill 0 => $pid and time < $timeout ) {
            sleep 0.1; # So the browser can shut down before we try to connect
        };
        # to the new instance
    };
};

1;
