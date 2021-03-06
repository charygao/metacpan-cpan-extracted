#!/usr/bin/env perl
use strict;
use warnings;

=head1 NAME

01-QMake-Project.t - test for QMake::Project

=cut

use FindBin;
use lib "$FindBin::Bin/../../..";

use QMake::Project;

use English qw(-no_match_vars);
use File::Spec::Functions;
use File::Which;
use File::chdir;
use Test::Exception;
use Test::More;
use Test::Warn;

my $TESTDATA = catfile( $FindBin::Bin, 'test_projects' );
my $QMAKE = find_qmake( );
my $ERROR_RE = qr/^QMake::Project:/;

sub run_qmake
{
    my ($args) = @_;
    if (!$args) {
        $args = "";
    }
    my $out = qx( $QMAKE $args 2>&1 );
    is( $?, 0, 'qmake ok' ) || diag( $out );
    ok( -f( 'Makefile' ), 'makefile was created' );
    return;
}

# Basic test of a typical application .pro file
sub test_typical
{
    my ($proj) = @_;
    my $dir = "$TESTDATA/01-typical";
    local $CWD = $dir;

    my $check = sub {
        my $initial_count = $proj->{ _qmake_count };
        is( $proj->values( 'TARGET' ), 'myapp' );
        is( $proj->values( 'SOURCES' ), 'main.cpp' );
        is( canonpath($proj->values( 'PWD' )), canonpath($dir) );
        is( $proj->{ _qmake_count } - $initial_count, 3 );
    };

    # first try with directory, then .pro file, then makefile

    if ($proj) {
        $proj->set_project_file( '.' );
    } else {
        $proj = QMake::Project->new( '.' );
    }
    $check->();

    $proj->set_project_file( '01-typical.pro' );
    $check->();

    run_qmake( );

    $proj->set_makefile( 'Makefile' );
    $check->();

    return;
}

# Test that the default set TARGET still remains (even though we
# used our own, differently-named .pro file)
sub test_default_target
{
    my ($proj) = @_;
    my $dir = "$TESTDATA/02-default-target";
    local $CWD = $dir;

    run_qmake( );

    # Check that we don't get messed up by any of make's environment
    # variables, which might be set if we are e.g. running via `make check'
    local $ENV{ MAKEFLAGS } = '-w -j3 -k';
    local $ENV{ MFLAGS } = $ENV{ MAKEFLAGS };
    local $ENV{ MAKELEVEL } = 1;

    if ($proj) {
        $proj->set_makefile( 'Makefile' );
    } else {
        $proj = QMake::Project->new( 'Makefile' );
    }

    my $initial_count = $proj->{ _qmake_count };
    is( $proj->values( 'TARGET' ), '02-default-target' );
    is( $proj->{ _qmake_count } - $initial_count, 1 );

    return;
}

# Test retrieving list values
sub test_list
{
    my ($proj) = @_;
    my $dir = "$TESTDATA/03-list";

    # Test being in a directory other than the project directory
    {
        local $CWD = $dir;
        run_qmake( );
    }

    if ($proj) {
        $proj->set_makefile( "$dir/Makefile" );
    } else {
        $proj = QMake::Project->new( "$dir/Makefile" );
    }

    # Order of QT is undefined
    my %expected_qt = map { $_ => 1 } qw(core gui network xmlpatterns);

    my $initial_count = $proj->{ _qmake_count };
    ok( $expected_qt{ $proj->values( 'QT' ) } );
    is_deeply( [ sort $proj->values( 'QT' ) ], [ sort keys %expected_qt ] );
    is( $proj->{ _qmake_count } - $initial_count, 2 );

    return;
}

# Test some delayed evaluation
sub test_delayed
{
    my ($proj) = @_;
    my $dir = "$TESTDATA/03-list";
    local $CWD = $dir;

    # Basic sanity check when qmake has extra args.
    run_qmake( '-spec default -nocache' );

    if ($proj) {
        $proj->set_makefile( 'Makefile' );
    } else {
        $proj = QMake::Project->new( 'Makefile' );
    }

    my $initial_count = $proj->{ _qmake_count };

    my $pro_file_pwd = $proj->values( '_PRO_FILE_PWD_' );
    my $uses_gui = $proj->test( 'contains(QT,gui)' );

    # Shouldn't have run qmake yet ...
    is( $proj->{ _qmake_count } - $initial_count, 0 );

    is( canonpath( $pro_file_pwd ), canonpath( $dir ) );
    is( $uses_gui, 1 );

    # Should have run just once due to the above
    is( $proj->{ _qmake_count } - $initial_count, 1 );

    my @qt = $proj->values( 'QT' );

    # And again, due to list
    is( $proj->{ _qmake_count } - $initial_count, 2 );

    # Order of QT is undefined
    is_deeply( [sort @qt], [ sort qw(core gui network xmlpatterns) ] );

    return;
}

# Test order of evaluation compared to default_post, CONFIG, etc.
sub test_ordering
{
    my ($proj) = @_;

    my $dir = "$TESTDATA/06-ordering";
    local $CWD = $dir;

    run_qmake( );

    if ($proj) {
        $proj->set_makefile( 'Makefile' );
    } else {
        $proj = QMake::Project->new( 'Makefile' );
    }

    my @DEFINES = $proj->values( 'DEFINES' );

    # If we correctly evaluate after default_post.prf and all CONFIG are
    # processed, then our setting of QT_NAMESPACE in our .pro file has
    # been transformed into a DEFINE.  Otherwise, it hasn't.
    is( grep( { $_ =~ qr/QT_NAMESPACE=QMake_Project/ } @DEFINES ), 1 )
        || diag "DEFINES: @DEFINES";

    return;
}

sub test_directory_resolution
{
    my ($proj) = @_;

    if (!$proj) {
        $proj = QMake::Project->new( );
    }

    $proj->set_project_file( "$TESTDATA/07-no-project-file" );
    my $loaded = $proj->values( 'loaded' );
    throws_ok( sub { $loaded = "$loaded" }, qr{could not resolve project file} );

    $proj->set_project_file( "$TESTDATA/08-different-named-project-file" );
    $loaded = $proj->values( 'loaded' );
    is( $loaded, 1 );

    $proj->set_project_file( "$TESTDATA/09-multiple-project-files" );
    $loaded = $proj->values( 'loaded' );
    is( $loaded, 2 );

    return;

}

# Test what happens when an error occurs somewhere
sub test_error
{
    my ($proj) = @_;
    my $dir = "$TESTDATA/04-error";
    local $CWD = $dir;

    my $qmake_args = q{};
    if ($OSNAME =~ m{linux}i) {
        $qmake_args = '-unix';
    }
    run_qmake( $qmake_args );

    # qmake worked the first time, but this environment
    # variable will force an error when we try to parse it.
    local $ENV{ FORCE_QMAKE_ERROR } = 'fake error';

    if ($proj) {
        $proj->set_makefile( 'Makefile' );
    } else {
        $proj = QMake::Project->new( 'Makefile' );
    }

    my $uses_gui = $proj->test( 'contains(QT,gui)' );
    throws_ok( sub { $uses_gui = "$uses_gui" }, $ERROR_RE );

    # If we set_die_on_error 0, this should become a warning.
    my $qt = $proj->values( 'QT' );
    $proj->set_die_on_error( 0 );

    warnings_like { "$qt" } [ $ERROR_RE, qr{Use of uninitialized value} ];

    my @qt;
    warning_like { @qt = $proj->values( 'QT' ) } $ERROR_RE;
    is( scalar(@qt), 0 );

    # Test that turning errors back on really works
    $proj->set_die_on_error( 1 );

    throws_ok( sub { diag( 'unix: '.$proj->test( 'unix' ) ) }, $ERROR_RE );

    return;
}

# Test spaces in path and value
sub test_spaces
{
    my ($proj) = @_;
    my $dir = "$TESTDATA/05 space in path";

    local $CWD = $dir;
    run_qmake( );

    if ($proj) {
        $proj->set_makefile( "$dir/Makefile" );
    } else {
        $proj = QMake::Project->new( "$dir/Makefile" );
    }

    my $initial_count = $proj->{ _qmake_count };
    is( $proj->values( 'TEMPLATE' ), 'app' );
    is( $proj->values( 'TARGET' ), '05 space in path' );
    is( canonpath( $proj->values( 'PWD' ) ), canonpath( $dir ) );
    is( canonpath( $proj->values( 'OUT_PWD' ) ), canonpath( $dir ) );
    is_deeply(
        [ $proj->values( 'SOURCES' ) ],
        [ 'main.cpp', 'space in source.cpp' ],
    );
    is( $proj->{ _qmake_count } - $initial_count, 5 );

    return;
}

# Test a few really basic error conditions, e.g. make itself can't work
sub test_make_error
{
    my ($proj) = @_;
    my $dir = "$TESTDATA/01-typical";
    local $CWD = $dir;

    run_qmake( );

    if ($proj) {
        $proj->set_makefile( undef );
    } else {
        $proj = QMake::Project->new( );
    }

    my $sub = sub{ my @qt = $proj->values( 'QT' ) };
    my $original_make = $proj->make( );

    # fail: no makefile set
    throws_ok(
        sub { $sub->() },   # weird syntax is necessary to satisfy prototype
        qr{$ERROR_RE no makefile or project file set}
    );

    # fail: invalid makefile directory
    $proj->set_makefile( '/some/directory/does/not/exist' );
    throws_ok(
        sub { $sub->() },
        qr{$ERROR_RE.*No such file or directory}
    );

    # fail: invalid makefile
    $proj->set_makefile( "$dir/Makefile.does-not-exist" );
    throws_ok(
        sub { $sub->() },
        $ERROR_RE,  # generic error because make output is platform-specific
    );

    # fail: bogus make command
    $proj->set_makefile( "$dir/Makefile" );
    $proj->set_make( 'not-a-real-make-command' );
    throws_ok(
        sub { $sub->() },
        qr{$ERROR_RE .*not-a-real-make-command}
    );
    $proj->set_make( $original_make );

    # Now do it all again with warnings instead
    $proj->set_die_on_error( 0 );

    # warn: no makefile set
    $proj->set_makefile( undef );
    warning_like(
        sub { $sub->() },
        qr{$ERROR_RE no makefile or project file set}
    );

    # warn: invalid makefile directory
    $proj->set_makefile( '/some/directory/does/not/exist' );
    warning_like(
        sub { $sub->() },
        qr{$ERROR_RE.*No such file or directory}
    );

    # warn: invalid makefile
    $proj->set_makefile( "$dir/Makefile.does-not-exist" );
    warning_like(
        sub { $sub->() },
        $ERROR_RE,  # generic error because make output is platform-specific
    );

    # warn: bogus make command
    $proj->set_makefile( "$dir/Makefile" );
    $proj->set_make( 'not-a-real-make-command' );
    warning_like(
        sub { $sub->() },
        qr{$ERROR_RE .*not-a-real-make-command}
    );
    $proj->set_make( $original_make );

    return;
}

sub test_set_qmake
{
    my ($proj) = @_;
    my $dir = "$TESTDATA/01-typical";
    local $CWD = $dir;

    if ($proj) {
        $proj->set_project_file( '.' );
    } else {
        $proj = QMake::Project->new( '.' );
    }

    $proj->set_qmake( 'quux-is-not-a-valid-command' );
    $proj->set_die_on_error( 1 );
    throws_ok {
        my $target = q{}.$proj->values( 'TARGET' );
    } qr{\AQMake::Project: .*quux-is-not-a-valid-command};

    $proj->set_qmake( find_qmake() );
    is( $proj->values( 'TARGET' ), 'myapp' );

    $proj->set_qmake( );
    is( $proj->values( 'TARGET' ), 'myapp' );

    return;
}

sub run_test
{
    unless ($QMAKE) {
        plan skip_all => 'No qmake found in PATH'; 
    }

    test_typical;
    test_default_target;
    test_list;
    test_delayed;
    test_spaces;
    test_ordering;
    test_directory_resolution;
    test_error;
    test_make_error;
    test_set_qmake;

    # Now do them all again using a single object
    my $proj = QMake::Project->new( );
    test_typical( $proj );
    test_default_target( $proj );
    test_list( $proj );
    test_delayed( $proj );
    test_spaces( $proj );
    test_ordering( $proj );
    test_error( $proj );
    test_make_error( $proj );
    test_set_qmake( $proj );

    return;
}

sub find_qmake
{
    my @qmakes = qw(qmake-qt5 qmake-qt4 qmake);
    foreach my $qmake (@qmakes) {
        if (my $found = which( $qmake )) {
            return $found;
        }
    }
    return;
}

if (!caller) {
    run_test;
    done_testing;
}
1;
