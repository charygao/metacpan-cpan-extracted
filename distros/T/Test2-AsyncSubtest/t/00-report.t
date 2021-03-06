use Test2::Tools::Basic;
use Test2::Util::Table qw/table/;

use Test2::Util qw/CAN_FORK CAN_REALLY_FORK CAN_THREAD/;

diag "\nDIAGNOSTICS INFO IN CASE OF FAILURE:\n";
diag(join "\n", table(rows => [[ 'perl', $] ]]));

diag(
    join "\n",
    table(
        header => [qw/CAPABILITY SUPPORTED/],
        rows   => [
            ['CAN_FORK',        CAN_FORK        ? 'Yes' : 'No'],
            ['CAN_REALLY_FORK', CAN_REALLY_FORK ? 'Yes' : 'No'],
            ['CAN_THREAD',      CAN_THREAD      ? 'Yes' : 'No'],
        ],
    )
);

{
    my @depends = qw{
        Test2 Test2::Suite Carp Exporter Scalar::Util Scope::Guard Time::HiRes
        threads
    };

    my @rows;
    for my $mod (sort @depends) {
        my $installed = eval "require $mod; $mod->VERSION";
        push @rows => [ $mod, $installed || "N/A" ];
    }

    my @table = table(
        header => [ 'DEPENDENCY', 'VERSION' ],
        rows => \@rows,
    );

    diag(join "\n", @table);
}

pass;
done_testing;
