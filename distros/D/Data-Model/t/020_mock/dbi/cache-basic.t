use t::Utils config => +{
    type   => 'Basic',
    driver => 'DBI',
    dsn    => 'dbi:SQLite:dbname=',
    cache  => 'HASH',
};
run;
