# Don't filter until just before dispatch in run()

use Test::Chunks tests => 4;

eval {
    run { ok(1) };
};

like("$@", qr/Can't find a function or method for/, 'expect an error');

__END__
=== One
--- foo
xxx

=== Two
--- foo
xxx

=== Three
--- foo
xxx

=== Bad
--- foo filter_doesnt_exist_vsdyufbkhdkbjagyewkjbc
xxx

