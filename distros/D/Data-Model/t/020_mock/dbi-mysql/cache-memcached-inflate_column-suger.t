use t::Utils config => +{
    type   => 'InflateColumnSuger',
    driver => 'DBI',
    dsn    => 'dbi:mysql:database=test',
    cache  => 'Memcached',
};
run;
